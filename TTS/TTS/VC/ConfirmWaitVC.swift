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

class ConfirmWaitVC: UIViewController {
    private var disposeBag = DisposeBag()
    private var viewModel = ConfirmVM()
    
    private var titleLabel = UILabel()
    
    lazy var confirmTableHeader = ConfirmHeader()
    lazy var confirmTable = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
    }
    
    func setView() {
        [titleLabel, confirmTableHeader, confirmTable].forEach {
            view.addSubview($0)
        }
        setTitle()
        setConfirmTable()
        setBinding()
    }
    
    func setTitle() {
        titleLabel.then {
            $0.text = "⏸️ 승인 대기 목록"
            $0.textColor = Const.Color.textColor
            $0.font = UIFont.systemFont(ofSize: 40.0, weight: .bold)
        }.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30.0)
            make.left.equalToSuperview().inset(10.0)
        }
    }
    
    func setConfirmTable() {
        confirmTableHeader.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(10.0)
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
                let nextVC = ConfirmCell(input: transaciton.Transaction)
                nextVC.setConfirmButtomCommand {
                    self.present(ConfirmTransactionVC(), animated: true)
                }
                self.confirmTable.addArrangedSubview(nextVC)
            }
        }).disposed(by: disposeBag)
        
    }
    
}
