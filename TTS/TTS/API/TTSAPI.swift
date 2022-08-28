//
//  TTSAPI.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/08/28.
//

import Moya

enum TTSAPI {
    case queryAllTransactions
}

extension TTSAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://test.com")!
    }
    
    var path: String {
        switch self {
        case .queryAllTransactions:
            return "/query/allTransactions"
        }
    }
    
    var method: Method {
        switch self {
        case .queryAllTransactions:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .queryAllTransactions:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
