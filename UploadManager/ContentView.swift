//
//  ContentView.swift
//  UploadManager
//
//  Created by Renato Bueno on 14/04/26.
//

import SwiftUI
import PhotosUI

struct ImageItem: Identifiable {
    let id = UUID()
    let image: UIImage
}

struct ContentView: View {
    @State private var selectedPhotos = [PhotosPickerItem]()
    @State private var presentPhotosPicker: Bool = false
    @State private var shouldChangeTheme: Bool = false
    
    @StateObject private var imageHandler = ImageHandler()
    @StateObject private var viewModel = ViewModel()
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var theme: MainPageThemeProtocol {
        switch colorScheme {
        case .dark:
            return MainPageThemeProtocolType.dark.theme
        case .light:
            return MainPageThemeProtocolType.light.theme
        @unknown default:
            return MainPageThemeProtocolType.light.theme
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: theme.stackSpacing) {
                Button(Constants.selectPhotoTitle) {
                    presentPhotosPicker = true
                }
                .fontWeight(theme.buttonFontWeight)
                .tint(theme.buttonColor)
                
                Image(systemName: "square.and.arrow.up.circle")
                    .imageScale(.large)
                
                if !imageHandler.selectedImages.isEmpty {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.items) { item in
                                UploadItemView(item: item, theme: theme)
                            }
                        }
                    }
                }
                
                Button(Constants.buttonTitle) {
                    viewModel.uploadWithLimit()
                }
                .disabled(imageHandler.selectedImages.isEmpty)
                .buttonStyle(.borderedProminent)
                .tint(theme.buttonColor)
            }
            .tint(theme.backgroundColor)
            .padding()
            .photosPicker(
                isPresented: $presentPhotosPicker,
                selection: $selectedPhotos
            )
            .onChange(of: selectedPhotos) { newItems in
                imageHandler.loadImages(from: newItems)
            }
            .onReceive(imageHandler.$selectedImages) { images in
                viewModel.setImages(images.map { $0.image })
            }
        }
    }
}
extension ContentView {
    private struct Constants {
        static let selectPhotoTitle = "Select Photo"
        static let buttonTitle = "Upload"
    }
}

#Preview {
    ContentView()
}
