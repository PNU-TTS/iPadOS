//
//  ProfileVC.swift
//  TTS
//
//  Created by Yujin Cha on 2022/09/05.
//

import UIKit

import RxSwift
import Then
import SnapKit


extension SupplierProfileVC {
    static let horizontalInset: CGFloat = 20.0
    static let verticalOffset: CGFloat = 20.0
}

class SupplierProfileVC: UIViewController {
    private var disposeBag = DisposeBag()
    
    var profileView: ProfileCard
    
    var stackView = UIStackView()
    
    var editCard = SettingCard(input: SettingCard.Input(title: "개인 정보 수정", image: UIImage(systemName: "pencil.circle.fill")))
    var logoutCard = SettingCard(input: SettingCard.Input(title: "로그아웃", image: nil))
    var askCard = SettingCard(input: SettingCard.Input(title: "문의하기", image: UIImage(systemName: "envelope.fill")))
    
    private var repository = SupplierRepository()
    private var id: Int
    
    init(id: Int) {
        self.id = id
        profileView = ProfileCard(input: ProfileCard.sampleInput)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "개인 정보"
        
        setView()
    }
    
}

extension SupplierProfileVC {
    func setView() {
        view.backgroundColor = .white
        setBinding()
    }
    
    func setProfileView() {
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(SupplierProfileVC.verticalOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(SupplierProfileVC.horizontalInset)
        }
    }
    
    func setStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(editCard)
        stackView.addArrangedSubview(askCard)
        stackView.addArrangedSubview(logoutCard)
        
        stackView.then {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = SupplierProfileVC.verticalOffset
        }.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(SupplierProfileVC.verticalOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(SupplierProfileVC.horizontalInset)
        }
        
        stackView.arrangedSubviews.forEach { subview in
            subview.snp.makeConstraints { make in
                make.width.equalToSuperview()
            }
        }
    }
    
    func setBinding() {
        repository.getSupplierInfo(id: id)
            .subscribe(onSuccess: { result in
                let username = ProfileDB.shared.get().email.components(separatedBy: "@").first ?? "-"
                
                self.profileView = ProfileCard(
                    input: ProfileCard.Input(
                        name: username,
                        role: "발전 사업자",
                        company: result.name,
                        walletID: "feswjfhdsifweiun")
                )
                self.setProfileView()
                self.setStackView()
            }).disposed(by: disposeBag)
    }
}
