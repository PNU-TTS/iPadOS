//
//  BuyPopupViewController.swift
//  TTS
//
//  Created by Yujin Cha on 2022/08/28.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class BuyPopupViewController: UIViewController {
    struct Input {
        var balance: Int
        var totalAmount: Int = 100
        var price: Int = 2300
    }
    
    var input: Input
    var disposeBag = DisposeBag()
    
    let numberFormatter = NumberFormatter().then {
        $0.numberStyle = .decimal
    }
    
    lazy var titleLabel = UILabel()
    
    lazy var balanceLabel = UILabel()
    
    lazy var amountTextField = TextFieldWithDescription(
        input: TextFieldWithDescription.Input(
            title: "개수",
            initValue: "0",
            suffix: "개",
            isEnabled: true))
    lazy var priceTextField = TextFieldWithDescription(
        input: TextFieldWithDescription.Input(
            title: "개당",
            initValue: "0",
            suffix: "원",
            isEnabled: false))
    lazy var totalTextField = TextFieldWithDescription(
        input: TextFieldWithDescription.Input(
            title: "총",
            initValue: "0",
            suffix: "원",
            isEnabled: false))
    
    lazy var buyButton = UIButton()
    
    
    init(input: Input) {
        self.input = input
        super.init(nibName: nil, bundle: nil)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BuyPopupViewController {
    func setView() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(balanceLabel)
        view.addSubview(amountTextField)
        view.addSubview(priceTextField)
        view.addSubview(totalTextField)
        view.addSubview(buyButton)
        
        setAmountTextField()
        setPriceTextField()
        setTotalTextField()
        setBuyButton()
    }
    
    func setTitleLabel() {
        titleLabel.then {
            $0.text = "구매 하기"
        }.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
    }
    
    func setBalanceLabel() {
        balanceLabel.then {
            $0.text = "잔액: \(input.balance) 원"
        }.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
    }

    func setAmountTextField() {
        amountTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(500)
        }
        
        amountTextField.textField.keyboardType = .numberPad
        amountTextField.textField.rx.controlEvent([.editingChanged])
            .subscribe({ [weak self] _ in
                guard let self = self else { return }
                if let text = self.amountTextField.textField.text?.replacingOccurrences(of: ",", with: ""),
                   let value = Int(text),
                   let convertedValue = self.numberFormatter.string(from: NSNumber(value: value)) {
                    self.amountTextField.textField.text = "\(convertedValue)"
                    self.totalTextField.textField.text = self.numberFormatter.string(from: NSNumber(value: value * self.input.price))
                } else {
                    self.amountTextField.textField.text = "0"
                    self.totalTextField.textField.text = "0"
                }
            }).disposed(by: disposeBag)
    }
    
    func setPriceTextField() {
        priceTextField.textField.text = numberFormatter.string(from: NSNumber(value: input.price))
        priceTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(amountTextField.snp.bottom).offset(50)
            make.width.equalTo(500)
        }
    }
    
    func setTotalTextField() {
        totalTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceTextField.snp.bottom).offset(50)
            make.width.equalTo(500)
        }
    }
    
    func setBuyButton() {
        buyButton.then {
            $0.setTitle("구매하기", for: .normal)
            $0.backgroundColor = .systemPink
        }.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(totalTextField.snp.bottom).offset(50)
            make.width.equalTo(500)
        }
        
        buyButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                if self.totalTextField.textField.text == "0" {
                    return
                }
                if let total = Int(self.totalTextField.textField.text?.replacingOccurrences(of: ",", with: "") ?? "-") {
                    print(total)
                }
            }.disposed(by: disposeBag)
    }
}

