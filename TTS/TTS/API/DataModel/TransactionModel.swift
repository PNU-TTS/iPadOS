//
//  TransactionModel.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/02.
//

import Foundation

struct TransactionModel: Decodable {
    var target: Int
    var price: Int
    var quantity: Int
    
    var registered_time: String
    var executed_time: String
    
    var supplier: Int
    var buyer: Int
}
