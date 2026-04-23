//
//  UploadItemView.swift
//  UploadManager
//
//  Created by Renato Bueno on 22/04/26.
//

import SwiftUI

struct UploadItemView: View {
    
    let item: UploadItem
    let theme: MainPageThemeProtocol
    
    var body: some View {
        ZStack(alignment: .bottom) {
            imageView
            if item.status == .uploading {
                progressView
            }
            
            if item.status == .success {
                successView
            }
            
            if item.status == .failed {
                errorView
            }
        }
    }
}
extension UploadItemView {
    private var imageView: some View {
        Image(uiImage: item.image)
            .resizable()
            .scaledToFill()
            .frame(width: theme.selectedImageWidth,
                   height: theme.selectedImageHeight)
            .clipped()
            .cornerRadius(theme.cornerRadius)
    }
    
    private var progressView: some View {
        ProgressView(value: item.progress)
            .progressViewStyle(.linear)
            .frame(width: theme.selectedImageWidth)
            .background(theme.progressViewColor.opacity(0.3))
    }
    
    private var successView: some View {
        Image(systemName: "checkmark.circle.fill")
            .foregroundColor(theme.successCheckmarkColor)
            .background(theme.backgroundColor)
            .clipShape(Circle())
            .offset(x: theme.checkmarkOffset.width,
                    y: theme.checkmarkOffset.height)
    }
    
    private var errorView: some View {
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(theme.errorCheckmarkColor)
            .offset(x: theme.checkmarkOffset.width,
                    y: theme.checkmarkOffset.height)
    }
}

#Preview {
    UploadItemView(item: UploadItem(image: UIImage(named: "pencil") ?? UIImage()), theme: MainPageThemeProtocolType.light.theme)
}
