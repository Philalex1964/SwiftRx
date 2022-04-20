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
    
    var replaySubject = ReplaySubject<String>.create(bufferSize: 5)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstSubscription = replaySubject.subscribe {
            print("first: \($0)")
        }.disposed(by: bag)
        
        replaySubject.onNext("1")
        replaySubject.onNext("2")
        
        let secondSubscription = replaySubject.subscribe {
            print("second: \($0)")
        }
        
        replaySubject.onNext("3")
        replaySubject.onNext("4")
        
        let thirdSubscription = replaySubject.subscribe {
            print("third: \($0)")
        }
        
        replaySubject.onNext("5")
        
        secondSubscription.dispose()
        thirdSubscription.dispose()
        
        replaySubject.onNext("0")
        
        replaySubject.onCompleted()
        
        replaySubject.onNext("10")
    }


}

