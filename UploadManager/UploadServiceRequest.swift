//
//  UploadServiceRequest.swift
//  UploadManager
//
//  Created by Renato Bueno on 23/04/26.
//

import UIKit
internal import Combine

protocol UploadServiceProtocol: AnyObject {
    func upload(image: UIImage) async throws
}

final class UploadServiceRequest: UploadServiceProtocol {
    func upload(image: UIImage) async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }
}
