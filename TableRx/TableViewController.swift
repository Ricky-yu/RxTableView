//
//  TableViewController.swift
//  TableRx
//
//  Created by CHEN SINYU on 2020/09/09.
//  Copyright © 2020 CHEN SINYU. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    fileprivate var shops : [RamenShop]?
    let viewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.RamenShopsObserable.asObservable()
            .bind(to:tableView.rx.items(cellIdentifier: "Cell",
                                        cellType:UITableViewCell.self)) { row,shop,cell in
                                            cell.textLabel?.text = shop.name
                                            cell.detailTextLabel?.text = shop.address
        }.disposed(by: bag)
        
        tableView.rx.itemSelected.subscribe(onNext:{(indexPath) in
            print(indexPath)
        }).disposed(by: bag)
        
        tableView.rx.modelSelected(RamenShop.self).subscribe(onNext:{(shop) in
            print(shop.name)
            print(shop.address)
        }).disposed(by: bag)
        
    }
    
    @IBAction func itemClick(_ sender: Any) {
        let shop = RamenShop(name: "", address: "")
        viewModel.RamenShopsObserable.value = [shop]
    }
    
}
