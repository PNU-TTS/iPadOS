//
//  BaseRepository.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/08/28.
//

import Moya
import RxSwift

enum APIEnvironment {
    case test, real
}

class BaseRepository<API: TargetType> {
    
    func getProvider(mode: APIEnvironment, debug: Bool) -> MoyaProvider<API> {
        switch mode {
        case .test:
            return getRealProvider(debug)
        case .real:
            return getTestProvider(debug)
        }
    }
    
    private func getRealProvider(_ debug: Bool) -> MoyaProvider<API> {
        if debug {
            return MoyaProvider<API>(plugins: [MoyaInterceptor()])
        }
        
        return MoyaProvider<API>()

    }
    
    private func getTestProvider(_ debug: Bool) -> MoyaProvider<API> {
        let customEndpointClosure = { (target: API) -> Endpoint in
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { .networkResponse(200, target.sampleData)},
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers)
        }
        
        if debug {
            return MoyaProvider<API> (
                endpointClosure: customEndpointClosure,
                stubClosure: MoyaProvider.delayedStub(3),
                plugins: [MoyaInterceptor()])
        }
        
        return MoyaProvider<API> (
            endpointClosure: customEndpointClosure,
            stubClosure: MoyaProvider.delayedStub(3))
    }
}
