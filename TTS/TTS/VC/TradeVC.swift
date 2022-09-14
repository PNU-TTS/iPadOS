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
    
    private var viewModel = TradeVM()
    private var disposeBag = DisposeBag()
    private var repository = SupplierRepository()
    
    private var titleLabel = UILabel()
    private var tradeTableHeader = TradeHeader()
    private var tradeTable = UIScrollView()
    private var stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Const.Color.backgroundColor
        
        setView()
    }
    

    func setView() {
        [titleLabel, tradeTableHeader, tradeTable].forEach {
            view.addSubview($0)
        }
        setTitle()
        setTradeTable()
        setBinding()
    }
    
    func setTitle() {
        titleLabel.then {
            $0.text = "📈 거래 시장"
            $0.font = UIFont.systemFont(ofSize: 40.0, weight: .bold)
            $0.textColor = Const.Color.textColor
        }.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30.0)
            make.left.equalToSuperview().inset(10.0)
        }
    }
    
    func setTradeTable() {
        tradeTableHeader.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
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
        let output = viewModel.transform(input: TradeVM.Input())
        
        output.transactions.subscribe(onNext: { transactions in
            transactions.forEach { transaction in
                let data = transaction.Transaction
                
                let supplierInfo = self.repository.getSupplierInfo(id: Int(data.supplier)!).asObservable()
                
                supplierInfo.subscribe(onNext: { supplier in
                        let cell = TradeCell(input: data, supplier: supplier.name)
                        cell.setBuyButtonCommand { input in
                            let nextVC = RecBuyVC(input: input)
                            self.present(nextVC, animated: true)
                        }
                        self.stackView.addArrangedSubview(cell)
                }).disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)
    }
}
