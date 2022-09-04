//
//  LoginRepository.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/02.
//

import Moya
import RxSwift

class LoginRepository: BaseRepository<TTSAPI> {
    
    func login(input: LoginModel) -> Single<TokenModel> {
        return getProvider(mode: .test, debug: true).rx
            .request(.login(input: input))
            .map(TokenModel.self)
    }
    
}
