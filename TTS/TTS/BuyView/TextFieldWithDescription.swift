//
//  TextFieldWithDescription.swift
//  TTS
//
//  Created by Yujin Cha on 2022/08/28.
//

import UIKit

extension TextFieldWithDescription {
    static let radius: CGFloat = 5.0
    static let horizontalInset: CGFloat = 10.0
    static let verticalInset: CGFloat = 10.0
}

class TextFieldWithDescription: UIView {
    struct Input {
        var title: String
        var initValue: String
        var suffix: String
        var isEnabled: Bool
    }
    
    var input: Input
    
    lazy var titleLabel = UILabel()
    lazy var textField = UITextField()
    lazy var suffixLabel = UILabel()
    
    init(input: Input) {
        self.input = input
        super.init(frame: .zero)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextFieldWithDescription {
    func setView() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(suffixLabel)
        
        layer.cornerRadius = TextFieldWithDescription.radius
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        
        setTitleLabel()
        setTextField()
        setSuffixLabel()
    }
    
    func setTitleLabel() {
        titleLabel.then {
            $0.text = input.title
        }.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(TextFieldWithDescription.horizontalInset)
            make.top.bottom.equalToSuperview().inset(TextFieldWithDescription.verticalInset)
        }
    }
    
    func setTextField() {
        textField.then {
            $0.text = input.initValue
            $0.isEnabled = input.isEnabled
        }.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right).offset(TextFieldWithDescription.horizontalInset)
            make.top.bottom.equalToSuperview().inset(TextFieldWithDescription.verticalInset)
        }
        
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        suffixLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        suffixLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func setSuffixLabel() {
        suffixLabel.then {
            $0.text = input.suffix
        }.snp.makeConstraints { make in
            make.left.equalTo(textField.snp.right).offset(TextFieldWithDescription.horizontalInset)
            make.right.equalToSuperview().inset(TextFieldWithDescription.horizontalInset)
            make.top.bottom.equalToSuperview().inset(TextFieldWithDescription.verticalInset)
        }
    }
    
}
