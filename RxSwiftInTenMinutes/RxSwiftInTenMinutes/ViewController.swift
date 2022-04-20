//
//  ViewController.swift
//  RxSwiftInTenMinutes
//
//  Created by Aleksandar Filipov on 4/19/22.
//

import UIKit
import RxSwift
import RxRelay

class ViewController: UIViewController {
    let bag = DisposeBag()
    
    var behaviorRelay = BehaviorRelay<String>.init(value: "Initial value")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstSubscription = behaviorRelay.subscribe {
            print("first: \($0)")
        }.disposed(by: bag)
        
        behaviorRelay.accept("1")
        behaviorRelay.accept("2")
        
        let secondSubscription = behaviorRelay.subscribe {
            print("second: \($0)")
        }
        
        behaviorRelay.accept("3")
        behaviorRelay.accept("4")
        
        let thirdSubscription = behaviorRelay.subscribe {
            print("third: \($0)")
        }
        
        behaviorRelay.accept("5")
        
        secondSubscription.dispose()
        thirdSubscription.dispose()
        
        behaviorRelay.accept("0")
        
//        behaviorRelay.onCompleted()
        
        behaviorRelay.accept("10")
    }


}

