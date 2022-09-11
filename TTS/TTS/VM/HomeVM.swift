//
//  HomeVM.swift
//  TTS
//
//  Created by 안현주 on 2022/09/11.
//

import RxSwift
import RxRelay

struct HomeVM: BasicVM {
    internal var disposeBag = DisposeBag()
    private let transactionRepo = TransactionRepository()
    private let chartRepo = ChartRepository()
    
    let data = PublishRelay<ChartModel>()
    
    struct Input {
        let isDailyTapped: Observable<UITapGestureRecognizer>
        let isWeeklyTapped: Observable<UITapGestureRecognizer>
        let isMonthlyTapped: Observable<UITapGestureRecognizer>
    }
    
    struct Output {
        var transactions: Observable<[TransactionModel]>
        var chartData: Observable<ChartModel>
    }
    
    func transform(input: Input) -> Output {
        
        input.isDailyTapped
            .subscribe { _ in
                getData(type: 0)
            }.disposed(by: disposeBag)
        
        input.isWeeklyTapped
            .subscribe { _ in
                getData(type: 1)
            }.disposed(by: disposeBag)
        
        input.isMonthlyTapped
            .subscribe { _ in
                getData(type: 2)
            }.disposed(by: disposeBag)
        
        return Output(
            transactions: transactionRepo.getAllTransactions().asObservable(),
            chartData: data.asObservable()
        )
    }
    
    func getData(type: Int) {
        chartRepo.getChartData(type: type)
            .subscribe(onSuccess: { ChartModel in
                self.data.accept(ChartModel)
            }).disposed(by: disposeBag)
    }
}
