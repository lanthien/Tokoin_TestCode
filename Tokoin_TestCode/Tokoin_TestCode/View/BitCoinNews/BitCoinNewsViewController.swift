//
//  BitCoinNewsViewController.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/8/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import UIKit

class BitCoinNewsViewController: TopHeadlineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func getNews() {
        ServiceManager.instance.getBitcoinNews(pageSize: self.currentPageSize, page: self.currentPage) { [weak self](news) in
            self?.indicator.stopAnimating()
            guard news.count > 0 else { return }
            self?.news.append(contentsOf: news)
            DispatchQueue.main.async {
                self?.view.backgroundColor = .lightGray
                self?.tableView.reloadData()
            }
        }
    }
}
