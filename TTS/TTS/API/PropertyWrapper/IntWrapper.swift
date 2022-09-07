//
//  IntWrapper.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/07.
//

import Foundation

@propertyWrapper
struct IntWrapper {
    let wrappedValue: Int
}

extension IntWrapper: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try? container.decode(String.self)
        
        guard let value = value else {
            throw DecodingError.valueNotFound
        }
        
        wrappedValue = Int(value) ?? -1
    }
}
