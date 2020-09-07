//
//  ViewController3.swift
//  TableRx
//
//  Created by CHEN SINYU on 2020/09/07.
//  Copyright © 2020 CHEN SINYU. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct Student {
    var score : Variable<Double>
}

class ViewController3: UIViewController {
    
    fileprivate lazy var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // map
        Observable.of(1, 2, 3, 4)
            .map{(num : Int) -> Int in
                return num * num
        }.subscribe{(event : Event<Int>) in
            print(event)
        }.disposed(by: bag)
        print("------------------------------------")
        // flatMapLatest 只會對最新的Observable訂閱
        let stu1 = Student(score: Variable(80))
        let stu2 = Student(score: Variable(100))
        
        let studentVariable = Variable(stu1)
        
        studentVariable.asObservable()
            .flatMapLatest{ (stu : Student) -> Observable<Double> in
                return stu.score.asObservable()
        }
        .subscribe { (event : Event<Double>) in
            print(event)
        }
        .disposed(by: bag)
        
        studentVariable.value = stu2
        stu2.score.value = 0
        stu1.score.value = 1000
        
        
        
    }


}
