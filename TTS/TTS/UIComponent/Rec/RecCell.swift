//
//  RecCell.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/08.
//

import UIKit

import Then
import SnapKit

extension RecCell {
    static let fontSize: CGFloat = 21.0
}

class RecCell: UIView {
    private var cell = UIStackView()
    
    private var recId = UILabel()
    private var expireDate = UILabel()
    private var quantity = UILabel()
    private var is_jeju = UIView()
    
    private var input: RecModel.InnerModel
    
    init(input: RecModel.InnerModel) {
        self.input = input
        super.init(frame: .zero)
        self.backgroundColor = .white
        setView()
    }
    
    func setView() {
        self.addSubview(cell)
        setCell()
        setRecId()
        setExpireDate()
        setQuantity()
        setIsJeju()
    }
    
    func setCell() {
        [recId, expireDate, quantity, is_jeju].forEach {
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
    
    func setRecId() {
        recId.then {
            $0.text = input.id
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: RecCell.fontSize)
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.35)
            make.top.bottom.equalToSuperview().inset(12.0)
        }
    }
    
    func setExpireDate() {
        expireDate.then {
            $0.text = "\(DateTimeConverter.fromInt(input: input.expire_date))"
            $0.textColor = .darkGray
            $0.font = UIFont.systemFont(ofSize: RecCell.fontSize)
        }.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.35)
            make.top.bottom.equalToSuperview().inset(12.0)
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
    
    func setIsJeju() {
        let jejuLabel = BasePaddingLabel()
        
        is_jeju.snp.makeConstraints { make in
            make.height.equalTo(quantity)
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        
        is_jeju.addSubview(jejuLabel)
        
        var text = "내륙 지역"
        var textColor = Const.Color.semanticBlue2
        var backgroundColor = Const.Color.semanticBlue1
        
        if input.is_jeju {
            text = "제주 지역"
            textColor = Const.Color.semanticGreen2
            backgroundColor = Const.Color.semanticGreen1
        }
        
        jejuLabel.then {
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
