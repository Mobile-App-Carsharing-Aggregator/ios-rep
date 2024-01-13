//
//  ProfileMenu.swift
//  Carsharing Aggregator
//
//  Created by Vitaly Anpilov on 13.01.2024.
//

import UIKit

enum ProfileMenuItem: CaseIterable {
    case MyMarks
    case SearchHistory
    case Settings
    case Logout
    case DeleteAccount
    
    var color: UIColor {
        switch self {
        case .MyMarks:
            return .carsharing.black
        case .SearchHistory:
            return .carsharing.black
        case .Settings:
            return .carsharing.black
        case .Logout:
            return .carsharing.black
        case .DeleteAccount:
            return .carsharing.red
        }
    }
    
    var image: UIImage {
        switch self {
        case .MyMarks:
            return .starItemMenu ?? UIImage()
        case .SearchHistory:
            return .listItemMenu ?? UIImage()
        case .Settings:
            return .settingsItemMenu ?? UIImage()
        case .Logout:
            return .exitItemMenu ?? UIImage()
        case .DeleteAccount:
            return .deleteItemMenu ?? UIImage()
        }
    }
    
    var label: String {
        switch self {
        case .MyMarks:
            return "Отзывы"
        case .SearchHistory:
            return "История поиска"
        case .Settings:
            return "Настройки"
        case .Logout:
            return "Выйти из аккаунта"
        case .DeleteAccount:
            return "Удалить аккаунт"
        }
    }
    
    var transferButton: Bool {
        switch self {
        case .MyMarks:
            return true
        case .SearchHistory:
            return true
        case .Settings:
            return true
        case .Logout:
            return false
        case .DeleteAccount:
            return false
        }
    }
    
}
