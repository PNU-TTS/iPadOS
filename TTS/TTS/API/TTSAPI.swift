//
//  TTSAPI.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/08/28.
//

import Moya

enum TTSAPI {
    case queryAllTransactions
    case login(input: LoginModel)
}

extension TTSAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:8000")!
    }
    
    var path: String {
        switch self {
        case .queryAllTransactions:
            return "/query/allTransactions"
        case .login:
            return "/account/login/"
        }
    }
    
    var method: Method {
        switch self {
        case .queryAllTransactions:
            return .get
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .login:
            return Data(TokenModel.sampleData.utf8)
        default:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .queryAllTransactions:
            return .requestPlain
        case .login(let input):
            return .requestJSONEncodable(input)
        }
    }
    
    var headers: [String : String]? {
        let token = TokenDB.shared.get().key
        if token == "" {
            return [:]
        }
        return ["Authentication":"Token \(token)"]
    }
}
