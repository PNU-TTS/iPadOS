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
    private var subTitleLabel = UILabel()
    
    private var averageView: PriceView
    private var highPriceView: PriceView
    private var lowPriceView: PriceView
//    private var sellInputView: SellInputView
    
    private var transactionDate: ConfirmTransactionCell
    private var supplierInfo: ConfirmTransactionCell
    private var pricePerRec: ConfirmTransactionCell
    private var transactionVolume: ConfirmTransactionCell
    private var totalPrice: ConfirmTransactionCell
    private var bankAccount: ConfirmTransactionCell
    
    private var priceStackView = UIStackView()
    private var tranInfoStackView = UIStackView()
    private var buyButton = UIButton()
    
    private var input: TransactionModel.InnerModel

    init(input: TransactionModel.InnerModel) {
        self.input = input
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
        
        transactionDate = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(
            title: "거래 등록 일시",
            content: "2022년 01월 01일 19:02:34"))
        
        supplierInfo = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(title: "구매자", content: "한국 전력"))
        
        pricePerRec = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(title: "인증서 개당 가격", content: "26,323 원"))
        
        transactionVolume = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(title: "거래 수량", content: "1,242 개"))
        
        totalPrice = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(title: "총 거래 대금", content: "2,312,463 원"))
        
        bankAccount = ConfirmTransactionCell(input: ConfirmTransactionCell.Input(title: "입금 계좌", content: "부산은행 112-3723-4838-47"))
        
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
            priceStackView,
            subTitleLabel,
            tranInfoStackView,
            buyButton
        ].forEach {
            self.view.addSubview($0)
        }
        setTitle()
        setPriceStackView()
        setSubTitle()
        setTranInfoStackView()
        setBuyButton()
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
    
    func setPriceStackView() {
        [averageView, highPriceView, lowPriceView].forEach {
            priceStackView.addArrangedSubview($0)
        }
        
        priceStackView.then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 10.0
        }.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(10.0)
        }
    }
    
    func setSubTitle() {
        subTitleLabel.then {
            $0.text = "구매 정보"
            $0.font = UIFont.systemFont(ofSize: 35.0, weight: .semibold)
            $0.textColor = Const.Color.textColor
        }.snp.makeConstraints { make in
            make.top.equalTo(priceStackView.snp.bottom).offset(40.0)
            make.left.equalToSuperview().inset(20.0)
        }
    }
    
    func setTranInfoStackView() {
        [transactionDate, supplierInfo, pricePerRec, transactionVolume, totalPrice, bankAccount].forEach {
            tranInfoStackView.addArrangedSubview($0)
        }
        
        tranInfoStackView.then {
            $0.axis = .vertical
            $0.spacing = 1.0
        }.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(10.0)
            make.left.right.equalToSuperview().inset(10.0)
        }
    }
    
    func setBuyButton() {
        buyButton.then {
            $0.setTitle("구매하기", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 27.0, weight: .bold)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = Const.Color.primary
            $0.layer.cornerRadius = 5.0
        }.snp.makeConstraints { make in
            make.top.equalTo(tranInfoStackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(55.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
