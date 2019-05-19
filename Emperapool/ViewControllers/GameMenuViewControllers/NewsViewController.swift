//
//  NewsViewController.swift
//  Emperapool
//
//  Created by MAC on 4/11/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController  ,UITableViewDelegate , UITableViewDataSource{

    
    @IBOutlet weak var table: UITableView!
    
    var news : [NewsRes] = [NewsRes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.table.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier:"NewsTableViewCell")
        
        self.table.estimatedRowHeight = 289 * self.view.frame.height / 667
        
        self.table.rowHeight = 289 * self.view.frame.height / 667
        
        
        App.showLoading(vc: self , navBotOrigin: 70 * self.view.frame.height / 667)
        MR.getNews(vc: self){res in
            App.dismissLoading(vc: self)
            if(res != nil && res?.data != nil ){
                self.news = (res?.data)!
                self.table.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NewsTableViewCell = table.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath as IndexPath) as! NewsTableViewCell
        let c = self.news[indexPath.row]
        
        cell.img.kf.setImage(with: URL.init(string: c.featured_image ?? ""))
        cell.header.text = c.title
        cell.desc.text = c.summary
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let c = self.news[indexPath.row]
        navigate(storyboardName: "GameMenu", vc: HelpWebViewsViewController.self){vc in
            vc.loadFromHtml = true
            vc.content = c.content ?? ""
            vc.myTitle = c.title ?? ""
        }
    }
   
    @IBAction func back(_ sender: Any) {
        self.back(self)
    }
    
}
