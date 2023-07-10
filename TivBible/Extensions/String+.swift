//
//  String+.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import Foundation
import UIKit

extension String {
    var cleanVerse: String {
        components(separatedBy: .whitespacesAndNewlines).joined(separator: " ")
    }
    
    func share() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("Unable to share!!!")
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        activityViewController.modalPresentationStyle = .popover
        activityViewController.popoverPresentationController?.sourceView = rootViewController.view
        rootViewController.present(activityViewController, animated: true, completion: nil)
    }
    
    func copyToClipboard() {
        UIPasteboard.general.string = self
    }
    
    func insensitiveContains(_ value: String) -> Bool {
        lowercased().localizedCaseInsensitiveContains(value.lowercased())
    }
    
    func insensitiveEquals(_ value: String) -> Bool {
        lowercased() == value.lowercased()
    }
}
