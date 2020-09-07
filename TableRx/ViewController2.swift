//
//  ViewController2.swift
//  TableRx
//
//  Created by CHEN SINYU on 2020/09/07.
//  Copyright © 2020 CHEN SINYU. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController2: UIViewController {
    fileprivate let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // publisSubject 能訂閱也能發出事件 但只能訂閱之後發出的事件
        let publishSub = PublishSubject<String>()
        publishSub.onNext("18")
        publishSub.subscribe{(event : Event<String>) in
            print(event)
        }.disposed(by: bag)
        publishSub.onNext("coderwhy")
        print("------------------------------------")
        
        // ReplaySubject 能訂閱之後發出跟之前的事件 但訂閱之前的事件只能在最大訂閱數之內
        let replaySub = ReplaySubject<String>.create(bufferSize: 2)
        replaySub.onNext("a")
        replaySub.onNext("b")
        replaySub.onNext("c")
        
        replaySub.subscribe {(event : Event<String>) in
            print(event)
        }.disposed(by: bag)
        
        replaySub.onNext("d")
        print("------------------------------------")
        // BehaviorSubject 能訂閱之後發出跟之前的事件 但訂閱之前的事件只能是最後一個事件
        let behaviroSub = BehaviorSubject<String>(value: "a")
        behaviroSub.onNext("a")
        behaviroSub.onNext("b")
        behaviroSub.onNext("c")
        
        behaviroSub.subscribe {(event : Event<String>) in
            print(event)
        }.disposed(by: bag)
        
        behaviroSub.onNext("d")
        print("------------------------------------")
        // Variable 相當於BehaviorSubject進行裝箱
        //如果想將Variable當成Obserable來讓其他物件訂閱的話就需要asObserable轉成Obserable
        //如果Variable打算發出事件 直接修改對象的 Value
        //當事件結束時 Variable會自動發出completed 事件
        let variable = Variable("a")
        variable.value = "b"
        
        variable.asObservable().subscribe{(event : Event<String>) in
            print(event)
        }.disposed(by: bag)
        variable.value = "c"
        variable.value = "d"
    }
    
}
