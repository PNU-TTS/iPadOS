//
//  BalanceVCX.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/04.
//

import UIKit

import RxSwift
import Then
import SnapKit

extension SupplierInfoVC {
    static let balanceViewHeight: CGFloat = 110
    static let balanceViewWidth: CGFloat = 200
    
}

class SupplierInfoVC: UIViewController {
    private var disposeBag = DisposeBag()
    
    private var balanceView = BalanceView()
    private var recSoldView = RecSoldView()
    
    private var transactionHeader = TransactionHeader()
    private var transactionTable = UIStackView()
    
    private var viewModel = SupplierInfoVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
    }
    
    func setView() {
        [balanceView, recSoldView, transactionHeader, transactionTable].forEach {
            view.addSubview($0)
        }
        setBalanceView()
        setRecSoldView()
        setTransactionTable()
        setBinding()
    }
    
    func setBalanceView() {
        balanceView.snp.makeConstraints { make in
            make.left.top.equalTo(view.safeAreaLayoutGuide).offset(10.0)
            make.height.equalTo(SupplierInfoVC.balanceViewHeight)
            make.width.equalTo(SupplierInfoVC.balanceViewWidth)
        }
    }
    
    func setRecSoldView() {
        recSoldView.snp.makeConstraints { make in
            make.left.equalTo(balanceView.snp.right).offset(10.0)
            make.top.equalTo(balanceView)
            make.height.equalTo(SupplierInfoVC.balanceViewHeight)
            make.width.equalTo(SupplierInfoVC.balanceViewWidth)
        }
    }
    
    func setTransactionTable() {
        transactionHeader.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10.0)
            make.top.equalTo(balanceView.snp.bottom).offset(30.0)
        }
        
        transactionTable.then {
            $0.axis = .vertical
            $0.spacing = 1.0
            $0.backgroundColor = .lightGray.withAlphaComponent(0.5)
        }.snp.makeConstraints { make in
            make.left.right.equalTo(transactionHeader)
            make.top.equalTo(transactionHeader.snp.bottom)
        }

    }
    
    func setBinding() {
        let output = viewModel.transform(input: SupplierInfoVM.Input(id: 1))
        
        output.transactions.subscribe(onNext: { transactions in
            transactions.forEach { transaciton in
                self.transactionTable.addArrangedSubview(TransactionCell(input: transaciton))
            }
        }).disposed(by: disposeBag)
    }
}
