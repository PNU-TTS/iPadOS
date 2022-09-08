//
//  RecListVC.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/08.
//

import UIKit

import RxSwift
import Then
import SnapKit

class RecListVC: UIViewController {
    private var disposeBag = DisposeBag()
    
    private var recHeader = RecHeader()
    private var recTable = UIStackView()
    
    private var repository = RecListRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
    }
    
    func setView() {
        [recHeader, recTable].forEach {
            view.addSubview($0)
        }
        
        setRecTable()
        setBinding()
    }
    
    func setRecTable() {
        recHeader.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10.0)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30.0)
        }
        
        recTable.then {
            $0.axis = .vertical
            $0.spacing = 1.0
            $0.backgroundColor = .lightGray.withAlphaComponent(0.5)
        }.snp.makeConstraints { make in
            make.left.right.equalTo(recHeader)
            make.top.equalTo(recHeader.snp.bottom)
        }
    }
    
    func setBinding() {
        repository.getCertificateBysypplier(id: 1)
            .subscribe(onSuccess: { recList in
                recList.forEach { rec in
                    self.recTable.addArrangedSubview(RecCell(input: rec.Transaction))
                }
            }).disposed(by: disposeBag)
    }
}
