//
//  MoreOpenLinkViewController.swift
//  Edulinu
//
//  Created by Laurens Kropf on 11.03.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import WebKit

class MoreOpenLinkViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var moreWebView: WKWebView!
    
    @IBOutlet weak var moreActivity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.title = moreTitleView
        
        self.moreWebView.addSubview(self.moreActivity)
        self.moreActivity.startAnimating()
        self.moreWebView.navigationDelegate = self
        
        let request = URLRequest(url: moreLinkView!)
        moreWebView.load(request)

        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        moreActivity.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        moreActivity.stopAnimating()
    }
    


}
