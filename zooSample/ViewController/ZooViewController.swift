//
//  ViewController.swift
//  zooSample
//
//  Created by Hsu Hua on 2023/7/21.
//

import UIKit
import RxSwift
import RxCocoa
import Stevia

class ZooViewController: UIViewController, UITableViewDelegate {
    
    var viewModel: ZooViewModel
    private let tableView = UITableView()
    let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = ZooViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = ZooViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.subviews(
            tableView
        )
        tableView.fillContainer()
        setupTableView()
        
        
        viewModel.getExhibits { [weak self] result in
            switch result {
            case .success(let exhibits):
                self?.viewModel.exhibits.accept(exhibits)
                self?.bindViewModel(viewModel: self?.viewModel ?? ZooViewModel())
            case .failure(let error):
                print("Failed to get exhibits: \(error)")
            }
        }
    }

    
    private func bindViewModel(viewModel: ZooViewModel) {
//        print(viewModel.exhibits.value)
        viewModel.exhibits
            .asObservable()
            .compactMap { $0 } // Unwrap the Optional
            .bind(to: tableView.rx.items(cellIdentifier: "ZooCell", cellType: ZooTableViewCell.self)) { (row, element, cell) in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
    }




    private func setupTableView() {
        tableView.register(ZooTableViewCell.self, forCellReuseIdentifier: "ZooCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

