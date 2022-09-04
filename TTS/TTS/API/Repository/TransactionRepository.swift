//
//  TransactionRepository.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/02.
//

import Moya
import RxSwift

class TransactionRepository: BaseRepository<TTSAPI> {
    
    func getAllTransactions() -> Single<[TransactionModel]>{
        return getProvider(mode: .test, debug: false).rx
            .request(.queryAllTransactions)
            .map([TransactionModel].self)
    }
    
}

