//
//  ConfirmVM.swift
//  TTS
//
//  Created by 안현주 on 2022/09/08.
//

import RxSwift
import RxRelay

struct ConfirmVM: BasicVM {
    internal var disposeBag = DisposeBag()
    private let repository = TransactionRepository()
    
    struct Input {
        var id: Int
    }
    
    struct Output {
        var transactions: Observable<[TransactionModel]>
    }
    
    func transform(input: Input) -> Output {
        return Output(transactions: repository.getNotConfirmedBySupplier(supplier: input.id).asObservable())
    }
}

