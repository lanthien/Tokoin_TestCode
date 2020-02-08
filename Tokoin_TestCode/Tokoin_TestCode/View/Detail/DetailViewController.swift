//
//  DetailViewController.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/8/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet private weak var btnBack: UIBarButtonItem!
    @IBOutlet private weak var btnNext: UIBarButtonItem!
    @IBOutlet private weak var webView: WKWebView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = self.url {
            self.webView.load(URLRequest(url: url))
        }
        
        self.webView.addObserver(self, forKeyPath: "canGoBack", options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: "canGoForward", options: .new, context: nil)
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "canGoBack")
        self.webView.removeObserver(self, forKeyPath: "canGoForward")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else { return }
        if keyPath == "canGoBack" {
            self.btnBack.isEnabled = self.webView.canGoBack
        } else if keyPath == "canGoForward" {
            self.btnNext.isEnabled = self.webView.canGoForward
        }
    }
    
    @IBAction private func tapOnClose(_ sender: UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tapOnBack(_ sender: UIBarButtonItem!) {
        self.webView.goBack()
    }
    
    @IBAction private func tapOnNext(_ sender: UIBarButtonItem!) {
        self.webView.goForward()
    }
}
