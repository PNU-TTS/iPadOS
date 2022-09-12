//
//  TradeVC.swift
//  TTS
//
//  Created by 안현주 on 2022/09/08.
//

import UIKit
import Then
import SnapKit
import RxSwift

class TradeVC: UIViewController {
    
    private var viewModel = ConfirmVM()
    private var disposeBag = DisposeBag()
    
    lazy var tradeTableHeader = TradeHeader()
    lazy var tradeTable = UIScrollView()
    lazy var stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setView()
        setBinding()

        // Do any additional setup after loading the view.
    }
    

    func setView() {
        [tradeTableHeader, tradeTable].forEach {
            view.addSubview($0)
        }
        setTradeTable()
    }
    
    func setTradeTable() {
        tradeTableHeader.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10.0)
            make.top.equalToSuperview().offset(100)
        }
        
        tradeTable.addSubview(stackView)
        
        tradeTable.snp.makeConstraints { make in
            make.left.right.equalTo(tradeTableHeader)
            make.top.equalTo(tradeTableHeader.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        stackView.then {
            $0.axis = .vertical
            $0.spacing = 1.0
            $0.backgroundColor = .lightGray.withAlphaComponent(0.5)
        }.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setBinding() {
        let output = viewModel.transform(input: ConfirmVM.Input(id: 1))
        
        
        output.transactions.subscribe(onNext: { transactions in
            transactions.forEach { transaciton in
                self.stackView.addArrangedSubview(TradeCell(input: transaciton.Transaction))
            }
        }).disposed(by: disposeBag)
        
    }

}
