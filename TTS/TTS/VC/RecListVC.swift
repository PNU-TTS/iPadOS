//
//  RecListVC.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/08.
//

import UIKit

import RxSwift
import RxGesture
import Then
import SnapKit

class RecListVC: UIViewController {
    private var disposeBag = DisposeBag()
    
    private var titleLabel = UILabel()
    
    private var recHeader = RecHeader()
    private var recTable = UIScrollView()
    private var stackView = UIStackView()
    
    private var repository = RecListRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
    }
    
    func setView() {
        [titleLabel, recHeader, recTable].forEach {
            view.addSubview($0)
        }
        setTitle()
        setRecTable()
        setBinding()
    }
    
    func setTitle() {
        titleLabel.then {
            $0.text = "💵 판매 등록"
            $0.font = UIFont.systemFont(ofSize: 40.0, weight: .bold)
            $0.textColor = Const.Color.textColor
        }.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30.0)
            make.left.equalToSuperview().inset(10.0)
        }
    }
    
    func setRecTable() {
        recHeader.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            make.left.right.equalToSuperview().inset(10.0)
        }
        
        recTable.addSubview(stackView)
        
        recTable.snp.makeConstraints { make in
            make.left.right.equalTo(recHeader)
            make.top.equalTo(recHeader.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        stackView.then {
            $0.axis = .vertical
            $0.spacing = 1.0
            $0.backgroundColor = .lightGray.withAlphaComponent(0.5)
        }.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setBinding() {
        repository.getCertificateBysypplier(id: 1)
            .subscribe(onSuccess: { recList in
                recList.forEach { rec in
                    let cell = RecCell(input: rec.Certificate)
                    cell.setSellButtonCommand {
                        let nextVC = RecSellVC()
                        self.present(nextVC, animated: true)
                    }
                    self.stackView.addArrangedSubview(cell)
                }
            }).disposed(by: disposeBag)
    }
}
