//
//  TransactionIDConverter.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/06.
//

import Foundation

@propertyWrapper
struct TransactionIDConverter {
    let wrappedValue: Int
}

extension TransactionIDConverter: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)

        guard let status = Int(status ?? "") else {
            throw DecodingError.valueNotFound
        }
        wrappedValue = status
    }
}
