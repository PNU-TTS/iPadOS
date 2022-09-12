//
//  TransactionRepository.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/02.
//

import Moya
import RxSwift

class TransactionRepository: BaseRepository<FabricAPI> {
    
    func getAllTransactions() -> Single<[TransactionModel]> {
        return getProvider(mode: .test, debug: false).rx
            .request(.queryAllTransactions)
            .map([TransactionModel].self)
    }
    
    func getTransactionBySupplier(supplier: Int) -> Single<[TransactionModel]> {
        return getProvider(mode: .test, debug: true).rx
            .request(.queryTransactionBySupplier(input: QueryBySupplierModel(supplier: supplier)))
            .map([TransactionModel].self)
    }
    
    func getNotConfirmedBySupplier(supplier: Int) -> Single<[TransactionModel]> {
        return getProvider(mode: .test, debug: true).rx
            .request(.queryNotConfirmedBySupplier(input: QueryBySupplierModel(supplier: supplier)))
            .map([TransactionModel].self)
    }
    
    func getNotConfirmedByBuyer(buyer: Int) -> Single<[TransactionModel]> {
        return getProvider(mode: .test, debug: true).rx
            .request(.queryNotConfirmedByBuyer(input: QueryByBuyerModel(buyer: buyer)))
            .map([TransactionModel].self)
    }
}

