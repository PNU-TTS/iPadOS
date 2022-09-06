//
//  TransactionModel.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/02.
//

import Foundation

struct TransactionModel: Decodable {
    var id: String
    
    var target: Int
    var price: Int
    var quantity: Int
    
    var registered_time: Int
    var executed_time: Int?
    
    var supplier: Int
    var buyer: Int?
}

extension TransactionModel {
    static let sampleData: String =
    """
    [
        {
            "id": "TRANSACTION_2",
            "price": 123,
            "quantity": 123,
            "registered_time": 123123,
            "executed_time": null,
            "target": 1,
            "supplier": 2,
            "buyer": null
        },
        {
            "id": "TRANSACTION_3",
            "price": 123,
            "quantity": 123,
            "registered_time": 123123,
            "executed_time": 234234,
            "target": 1,
            "supplier": 2,
            "buyer": 1
        }
    ]
    """
}
