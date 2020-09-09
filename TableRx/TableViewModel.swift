//
//  TableViewModel.swift
//  TableRx
//
//  Created by CHEN SINYU on 2020/09/09.
//  Copyright © 2020 CHEN SINYU. All rights reserved.
//

import UIKit
import RxSwift

class TableViewModel {
    var RamenShopsObserable : Variable<[RamenShop]> = {
        var shops : [RamenShop] = [RamenShop]()
        guard let path = Bundle.main.path(forResource:"Noodles", ofType:"tsv") else {
                   print("csvファイルがないよ")
                  return Variable(shops)
               }
        do {
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let csvLines = csvString.components(separatedBy: "\r\n")
            for data in csvLines {
                let dict = data.components(separatedBy: "\t")
                if(dict[0] != "LR"){
                    shops.append(RamenShop(name: dict[0], address: dict[1]))
                }
            }
            
        } catch let error as NSError {
            print("エラー: \(error)")
            return Variable(shops)
        }
        return Variable(shops)
    }()
}
