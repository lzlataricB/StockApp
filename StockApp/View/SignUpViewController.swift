//
//  SignUpViewController.swift
//  StockApp
//
//  Created by Luka on 28.06.2022..
//

import UIKit
import RxCocoa
import RxSwift

class SignUpViewController: UIViewController {
    
    let viewModel = SignUpViewModel()
    let bag = DisposeBag()
    
    lazy var signUpImage : UIImageView = {
        let image = UIImage(named: "signup")
        let loginImage = UIImageView(image: image)
        return loginImage
    }()
    
    lazy var firstName : UITextField = {
        let firstName = UITextField()
        firstName.autocorrectionType = .no
        firstName.autocapitalizationType = .none
        firstName.layer.borderWidth = 2
        firstName.layer.borderColor = UIColor.black.cgColor
        firstName.layer.cornerRadius = 10
        firstName.textAlignment = .center
        firstName.font = UIFont(name: "Arial", size: 20)
        firstName.placeholder = "First name"
        return firstName
    }()
    
    lazy var lastName : UITextField = {
        let lastName = UITextField()
        lastName.autocorrectionType = .no
        lastName.autocapitalizationType = .none
        lastName.layer.borderWidth = 2
        lastName.layer.borderColor = UIColor.black.cgColor
        lastName.layer.cornerRadius = 10
        lastName.textAlignment = .center
        lastName.font = UIFont(name: "Arial", size: 20)
        lastName.placeholder = "Last name"
        return lastName
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
    
    lazy var signUpButton : UIButton = {
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
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
        configureActionButton()
        setUpBindings()
    }
    
    func setUpBindings(){
        firstName.rx.text.bind(to: viewModel.firstNameSubject).disposed(by: bag)
        lastName.rx.text.bind(to: viewModel.lastNameSubject).disposed(by: bag)
        email.rx.text.bind(to: viewModel.emailSubject).disposed(by: bag)
        password.rx.text.bind(to: viewModel.passwordSubject).disposed(by: bag)
        
        viewModel.isValidForm.bind(to: signUpButton.rx.isEnabled).disposed(by: bag)
        viewModel.isValidForm.map { $0 ? 1 : 0.1 }.bind(to: signUpButton.rx.alpha).disposed(by: bag)
    }
    
    func configureActionButton(){
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    @objc func signUp(){
        Network.shared.signUp(email: email.text!, pass: password.text!) { [weak self] succes in
            guard let self = self else { return }
            switch succes {
            case true:
                self.navigationController?.popViewController(animated: true)
            case false:
                let alertController = UIAlertController(title: "Email already in use", message: "Please try again", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true)
                self.password.text = ""
            }
        }
    }
    
    func configureUI() {
        
        view.addSubview(signUpImage)
        signUpImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(100)
            $0.height.width.equalTo(200)
        }
        
        view.addSubview(firstName)
        firstName.snp.makeConstraints {
            $0.top.equalTo(signUpImage.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(250)
        }
        
        view.addSubview(lastName)
        lastName.snp.makeConstraints {
            $0.top.equalTo(firstName.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(250)
        }
        
        view.addSubview(email)
        email.snp.makeConstraints {
            $0.top.equalTo(lastName.snp.bottom).offset(20)
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
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(password.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(150)
        }
    }
}
