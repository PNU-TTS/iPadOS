//
//  ConfirmViewController.swift
//  TTS
//
//  Created by 안현주 on 2022/09/08.
//

import UIKit
import Then
import SnapKit
import RxSwift

class ConfirmVC: UIViewController {
    
    private var viewModel = ConfirmVM()
    private var disposeBag = DisposeBag()
    
    lazy var confirmTableHeader = ConfirmHeader()
    lazy var confirmTable = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
    }
    
    func setView() {
        [confirmTableHeader, confirmTable].forEach {
            view.addSubview($0)
        }
        setConfirmTable()
        setBinding()
    }
    
    func setConfirmTable() {
        confirmTableHeader.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10.0)
            make.top.equalToSuperview().offset(100)
        }
        
        confirmTable.then {
            $0.axis = .vertical
            $0.spacing = 1.0
            $0.backgroundColor = .lightGray.withAlphaComponent(0.5)
        }.snp.makeConstraints { make in
            make.left.right.equalTo(confirmTableHeader)
            make.top.equalTo(confirmTableHeader.snp.bottom)
        }
    }
    
    func setBinding() {
        let output = viewModel.transform(input: ConfirmVM.Input(id: 1))
        
        
        output.transactions.subscribe(onNext: { transactions in
            transactions.forEach { transaciton in
                self.confirmTable.addArrangedSubview(ConfirmCell(input: transaciton.Transaction))
            }
        }).disposed(by: disposeBag)
        
    }
    
}
