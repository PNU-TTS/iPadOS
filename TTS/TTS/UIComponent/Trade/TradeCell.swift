//
//  TradeCell.swift
//  TTS
//
//  Created by 안현주 on 2022/09/08.
//

import UIKit
import Then
import SnapKit

extension TradeCell {
    static let fontSize: CGFloat = 21.0
}

class TradeCell: UIView {
    private var cell = UIStackView()
    
//    private var timeStamp = UILabel()
    private var sender = UILabel()
    private var pricePerREC = UILabel()
    private var quantity = UILabel()
//    private var status = UILabel()
    private var buyButton = UIButton()
    
    private var input: TransactionModel.InnerModel
    
    init(input: TransactionModel.InnerModel) {
        self.input = input
        
        super.init(frame: .zero)
        self.backgroundColor = .white
        setView()
    }
    
    func setView() {
        self.addSubview(cell)
        setCell()
//        setTimeStamp()
        setSender()
        setPricePerREC()
        setQuantity()
        setBuyButton()
    }
    
    func setCell() {
        [sender, pricePerREC, quantity, buyButton].forEach {
            cell.addArrangedSubview($0)
        }
        
        cell.then {
            $0.axis = .horizontal
            $0.alignment = .firstBaseline
        }.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10.0)
        }
    }
    
//    func setTimeStamp() {
//        timeStamp.then {
//            $0.text = "\(DateTimeConverter.fromInt(input: input.registeredDate))"
//            $0.textColor = .darkGray
//            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
//            $0.textAlignment = .center
//        }.snp.makeConstraints { make in
//            make.width.equalToSuperview().multipliedBy(0.325)
//            make.top.bottom.equalToSuperview().inset(12.0)
//        }
//    }
        
    func setSender() {
        sender.then {
            $0.text = "한국전력"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.top.bottom.equalToSuperview().inset(12.0)
        }
    }
    
    func setPricePerREC() {
        pricePerREC.then {
            $0.text = "\(input.price)원"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.25)
        }
    }
    
    func setQuantity() {
        quantity.then {
            $0.text = "\(input.quantity)개"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.25)
        }
    }
    
//    func setStatus() {
//        var text = "거래 대금 확인 중"
//        if input.buyer == nil {
//            text = "미체결"
//        }
//        status.then {
//            $0.text = text
//            $0.textColor = .darkGray
//            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
//        }.snp.makeConstraints { make in
//            make.width.equalToSuperview().multipliedBy(0.175)
//        }
//    }
    
    func setBuyButton() {
        buyButton.then {
            $0.setTitle("승인", for: .normal)
            $0.backgroundColor = Const.Color.primary
            $0.tintColor = .white
            $0.layer.cornerRadius = 5.0
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.25)
        }

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

