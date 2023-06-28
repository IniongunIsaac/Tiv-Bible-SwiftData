//
//  ToastMessage.swift
//  TivBible
//
//  Created by Isaac Iniongun on 28/06/2023.
//

import Foundation
import AlertToast

enum ToastType {
    case success
    case error
    case `none`
}

struct ToastMessage: Equatable {
    let type: ToastType
    let message: String
    
    var alertType: AlertToast.AlertType {
        type == .success ? .complete(.systemGreen) : .error(.systemRed)
    }
}

extension ToastMessage {
    static let empty = ToastMessage(type: .none, message: "")
    static func success(_ message: String) -> ToastMessage { ToastMessage(type: .success, message: message) }
    static func error(_ message: String) -> ToastMessage { ToastMessage(type: .error, message: message) }
}
