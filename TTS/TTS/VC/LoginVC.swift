//
//  LoginVC.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/02.
//

import UIKit

import Then
import SnapKit
import RxSwift
import RxGesture

extension LoginVC {
    static let componentWidthRatio: CGFloat = 0.5
    static let offset: CGFloat = 25.0
}

class LoginVC: UIViewController {
    private var disposeBag = DisposeBag()
    private var emailField = UITextField()
    private var passwordField = UITextField()
    private var loginButton = UIButton()
    
    private var viewModel = LoginVM()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        [emailField, passwordField, loginButton].forEach {
            self.view.addSubview($0)
        }
        setEmailField()
        setPasswordField()
        setLoginButton()
        setBinding()
    }
    
    func setEmailField() {
        emailField.then {
            $0.placeholder = "이메일"
            $0.keyboardType = .emailAddress
            $0.textContentType = .emailAddress
            $0.autocapitalizationType = .none
            $0.borderStyle = .roundedRect
        }.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(LoginVC.componentWidthRatio)
        }
    }
    
    func setPasswordField() {
        passwordField.then {
            $0.placeholder = "비밀번호"
            $0.autocapitalizationType = .none
            $0.textContentType = .password
            $0.isSecureTextEntry = true
            $0.borderStyle = .roundedRect
        }.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(emailField)
            make.top.equalTo(emailField.snp.bottom).offset(LoginVC.offset)
        }
    }
    
    func setLoginButton() {
        loginButton.then {
            $0.setTitle("로그인", for: .normal)
            $0.backgroundColor = Const.Color.primary
            $0.tintColor = .white
            $0.layer.cornerRadius = 5.0
        }.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordField.snp.bottom).offset(LoginVC.offset)
            make.height.width.equalTo(emailField)
        }
    }
    
    func setBinding() {
        let output = viewModel.transform(
            input: LoginVM.Input(
                emailField: emailField.rx.text.asObservable(),
                passwordField: passwordField.rx.text.asObservable(),
                isTapped: loginButton.rx.tapGesture().when(.recognized).asObservable())
        )
        
        output.isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isLoginSuccess
            .subscribe(onNext: { result in
                if result {
                    let nextVC = SplitVC()
                    nextVC.modalTransitionStyle = .crossDissolve
                    nextVC.modalPresentationStyle = .fullScreen
                    self.present(nextVC, animated: true)
                }
            }).disposed(by: disposeBag)
    }
}
