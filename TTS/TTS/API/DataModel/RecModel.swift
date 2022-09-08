//
//  RECModel.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/08.
//

import Foundation

struct RecModel: Decodable {
    struct InnerModel: Decodable {
        var id: String
        var supplier: String
        @IntWrapper var quantity: Int
        var is_jeju: Bool
        var supplyDate: Int
        var expireDate: Int
    }
    var Transaction: InnerModel
}

extension RecModel {
    static let sampleData: String =
    """
    [
        {"Transaction": {
            "id": "CERTIFICATE_123",
            "supplier": "1",
            "quantity": "100",
            "is_jeju": true,
            "supplyDate": 2736262,
            "expireDate": 3838243
        }},
        {"Transaction": {
            "id": "CERTIFICATE_456",
            "supplier": "1",
            "quantity": "100",
            "is_jeju": false,
            "supplyDate": 2736262,
            "expireDate": 3838243
        }}
    ]
    """
}
