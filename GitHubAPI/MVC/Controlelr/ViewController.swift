//
//  ViewController.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchText: UITextField!
    private var repositoly: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    @IBAction private func search(_ sender: Any) {
        guard let searchWord = searchText.text else {return}
        
        GitHubAPI.fetch(by: searchWord) { result in
            guard let resultArray = result.right?.items else {return}
            self.repositoly = resultArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoly.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell else {return UITableViewCell()}
        cell.configure(with: repositoly, indexPath: indexPath)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
