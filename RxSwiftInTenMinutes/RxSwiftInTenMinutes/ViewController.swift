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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Transform
        
        // MARK: - map
        Observable.of(1,2,3,4).map { value in
            return value * 10
        }.subscribe(onNext: {
            print("map: \($0)")
        })
        
        // MARK: - flatMap
        let sequence1 = Observable.of(1,2)
        let sequence2 = Observable.of(3,4)
        let sequenceOfSequences = Observable.of(sequence1, sequence2)
        sequenceOfSequences.flatMap { $0 }
            .subscribe(onNext: {
                print("flatMap: \($0)")
            })
        
        // MARK: - scan (similar to reduce in Swift)
        Observable.of(1,2,3,4,5).scan(0) { seed, value in
            seed + value
        }.subscribe(onNext: {
            print("scan: \($0)")
        })
        
        // MARK: - buffer (Оператор Buffer преобразует наблюдаемого, распространяющего элементы, в наблюдаемого, который распространяет буферизированные коллекции этих элементов.)
        let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        Observable.of(1,2,3,4,5,6,7).buffer(timeSpan: 150, count: 3, scheduler: concurrentScheduler)
        
        // MARK: - Filter
        // MARK: - filter
        Observable.of(2,30,22,5,60,1).filter{$0 > 10}
            .subscribe(onNext: {
                print("filter: \($0)")
            })
        
        // MARK: - distinctUntilChanged (распространять события next только в случае, если значение изменилось, используйте distinctUntilChanged.)
        Observable.of(1,2,2,1,3).distinctUntilChanged().subscribe(onNext:{
            print("distinctUntilChanged: \($0)")
        })
        
        // .debounce(<#T##dueTime: RxTimeInterval##RxTimeInterval#>, scheduler: <#T##SchedulerType#>)
        // .take(<#T##duration: RxTimeInterval##RxTimeInterval#>, scheduler: <#T##SchedulerType#>)
        
        // MARK: - skip
        Observable.of(2,30,22,5,60,1).skip(2).subscribe(onNext: {
            print("skip: \($0)")
        })
        
        // MARK:- Combine
        // MARK: - startWith
        Observable.of(2,3).startWith(1,4).subscribe(onNext:{
            print("startWith: \($0)")
        })
        
        // MARK: - merge
        let publish1 = PublishSubject<Any>()
        let publish2 = PublishSubject<Any>()
        Observable.of(publish1,publish2).merge().subscribe(onNext:{
            print("merge: \($0)")
        })
        publish1.onNext(20)
        publish1.onNext(40)
        publish1.onNext(60)
        publish2.onNext(1)
        publish1.onNext(80)
        publish2.onNext(2)
        publish1.onNext(100)
        
        // MARK: - zip
        let a = Observable.of(1,2,3,4,5)
        let b = Observable.of("a","b","c","d")
        Observable.zip(a,b){ return ($0,$1) }.subscribe {
            print("zip: \($0)")
        }
        
        // Observable.concat Concat operator concatenates the output of multiple Observables so that they act like a single Observable, with all of the items emitted by the first Observable being emitted before any of the items emitted by the second Observable.
        // https://medium.com/@rajajawahar77/using-concat-operator-in-rxswift-c9b0a975a33d
        
        // MARK: - combineLatest
        Observable.combineLatest(a, b).subscribe() {
            print("combineLatest: \($0)")
        }.disposed(by: bag)
        
        // MARK: - do(onNext:), do(onError:), do(onCompleted:) - no effect on the actual subscription
        Observable.of(1,2,3,4,5).do(onNext: {
            $0 * 10 // This has no effect on the actual subscription
        }).subscribe(onNext:{
            print("do(onNext): \($0)")
        })
        
        // MARK: - schedulers
            let publish3 = PublishSubject<Any>()
            let publish4 = PublishSubject<Any>()
            let concurrentScheduler1 = ConcurrentDispatchQueueScheduler(qos: .background)
            Observable.of(publish3,publish4)
            .observeOn(concurrentScheduler1)
            .merge()
            .subscribeOn(MainScheduler())
            .subscribe(onNext: {
                print("scheduler: \($0)")
            })
            
            publish3.onNext(20)
            publish4.onNext(40)
            
            }
    
    
}

