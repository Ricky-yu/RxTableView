//
//  RamenShop.swift
//  TableRx
//
//  Created by CHEN SINYU on 2020/09/09.
//  Copyright © 2020 CHEN SINYU. All rights reserved.
//

import UIKit

class RamenShop: NSObject {
    var name : String = ""
    var address : String = ""
    
    init(name: String, address: String) {
        super.init()
        
        self.name = name
        self.address = address
    }
}
