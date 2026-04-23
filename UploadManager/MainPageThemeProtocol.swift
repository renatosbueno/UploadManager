//
//  MainPageThemeProtocol.swift
//  UploadManager
//
//  Created by Renato Bueno on 22/04/26.
//

import Foundation
import SwiftUI

enum MainPageThemeProtocolType {
    case light
    case dark
    
    var theme: MainPageThemeProtocol {
        switch self {
        case .dark:
            return MainPageDarkThemeType()
        case .light:
            return MainPageLightThemeType()
        }
    }
}

final class MainPageDarkThemeType: MainPageThemeProtocol {
    var backgroundColor: Color { .black }
    var buttonColor: Color { .gray }
    var successCheckmarkColor: Color { .green }
    var errorCheckmarkColor: Color { .red }
    var progressViewColor: Color { .white }
}

final class MainPageLightThemeType: MainPageThemeProtocol {
    var backgroundColor: Color { .white }
    var buttonColor: Color { .purple }
    var successCheckmarkColor: Color { .green }
    var errorCheckmarkColor: Color { .red }
    var progressViewColor: Color { .black }
}

protocol MainPageThemeProtocol: AnyObject {
    var backgroundColor: Color { get }
    var stackSpacing: CGFloat { get }
    var buttonColor: Color { get }
    var buttonFontWeight: Font.Weight { get }
    var selectedImageHeight: CGFloat { get }
    var selectedImageWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var successCheckmarkColor: Color { get }
    var checkmarkOffset: CGSize { get }
    var errorCheckmarkColor: Color { get }
    var progressViewColor: Color { get }
}

extension MainPageThemeProtocol {
    var stackSpacing: CGFloat { 8 }
    var buttonFontWeight: Font.Weight { .semibold }
    var selectedImageHeight: CGFloat { 100 }
    var selectedImageWidth: CGFloat { 100 }
    var cornerRadius: CGFloat { 8 }
    var checkmarkOffset: CGSize { .init(width: 35, height: -35) }
}
