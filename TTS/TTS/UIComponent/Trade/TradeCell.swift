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
    
    private var timeStamp = UILabel()
    private var sender = UILabel()
    private var pricePerREC = UILabel()
    private var quantity = UILabel()
//    private var status = UILabel()
    private var buy = UIView()
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
        setTimeStamp()
        setSender()
        setPricePerREC()
        setQuantity()

        
    }
    
    func setCell() {
        [timeStamp, sender, pricePerREC, quantity].forEach {
            cell.addArrangedSubview($0)
        }
        
        cell.then {
            $0.axis = .horizontal
            $0.alignment = .firstBaseline
            $0.distribution = .equalSpacing
        }.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10.0)
        }
        
        if !ProfileDB.shared.get().is_supplier {
            cell.addArrangedSubview(buy)
            setBuy()
        }
    }
    
    func setTimeStamp() {
        timeStamp.then {
            $0.text = "\(DateTimeConverter.fromInt(input: input.registeredDate))"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TradeCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.325)
            make.top.bottom.equalToSuperview().inset(12.0)
        }
    }
        
    func setSender() {
        sender.then {
            $0.text = "한국전력"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TradeCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.top.bottom.equalToSuperview().inset(12.0)
        }
    }
    
    func setPricePerREC() {
        pricePerREC.then {
            $0.text = "\(input.price)원"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TradeCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.top.bottom.equalTo(sender)
        }
    }
    
    func setQuantity() {
        quantity.then {
            $0.text = "\(input.quantity)개"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TradeCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.top.bottom.equalTo(sender)
        }
    }
    
    func setBuy() {
        buy.snp.makeConstraints { make in
            make.height.equalTo(quantity)
            make.width.equalToSuperview().multipliedBy(0.175)
        }
        
        if !ProfileDB.shared.get().is_supplier {
            buy.addSubview(buyButton)
            
            buyButton.then {
                $0.setTitle("구매하기", for: .normal)
                $0.titleLabel?.font = UIFont.systemFont(ofSize: TradeCell.fontSize, weight: .bold)
                $0.setTitleColor(.white, for: .normal)
                $0.backgroundColor = Const.Color.primary
                $0.layer.cornerRadius = 5.0
            }.snp.makeConstraints { make in
                make.top.bottom.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.8)
            }
        }

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

