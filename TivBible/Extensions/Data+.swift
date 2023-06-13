//
//  Data+.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation

func jsonData(from fileName: String) -> Data? {
    guard let jsonURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        return nil
    }
    return try? Data(contentsOf: jsonURL)
}

extension Data {
    func decode<T: Codable>(into objectType: T.Type) throws -> T? {
        try JSONDecoder().decode(objectType.self, from: self)
    }
}
