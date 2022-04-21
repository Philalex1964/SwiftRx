//
//  ViewController.swift
//  NetworkingRxSwift
//
//  Created by Aleksandar Filipov on 4/21/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var posts: [PostModel] = []
    let disposedBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let client = APIClient.shared
        
        title = "TableView + Networking"
        navigationController?.view.backgroundColor = .white
        
        
        
        do {
            try client.getRecipes().subscribe(
                onNext: { [weak self] result in
                    self?.posts = result
                    // MARK: display in UITableView
                },
                onError: { error in
                    print(error.localizedDescription)
                },
                onCompleted: {
                    print("Event completed")
                }) .disposed(by: disposedBag)
        } catch {
            print(error.localizedDescription)
        }
    }
}

