//
//  ViewController.swift
//  RxSwiftInTenMinutes
//
//  Created by Aleksandar Filipov on 4/19/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    let bag = DisposeBag()
    
    var behaviorSubject = BehaviorSubject<String>(value: "Initial value")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstSubscription = behaviorSubject.subscribe {
            print("first: \($0)")
        }.disposed(by: bag)
        
        behaviorSubject.onNext("1")
        behaviorSubject.onNext("2")
        
        let secondSubscription = behaviorSubject.subscribe {
            print("second: \($0)")
        }
        
        behaviorSubject.onNext("3")
        behaviorSubject.onNext("4")
        
        let thirdSubscription = behaviorSubject.subscribe {
            print("third: \($0)")
        }
        
        behaviorSubject.onNext("5")
        
        secondSubscription.dispose()
        thirdSubscription.dispose()
        
        behaviorSubject.onNext("0")
        
        behaviorSubject.onCompleted()
        
        behaviorSubject.onNext("10")
    }


}

