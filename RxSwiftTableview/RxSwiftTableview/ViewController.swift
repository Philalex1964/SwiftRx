//
//  ViewController.swift
//  RxSwiftTableview
//
//  Created by Aleksandar Filipov on 4/20/22.
//

import UIKit
import RxSwift
import RxCocoa

struct Product {
    let imageName : String
    let title: String
}

struct ProductViewModel {
    var items = PublishSubject<[Product]>()
    
    func fetchItems() {
        let products = [
        Product(imageName: "house", title: "Home"),
        Product(imageName: "gear", title: "Settings"),
        Product(imageName: "person.circle", title: "Profile"),
        Product(imageName: "airplane", title: "Flights"),
        Product(imageName: "bell", title: "Activity")
        ]
        
        items.onNext(products)
        items.onCompleted()
    }
}

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var viewModel = ProductViewModel()
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RxSwift TableView"

        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindTableViewData()
    }

    func bindTableViewData() {
        // Bind items to table
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, model, cell in
            cell.textLabel?.text = model.title
            cell.imageView?.image = UIImage(systemName: model.imageName)
        }.disposed(by: bag)
        
        // Bind a model selected handler
        tableView.rx.modelSelected(Product.self).bind { [weak self] product in
            print(product.title)
            let detailVC = UIViewController()
            detailVC.title = "Detail"
            detailVC.view.backgroundColor = .white
            
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }.disposed(by: bag)
        
        // fetch items
        viewModel.fetchItems()
    }

}

