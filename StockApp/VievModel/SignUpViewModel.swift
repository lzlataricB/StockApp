//
//  SignUpViewModel.swift
//  StockApp
//
//  Created by Luka on 28.06.2022..
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel {
    let firstNameSubject = BehaviorRelay<String?>(value: "")
    let lastNameSubject = BehaviorRelay<String?>(value: "")
    let emailSubject = BehaviorRelay<String?>(value: "")
    let passwordSubject = BehaviorRelay<String?>(value: "")
    let disposeBag = DisposeBag()
    let minPasswordCharacters = 8
    
    var isValidForm: Observable<Bool> {
            return Observable.combineLatest(lastNameSubject, firstNameSubject, emailSubject, passwordSubject) { first, last, email, password in
                guard first != nil && last != nil && email != nil && password != nil else {
                    return false
                }
                return !(first!.isEmpty) && !(last!.isEmpty) && email!.validateEmail() && password!.count >= self.minPasswordCharacters
            }
        }
}
