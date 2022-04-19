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
    
    let helloSequence = Observable.just("Hello Rx")
    let fibonacciSequence = Observable.from([0,1,1,2,3,5,8])
    let dictSequence = Observable.from([1:"Hello",2:"World"])
    let worldSequence = Observable.from(["W", "o", "r", "l", "d"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var subscription = helloSequence.subscribe { event in
          print(event)
        }
        
        subscription = fibonacciSequence.subscribe { event in
            print(event)
        }
        
        subscription = dictSequence.subscribe { event in
            print(event)
        }
        
        subscription = worldSequence.subscribe { event in
            switch event {
                case .next(let value):
                    print(value)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        
        subscription.disposed(by: bag)
    }


}

