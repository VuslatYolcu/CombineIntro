//
//  ViewController.swift
//  CombineIntro
//
//  Created by Vuslat Yolcu on 8.10.2023.
//

import UIKit
import Combine

class MyCustomViewCell: UITableViewCell {
    
}

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyCustomViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // Comes with Combine Framework
    var observer: AnyCancellable?
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        getCompanies()
    }

    
    private func getCompanies() {
        observer = APICaller.shared.fetchCompanies()
            .receive(on: DispatchQueue.main) // Main threadde almak istediğini söylüyorsun
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("finished")
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { [weak self] value in
            self?.models = value
            self?.tableView.reloadData()
        })
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCustomViewCell else {
            fatalError()
        }
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
}

