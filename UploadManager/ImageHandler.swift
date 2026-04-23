//
//  ImageHandler.swift
//  UploadManager
//
//  Created by Renato Bueno on 14/04/26.
//

import SwiftUI
import PhotosUI
internal import Combine

final class ImageHandler: ObservableObject {
    @Published var selectedImages = [ImageItem]()
    
    func loadImages(from items: [PhotosPickerItem]) {
        selectedImages.removeAll()
        items.forEach { item in
            Task {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    await MainActor.run { [weak self] in
                        self?.selectedImages.append(ImageItem(image: uiImage))
                    }
                }
            }
        }
    }
}
