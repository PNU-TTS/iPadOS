//
//  ProfileVC.swift
//  TTS
//
//  Created by Yujin Cha on 2022/09/05.
//

import UIKit

extension ProfileVC {
    static let horizontalInset: CGFloat = 20.0
    static let verticalOffset: CGFloat = 20.0
}

class ProfileVC: UIViewController {
    
    var profileView: ProfileCard
    
    var stackView = UIStackView()
    
    var editCard = SettingCard(input: SettingCard.Input(title: "개인 정보 수정", image: UIImage(systemName: "pencil.circle.fill")))
    var logoutCard = SettingCard(input: SettingCard.Input(title: "로그아웃", image: nil))
    var askCard = SettingCard(input: SettingCard.Input(title: "문의하기", image: UIImage(systemName: "envelope.fill")))
    
    init() {
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

extension ProfileVC {
    func setView() {
        view.backgroundColor = .white
        setProfileView()
        setStackView()
    }
    
    func setProfileView() {
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(ProfileVC.verticalOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(ProfileVC.horizontalInset)
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
            $0.spacing = ProfileVC.verticalOffset
        }.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(ProfileVC.verticalOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(ProfileVC.horizontalInset)
        }
        
        stackView.arrangedSubviews.forEach { subview in
            subview.snp.makeConstraints { make in
                make.width.equalToSuperview()
            }
        }
    }
}
