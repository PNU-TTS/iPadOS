//
//  TransactionModel.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/02.
//

import Foundation

struct TransactionModel: Decodable {
    struct InnerModel: Decodable {
        var id: String
        
        var target: String
        @IntWrapper var price: Int
        @IntWrapper var quantity: Int
        
        var registeredDate: Int
        var executedDate: Int?
        
        var supplier: String
        var buyer: String?
        
        var is_confirmed: Bool
    }
    var Transaction: InnerModel
}

extension TransactionModel {
    static let sampleData: String =
    """
    [
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 123123,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_3",
            "price": "123",
            "quantity": "123",
            "registeredDate": 123123,
            "executedDate": 234234,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": "1",
            "is_confirmed": true
        }}
    ]
    """
}
