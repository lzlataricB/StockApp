//
//  LoginViewModel.swift
//  StockApp
//
//  Created by Luka on 28.06.2022..
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {
    let emailSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    var isValidForm: Observable<Bool>{
        return Observable.combineLatest(emailSubject.asObservable().startWith(""), passwordSubject.asObservable().startWith("")).map { email, pass in
            return email.validateEmail() && pass.count > 7
        }.startWith(false)
    }
}



extension String {
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
