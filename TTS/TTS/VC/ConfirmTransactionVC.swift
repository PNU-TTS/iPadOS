//
//  ConfirmTransactionVC.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/11.
//

import UIKit
import LocalAuthentication

import RxSwift
import RxGesture
import Then
import SnapKit

extension ConfirmTransactionVC {
    static let spacing: CGFloat = 10.0
    
    static let buttonHeight: CGFloat = 50.0
}

class ConfirmTransactionVC: UIViewController {
    private var disposeBag = DisposeBag()
    private var authContext = LAContext()
    
    private var titleLabel = UILabel()
    
    private var transactionDate: ConfirmTransactionCell
    private var executedDate: ConfirmTransactionCell
    private var buyerInfo: ConfirmTransactionCell
    private var pricePerRec: ConfirmTransactionCell
    private var transactionVolume: ConfirmTransactionCell
    private var totalPrice: ConfirmTransactionCell
    private var bankAccount: ConfirmTransactionCell
    
    private var confirmButton = UIButton()
    
    private var stackView = UIStackView()
    
    init() {
        transactionDate = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(
            title: "거래 등록 일시",
            content: "2022년 01월 01일 19:02:34"))
        
        executedDate = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(
            title: "거래 완료 일시",
            content: "2022년 01월 02일 19:02:34"))
        
        buyerInfo = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(title: "구매자", content: "한국 전력"))
        
        pricePerRec = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(title: "인증서 개당 가격", content: "26,323 원"))
        
        transactionVolume = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(title: "거래 수량", content: "1,242 개"))
        
        totalPrice = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(title: "총 거래 대금", content: "2,312,463 원"))
        
        bankAccount = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(title: "입금 계좌", content: "부산은행 112-3723-4838-47"))
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Const.Color.backgroundColor
        [titleLabel, stackView, confirmButton].forEach {
            self.view.addSubview($0)
        }
        
        setView()
    }
    
    func setView() {
        setTitle()
        setStackView()
        setConfirmButton()
    }
    
    func setTitle() {
        titleLabel.then {
            $0.text = "거래 내역서"
            $0.font = UIFont.systemFont(ofSize: 40.0, weight: .bold)
            $0.textColor = Const.Color.textColor
        }.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30.0)
            make.centerX.equalToSuperview()
        }
    }
    
    func setStackView() {
        [transactionDate, executedDate, buyerInfo, pricePerRec, transactionVolume, totalPrice, bankAccount].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.then {
            $0.axis = .vertical
            $0.spacing = 1.0
        }.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(10.0)
        }
    }
    
    func setConfirmButton() {
        confirmButton.then {
            $0.setTitle("승인하기", for: .normal)
            $0.titleLabel?.textColor = .white
            $0.backgroundColor = Const.Color.primary
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
            $0.layer.cornerRadius = 12.0
        }.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(15.0)
            make.height.equalTo(ConfirmTransactionVC.buttonHeight)
        }
        
        confirmButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "인증", reply: { (success, error) in
                    if !success { return }
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                })
            }).disposed(by: disposeBag)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
