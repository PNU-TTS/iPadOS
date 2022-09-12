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
            "registeredDate": 1662967283,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662967283,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662967283,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662967283,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662967283,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662967283,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662967283,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662880883,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662880883,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662880883,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662880883,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662880883,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662880883,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662880883,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "123",
            "quantity": "123",
            "registeredDate": 1662794483,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "24123",
            "quantity": "123",
            "registeredDate": 1662794483,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "24123",
            "quantity": "123",
            "registeredDate": 1662794483,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "100000",
            "quantity": "123",
            "registeredDate": 1660116083,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
        { "Transaction": {
            "id": "TRANSACTION_2",
            "price": "100000",
            "quantity": "123",
            "registeredDate": 1660116083,
            "executedDate": null,
            "target": "CERTIFICATE_23782374",
            "supplier": "2",
            "buyer": null,
            "is_confirmed": false
        }},
    
      
    ]
    """
}
