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
    
    var publishSubject = PublishSubject<Any>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subscription1 = publishSubject.subscribe(onNext:{
          print("s1 \($0)")
        }).disposed(by: bag)
        // Subscription1 receives these 2 events, Subscription2 won't
        
        publishSubject.onNext("Hello")
        publishSubject.onNext("World")

        // Sub2 will not get "Hello" and "Again" because it susbcribed later
        let subscription2 = publishSubject.subscribe(onNext:{
          print(#line,$0)
        }).disposed(by: bag)
        
        publishSubject.onNext("Both Subscriptions receive this message")
        
        let firstSubscription = publishSubject.subscribe {
            print("first: \($0)")
        }
        
        publishSubject.onNext("1")
        publishSubject.onNext("2")
        
        let secondSubscription = publishSubject.subscribe {
            print("second: \($0)")
        }
        
        publishSubject.onNext("3")
        publishSubject.onNext("4")
        
        let thirdSubscription = publishSubject.subscribe {
            print("second: \($0)")
        }
        
        firstSubscription.dispose()
        
        publishSubject.onNext("5")
        
        secondSubscription.dispose()
        thirdSubscription.dispose()
        
        publishSubject.onNext("0")
        
        publishSubject.onCompleted()
        
        publishSubject.onNext("10")
    }


}

