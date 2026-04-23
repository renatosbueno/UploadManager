//
//  ViewModelTests.swift
//  ViewModelTests
//
//  Created by Renato Bueno on 14/04/26.
//

import XCTest
@testable import UploadManager

private class MockUploadService: UploadServiceProtocol {
    var shouldFail = false
    
    func upload(image: UIImage) async throws {
        if shouldFail {
            throw NSError(domain: "test", code: 1)
        }
    }
}

@MainActor
final class ViewModelTests: XCTestCase {

    func testUploadSuccess() async {
        let mock = MockUploadService()
        mock.shouldFail = false
        let viewModel = ViewModel(uploadService: mock)
        
        let image = UIImage(systemName: "star")!
        viewModel.setImages([image])
        
        guard let item = viewModel.items.first else {
            XCTFail("item is nil")
            return
        }
        
        await viewModel.upload(item: item)
        
        XCTAssertEqual(viewModel.items.first?.status, .success)
        XCTAssertEqual(viewModel.items.first?.progress, 1.0)
    }
    
    func testUploadFailure() async {
        let mock = MockUploadService()
        mock.shouldFail = true
        
        let viewModel = ViewModel(uploadService: mock)
        
        let image = UIImage(systemName: "star")!
        viewModel.setImages([image])
        
        guard let item = viewModel.items.first else {
            XCTFail("item is nil")
            return
        }
        
        await viewModel.upload(item: item)
        
        XCTAssertEqual(viewModel.items.first?.status, .failed)
    }
}
