//
//  FabricAPI.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/06.
//

import Moya

enum FabricAPI {
    case executeTransaction(input: ExecuteTransactionModel)
    case queryTransactionByID(id: Int)
    case queryAllTransactions
    case queryUnexecutedTransactions
    case queryExecutedTransactions
    case queryTransactionBySupplier(input: QueryBySupplierModel)
    case queryTransactionByBuyer(input: QueryByBuyerModel)
}

extension FabricAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://test.com")!
    }
    
    var path: String {
        switch self {
        case .executeTransaction:
            return "/executeTransaction/"
            
        case .queryTransactionByID(let id):
            return "/query/transaction/\(id)"
            
        case .queryAllTransactions:
            return "/query/allTransactions/"
            
        case .queryUnexecutedTransactions:
            return "/queryUnexecutedTransactions/"
            
        case .queryExecutedTransactions:
            return "/query/executedTransactions/"
            
        case .queryTransactionBySupplier:
            return "/query/transaction/by-supplier/"
            
        case .queryTransactionByBuyer:
            return "/query/transaction/by-buyer/"
        }
    }
    
    var method: Method {
        switch self {
        case .executeTransaction, .queryTransactionBySupplier, .queryTransactionByBuyer:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .queryAllTransactions, .queryTransactionBySupplier, .queryTransactionByBuyer:
            return Data(TransactionModel.sampleData.utf8)
            
        default:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .executeTransaction(let input):
            return .requestJSONEncodable(input)
            
        case .queryTransactionByID:
            return .requestPlain
            
        case .queryAllTransactions:
            return .requestPlain
            
        case .queryUnexecutedTransactions:
            return .requestPlain
            
        case .queryExecutedTransactions:
            return .requestPlain
            
        case .queryTransactionBySupplier(let input):
            return .requestJSONEncodable(input)
            
        case .queryTransactionByBuyer(let input):
            return .requestJSONEncodable(input)
        }
    }
    
    var headers: [String: String]? {
        return [:]
    }
}
