//
//  TopHeadlineViewController.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/8/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import UIKit

class TopHeadlineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var news: [New] = [New]()
    let currentPageSize: UInt = 20
    var currentPage: UInt = 1
    private let cellID = "NewsTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configTableView()
        self.getNews()
    }
    
    func getNews() {
        ServiceManager.instance.getHeadlines(pageSize: currentPageSize, page: currentPage) { [weak self](news) in
            self?.indicator.stopAnimating()
            guard news.count > 0 else { return }
            self?.news.append(contentsOf: news)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func configTableView() {
        self.tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier:cellID)
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 20
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}

//MARK: - UITableViewDataSource
extension TopHeadlineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! NewsTableCell
        cell.configCell(new: news[indexPath.row])
        return cell
    }
}
