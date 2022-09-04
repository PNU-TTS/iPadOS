//
//  SellVC.swift
//  TTS
//
//  Created by Yujin Cha on 2022/09/04.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

extension SellVC {
    static let horizontalInset: CGFloat = 20.0
}

class SellVC: UIViewController {
    struct Input {
        var recBalance: Int
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
            isEnabled: true))
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

extension SellVC {
    func setView() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(balanceLabel)
        view.addSubview(amountTextField)
        view.addSubview(priceTextField)
        view.addSubview(totalTextField)
        view.addSubview(buyButton)
        
        setTitleLabel()
        setBalanceLabel()
        
        setAmountTextField()
        setPriceTextField()
        setTotalTextField()
        setBuyButton()
    }
    
    func setTitleLabel() {
        titleLabel.then {
            $0.text = "판매 등록"
            $0.font = UIFont.boldSystemFont(ofSize: 20)
        }.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    func setBalanceLabel() {
        balanceLabel.then {
            $0.text = "보유 REC: \(input.recBalance) 개"
        }.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(BuyPopupViewController.horizontalInset)
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
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
                if let amountText = self.amountTextField.textField.text?.replacingOccurrences(of: ",", with: ""),
                   let amount = Int(amountText),
                   let convertedAmount = self.numberFormatter.string(from: NSNumber(value: amount)),
                   let priceText = self.priceTextField.textField.text?.replacingOccurrences(of: ",", with: ""),
                   let price = Int(priceText) {
                    
                    if amount > self.input.recBalance {
                        guard let maxAmount = self.numberFormatter.string(from: NSNumber(value: self.input.recBalance)) else {
                            self.setDefault()
                            return
                        }
                        self.amountTextField.textField.text = "\(maxAmount)"
                        self.totalTextField.textField.text = self.numberFormatter.string(from: NSNumber(value: self.input.recBalance * price))
                        return
                    }
                    
                    self.amountTextField.textField.text = "\(convertedAmount)"
                    self.totalTextField.textField.text = self.numberFormatter.string(from: NSNumber(value: amount * price))
                } else {
                    self.setDefault()
                }
            }).disposed(by: disposeBag)
    }
    
    func setPriceTextField() {
        priceTextField.textField.text = "0"
        priceTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(amountTextField.snp.bottom).offset(50)
            make.width.equalTo(500)
        }
        
        priceTextField.textField.keyboardType = .numberPad
        priceTextField.textField.rx.controlEvent([.editingChanged])
            .subscribe({ [weak self] _ in
                guard let self = self else { return }
                if let amountText = self.amountTextField.textField.text?.replacingOccurrences(of: ",", with: ""),
                   let amount = Int(amountText),
                   let priceText = self.priceTextField.textField.text?.replacingOccurrences(of: ",", with: ""),
                   let price = Int(priceText),
                   let convertedPrice = self.numberFormatter.string(from: NSNumber(value: price)) {
                    self.priceTextField.textField.text = "\(convertedPrice)"
                    self.totalTextField.textField.text = self.numberFormatter.string(from: NSNumber(value: amount * price))
                } else {
                    self.setDefault()
                }
            }).disposed(by: disposeBag)
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
            $0.setTitle("등록하기", for: .normal)
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
    
    func setDefault() {
        amountTextField.textField.text = "0"
        priceTextField.textField.text = "0"
        totalTextField.textField.text = "0"
    }
}

