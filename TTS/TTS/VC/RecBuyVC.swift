//
//  RecBuyVC.swift
//  TTS
//
//  Created by 안현주 on 2022/09/13.
//

import UIKit
import Then
import SnapKit

class RecBuyVC: UIViewController {
    private var titleLabel = UILabel()
    
    private var averageView: PriceView
    private var highPriceView: PriceView
    private var lowPriceView: PriceView
    private var sellInputView: SellInputView
    
    private var stackView = UIStackView()

    
    init() {
        self.averageView = PriceView(input: PriceView.Input(
            icon: Const.Icon.won,
            amount: 10000,
            description: "평균가",
            tintColor: Const.Color.semanticGreen2))
        
        self.highPriceView = PriceView(input: PriceView.Input(
            icon: Const.Icon.upArrow,
            amount: 10000,
            description: "최고가",
            tintColor: Const.Color.semanticRed2))
        
        self.lowPriceView = PriceView(input: PriceView.Input(
            icon: Const.Icon.downArrow,
            amount: 10000,
            description: "최저가",
            tintColor: Const.Color.semanticBlue2))
        
        self.sellInputView = SellInputView(input: SellInputView.Input(recBalance: 100))
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Const.Color.backgroundColor
        
        setView()

    }
    
    func setView() {
        [
            titleLabel,
            stackView
        ].forEach {
            self.view.addSubview($0)
        }
        setTitle()
        setStackView()
    }
    
    func setTitle() {
        titleLabel.then {
            $0.text = "인증서 매도"
            $0.font = UIFont.systemFont(ofSize: 40.0, weight: .bold)
            $0.textColor = Const.Color.textColor
        }.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40.0)
            make.left.equalToSuperview().inset(10.0)
        }
    }
    
    func setStackView() {
        [averageView, highPriceView, lowPriceView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 10.0
        }.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(10.0)
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
