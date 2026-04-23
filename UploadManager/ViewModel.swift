//
//  ViewModel.swift
//  UploadManager
//
//  Created by Renato Bueno on 14/04/26.
//

import UIKit
internal import Combine

enum UploadStatus {
    case pending
    case uploading
    case success
    case failed
}

struct UploadItem: Identifiable {
    let id = UUID()
    let image: UIImage
    var progress: Double = 0
    var status: UploadStatus = .pending
}

final class ViewModel: ObservableObject {
    
    @Published var items: [UploadItem] = []
    private var uploadService: UploadServiceProtocol
    
    init(uploadService: UploadServiceProtocol = UploadServiceRequest()) {
        self.uploadService = uploadService
    }
    
    func setImages(_ images: [UIImage]) {
        self.items = images.map { UploadItem(image: $0) }
    }
}
extension ViewModel {
    func upload(item: UploadItem) async {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        
        await MainActor.run {
            items[index].status = .uploading
        }
        
        do {
            try await uploadService.upload(image: item.image)
            
            await MainActor.run {
                items[index].progress = 1.0
                items[index].status = .success
            }
            
        } catch {
            await MainActor.run {
                items[index].status = .failed
            }
        }
    }
    
    func uploadWithLimit(maxConcurrent: Int = 2) {
        Task {
            var iterator = items.makeIterator()
            
            await withTaskGroup(of: Void.self) { group in
                for _ in 0..<maxConcurrent {
                    if let item = iterator.next() {
                        group.addTask { await self.upload(item: item) }
                    }
                }
                
                while let _ = await group.next() {
                    if let nextItem = iterator.next() {
                        group.addTask {
                            await self.upload(item: nextItem)
                        }
                    }
                }
            }
        }
    }
}
