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
    private var status = UILabel()
    
    init() {
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
            $0.alignment = .leading
        }.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10.0)
        }
    }
    
    func setTimeStamp() {
        timeStamp.then {
            $0.text = "2021년 12월 24일 23:43:99"
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
            $0.text = "5,352원"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    func setQuantity() {
        quantity.then {
            $0.text = "43개"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    func setStatus() {
        status.then {
            $0.text = "대금 수령 확인 중"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: TransactionCell.fontSize)
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.175)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
