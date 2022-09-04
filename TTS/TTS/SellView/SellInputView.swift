//
//  SellInputView.swift
//  TTS
//
//  Created by Yujin Cha on 2022/09/04.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

extension SellInputView {
    static let horizontalInset: CGFloat = 20.0
    static let verticalOffset: CGFloat = 20.0
    static let buttonHeight: CGFloat = 75.0
}

class SellInputView: UIView {
    struct Input {
        var recBalance: Int
    }
    
    var input: Input
    var disposeBag = DisposeBag()
    
    let numberFormatter = NumberFormatter().then {
        $0.numberStyle = .decimal
    }
    
    var stackView = UIStackView()
    
    var balanceView: BalanceView
    
    lazy var label = UILabel()
    
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
        balanceView = BalanceView()
        
        super.init(frame: .zero)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SellInputView {
    func setView() {
        backgroundColor = .white
        
        addSubview(stackView)
        addSubview(balanceView)
        addSubview(buyButton)
        
        setStackView()
        
        setBalanceView()
        setBuyButton()
    }
    
    func setStackView() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(priceTextField)
        stackView.addArrangedSubview(totalTextField)
        
        stackView.then {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = SellInputView.verticalOffset
            $0.alignment = .center
        }.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalToSuperview().inset(SellInputView.horizontalInset)
        }
        
        stackView.arrangedSubviews.forEach { textField in
            textField.snp.makeConstraints { make in
                make.width.equalToSuperview()
            }
        }
        
        setLabel()
        setAmountTextField()
        setPriceTextField()
    }
    
    func setLabel() {
        _ = label.then {
            $0.text = "정보 입력"
            $0.textAlignment = .center
            $0.textColor = .systemOrange
            $0.backgroundColor = .systemYellow.withAlphaComponent(0.3)
            $0.font = UIFont.systemFont(ofSize: Const.Font.veryBig, weight: .bold)
        }
    }
    
    func setAmountTextField() {
        amountTextField.textField.keyboardType = .numberPad
        
        amountTextField.textField.rx.controlEvent([.editingChanged])
            .subscribe({ [weak self] _ in
                self?.setTextsByAmount()
            }).disposed(by: disposeBag)
    }
    
    func setPriceTextField() {
        priceTextField.textField.keyboardType = .numberPad
        
        priceTextField.textField.rx.controlEvent([.editingChanged])
            .subscribe({ [weak self] _ in
                self?.setTextsByPrice()
            }).disposed(by: disposeBag)
    }
    
    func setBalanceView() {
        balanceView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(SellInputView.horizontalInset)
            make.height.equalTo(SupplierInfoVC.balanceViewHeight)
            make.width.equalToSuperview().multipliedBy(0.5).inset(SellInputView.horizontalInset)
        }
    }
    
    func setBuyButton() {
        buyButton.then {
            $0.setTitle("판매 등록", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: Const.Font.veryBig, weight: .bold)
            $0.backgroundColor = Const.Color.primary
            $0.tintColor = .white
            $0.setShadow()
        }.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(SellInputView.horizontalInset)
            make.height.equalTo(SupplierInfoVC.balanceViewHeight)
            make.width.equalToSuperview().multipliedBy(0.5).inset(SellInputView.horizontalInset)
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

extension SellInputView {
    func setTextsByAmount() {
        if let amountText = amountTextField.textField.text?.replacingOccurrences(of: ",", with: ""),
           let amount = Int(amountText),
           let convertedAmount = numberFormatter.string(from: NSNumber(value: amount)),
           let priceText = priceTextField.textField.text?.replacingOccurrences(of: ",", with: ""),
           let price = Int(priceText) {
            
            if amount > input.recBalance {
                guard let maxAmount = numberFormatter.string(from: NSNumber(value: input.recBalance)) else {
                    setDefault()
                    return
                }
                amountTextField.textField.text = "\(maxAmount)"
                totalTextField.textField.text = numberFormatter.string(from: NSNumber(value: input.recBalance * price))
                return
            }
            
            amountTextField.textField.text = "\(convertedAmount)"
            totalTextField.textField.text = numberFormatter.string(from: NSNumber(value: amount * price))
        } else {
            setDefault()
        }
    }
    
    func setTextsByPrice() {
        if let amountText = amountTextField.textField.text?.replacingOccurrences(of: ",", with: ""),
           let amount = Int(amountText),
           let priceText = priceTextField.textField.text?.replacingOccurrences(of: ",", with: ""),
           let price = Int(priceText),
           let convertedPrice = numberFormatter.string(from: NSNumber(value: price)) {
            priceTextField.textField.text = "\(convertedPrice)"
            totalTextField.textField.text = numberFormatter.string(from: NSNumber(value: amount * price))
        } else {
            setDefault()
        }
    }
    
    func setDefault() {
        amountTextField.textField.text = "0"
        priceTextField.textField.text = "0"
        totalTextField.textField.text = "0"
    }
    
}
