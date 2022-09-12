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
    case userVerify
    
    case getSupplierInfo(id: Int)
}

extension TTSAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://192.168.0.44:8000")!
    }
    
    var path: String {
        switch self {
        case .queryAllTransactions:
            return "/query/allTransactions"
            
        case .login:
            return "/account/login/"
            
        case .userVerify:
            return "/user/"
            
        case .getSupplierInfo(let id):
            return "/powerplant/\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
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
            
        case .userVerify:
            return .requestPlain
            
        case .getSupplierInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let token = TokenDB.shared.get().key
        if token == "" {
            return [:]
        }
        return ["Authorization":"Token \(token)"]
    }
}
