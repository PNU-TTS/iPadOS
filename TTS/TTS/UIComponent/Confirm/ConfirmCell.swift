//
//  ConfirmCell.swift
//  TTS
//
//  Created by 안현주 on 2022/09/08.
//

import UIKit
import Then
import SnapKit

extension ConfirmCell {
    static let fontSize: CGFloat = 21.0
}

class ConfirmCell: UIView {
    private var cell = UIStackView()
    
    private var timeStamp = UILabel()
    private var receiver = UILabel()
    private var pricePerREC = UILabel()
    private var quantity = UILabel()
//    private var status = UILabel()
    private var confirmButton = UIButton()
    
    private var input: TransactionModel
    
    init(input: TransactionModel) {
        self.input = input
        
        super.init(frame: .zero)
        self.backgroundColor = .white
        setView()
    }
    
    func setView() {
        self.addSubview(cell)
        setCell()
        setTimeStamp()
        setReceiver()
        setPricePerREC()
        setQuantity()
        setConfirmButton()
    }
    
    func setCell() {
        [timeStamp, receiver, pricePerREC, quantity, confirmButton].forEach {
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
            $0.text = "\(DateTimeConverter.fromInt(input: input.registered_time))"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.325)
            make.top.bottom.equalToSuperview().inset(12.0)
        }
    }
        
    func setReceiver() {
        receiver.then {
            $0.text = "한국전력"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    func setPricePerREC() {
        pricePerREC.then {
            $0.text = "\(input.price)원"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.15)
        }
    }
    
    func setQuantity() {
        quantity.then {
            $0.text = "\(input.quantity)개"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
            $0.textAlignment = .center
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.15)
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
    
    func setConfirmButton() {
        confirmButton.then {
            $0.setTitle("승인", for: .normal)
            $0.backgroundColor = Const.Color.primary
            $0.tintColor = .white
            $0.layer.cornerRadius = 5.0
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.175)
        }

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

