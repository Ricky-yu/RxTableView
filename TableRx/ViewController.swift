//
//  ViewController.swift
//  TableRx
//
//  Created by CHEN SINYU on 2019/12/22.
//  Copyright © 2019 CHEN SINYU. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    fileprivate let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //基本
        //never
        let never = Observable<String>.never()
        never.subscribe { (event : Event<String>) in
            print(event)
        }.disposed(by: bag)
        print("------------------------------------")
        //empty
        let empty = Observable<String>.empty()
        empty.subscribe { (event : Event<String>) in
            print(event)
        }.disposed(by: bag)
        print("------------------------------------")
        //just
        let just = Observable.just("coderwhy")
        just.subscribe { (event : Event<String>) in
            print(event)
        }.disposed(by: bag)
        print("------------------------------------")
        //of
        let of = Observable.of("a","b","c")
        of.subscribe { (event : Event<String>) in
            print(event)
        }.disposed(by: bag)
        print("------------------------------------")
        //from
        let array = [1, 2, 3, 4]
        let from = Observable.from(array)
        from.subscribe { (event : Event<Int>) in
            print(event)
        }.disposed(by: bag)
        print("------------------------------------")
        //create
        let create = createObserable()
        create.subscribe { (event : Event<Any>) in
            print(event)
        }.disposed(by: bag)
        print("------------------------------------")
        //range
        let range = Observable.range(start: 1, count: 10)
        range.subscribe{(event : Event<Int>) in
            print(event)
        }.disposed(by: bag)
        print("------------------------------------")
        //range
        let reate = Observable.repeatElement("Hello World")
        reate.take(5).subscribe{(event : Event<String>) in
            print(event)
        }.disposed(by: bag)
    }
    
}
extension ViewController {
    fileprivate func createObserable() -> Observable<Any> {
        return Observable.create({ (observer : AnyObserver<Any>) ->
            Disposable in
            observer.onNext("coderwhy")
            observer.onNext("18")
            observer.onNext("1.88")
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
}

