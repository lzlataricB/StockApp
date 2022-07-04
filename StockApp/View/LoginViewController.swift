//
//  LoginViewController.swift
//  StockApp
//
//  Created by Luka on 28.06.2022..
//

import UIKit
import SnapKit
import RxSwift

class LoginViewController: UIViewController {
    
    let bag = DisposeBag()
    let viewModel = LoginViewModel()
    
    lazy var loginImage : UIImageView = {
        let image = UIImage(named: "login")
        let loginImage = UIImageView(image: image)
        return loginImage
    }()
    
    lazy var email : UITextField = {
        let email = UITextField()
        email.autocorrectionType = .no
        email.autocapitalizationType = .none
        email.layer.borderWidth = 2
        email.layer.borderColor = UIColor.black.cgColor
        email.layer.cornerRadius = 10
        email.textAlignment = .center
        email.font = UIFont(name: "Arial", size: 20)
        email.placeholder = "Email"
        return email
    }()
    
    lazy var password: UITextField = {
        let password = UITextField()
        password.autocapitalizationType = .none
        password.layer.borderWidth = 2
        password.layer.borderColor = UIColor.black.cgColor
        password.layer.cornerRadius = 10
        password.textAlignment = .center
        password.font = UIFont(name: "Arial", size: 20)
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        return password
    }()
    
    lazy var loginButton : UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 10
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return loginButton
    }()
    
    lazy var signUpButton : UIButton = {
        let signUpButton = UIButton()
        signUpButton.backgroundColor = .green
        signUpButton.tintColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.cornerRadius = 10
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return signUpButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        configureActionButtons()
        setUpBindings()
    }
    
    func setUpBindings() {
        email.rx.text.map{ $0 ?? "" }.bind(to: viewModel.emailSubject).disposed(by: bag)
        password.rx.text.map{ $0 ?? "" }.bind(to: viewModel.passwordSubject).disposed(by: bag)

        viewModel.isValidForm.bind(to: loginButton.rx.isEnabled).disposed(by: bag)
        viewModel.isValidForm.map { $0 ? 1 : 0.1 }.bind(to: loginButton.rx.alpha).disposed(by: bag)
    }
    
    func configureActionButtons() {
        loginButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    @objc func signUp() {
        let signUpVC = SignUpViewController()
        self.email.text = ""
        self.password.text = ""
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func logIn() {
        Network.shared.signIn(email: email.text!, pass: password.text!){[weak self] succes in
            guard let self = self else { return }
            switch succes{
            case true:
                let stockVC = StocksViewController()
                self.password.text = ""
                self.navigationController?.pushViewController(stockVC, animated: true)
            case false:
                let alertController = UIAlertController(title: "Wrong credentials", message: "Please try again", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true)
                self.password.text = ""
            }
        }
    }
    
    func configureUI() {
        view.addSubview(loginImage)
        loginImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(100)
            $0.height.width.equalTo(200)
        }
        
        view.addSubview(email)
        email.snp.makeConstraints {
            $0.top.equalTo(loginImage.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(250)
        }
        
        view.addSubview(password)
        password.snp.makeConstraints {
            $0.top.equalTo(email.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(250)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(password.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(150)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(150)
        }
    }
}
