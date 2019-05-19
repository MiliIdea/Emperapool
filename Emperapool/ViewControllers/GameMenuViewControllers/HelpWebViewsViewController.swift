//
//  HelpWebViewsViewController.swift
//  Emperapool
//
//  Created by MAC on 5/13/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import WebKit

class HelpWebViewsViewController: UIViewController {

    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var myWebView: UIWebView!
    
    var urlToLoad : String = ""
    var myTitle : String = ""
    var content : String = ""
    var loadFromHtml : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        self.topTitle.text = self.myTitle
        if(!loadFromHtml){
            self.myWebView.loadRequest(URLRequest.init(url: URL.init(string: ("http://" + urlToLoad))!))
        }else{
            self.myWebView.loadHTMLString(content, baseURL: nil)
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
