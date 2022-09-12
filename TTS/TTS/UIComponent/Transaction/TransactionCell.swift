//
//  TransactionCell.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/04.
//

import UIKit

import Then
import SnapKit

extension TransactionCell {
    static let fontSize: CGFloat = 21.0
}

class TransactionCell: UIView {
    private var cell = UIStackView()
    
    private var timeStamp = UILabel()
    private var sender = UILabel()
    private var receiver = UILabel()
    private var pricePerREC = UILabel()
    private var quantity = UILabel()
    private var status = UIView()
    
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
        setReceiver()
        setPricePerREC()
        setQuantity()
        setStatus()
    }
    
    func setCell() {
        [timeStamp, sender, receiver, pricePerREC, quantity, status].forEach {
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
    
    func setTimeStamp() {
        timeStamp.then {
            $0.text = "\(DateTimeConverter.fromIntToString(input: input.registeredDate))"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.325)
            make.top.bottom.equalToSuperview().inset(12.0)
        }
    }
    
    func setSender() {
        sender.then {
            $0.text = "남부발전"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    func setReceiver() {
        receiver.then {
            $0.text = "한국전력"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    func setPricePerREC() {
        pricePerREC.then {
            $0.text = "\(input.price)원"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.15)
        }
    }
    
    func setQuantity() {
        quantity.then {
            $0.text = "\(input.quantity)개"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.15)
        }
    }
    
    func setStatus() {
        let statusLabel = BasePaddingLabel()
        status.snp.makeConstraints { make in
            make.height.equalTo(quantity)
            make.width.equalToSuperview().multipliedBy(0.175)
        }
        
        status.addSubview(statusLabel)
        
        var text = "거래 대금 확인 중"
        var textColor = Const.Color.semanticYellow2
        var backgroundColor = Const.Color.semanticYellow1
        if input.buyer == nil {
            text = "미체결"
            textColor = Const.Color.semanticRed2
            backgroundColor = Const.Color.semanticRed1
        } else if input.is_confirmed {
            text = "거래 완료"
            textColor = Const.Color.semanticGreen2
            backgroundColor = Const.Color.semanticGreen1
        }
        
        statusLabel.then {
            $0.text = text
            $0.textColor = textColor
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize, weight: .bold)
            $0.backgroundColor = backgroundColor
            $0.layer.cornerRadius = 5.0
            $0.layer.masksToBounds = true

        }.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
