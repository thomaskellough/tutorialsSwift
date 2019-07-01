//
//  WebViewController.swift
//  Project 16 - HWS Capital Cities
//
//  Created by Thomas Kellough on 7/1/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import WebKit
import UIKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var countryName: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if countryName == "Washington D.C." {
            countryName = "Washington,_D.C."
        }
        
        let urlString = "https://en.wikipedia.org/wiki/\(String(describing: countryName!))"
        print(urlString)

        if let url = URL(string: urlString){
            webView.load(URLRequest(url: url))
        }
        
    }
    

}
