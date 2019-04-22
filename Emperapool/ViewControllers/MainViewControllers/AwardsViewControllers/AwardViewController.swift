//
//  AwardViewController.swift
//  Emperapool
//
//  Created by MAC on 4/14/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class AwardViewController: UIViewController  ,UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var table: UITableView!
    
    var prizeList : [PrizeRes] = [PrizeRes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.table.register(UINib(nibName: "prizeTableViewCell", bundle: nil), forCellReuseIdentifier:"prizeTableViewCell")
        
        self.table.estimatedRowHeight = 170 * self.parent!.view.frame.height / 667
        
        self.table.rowHeight = 170 * self.parent!.view.frame.height / 667
        
        self.table.delegate = self
        
        self.table.dataSource = self
        
        
        
        App.showLoading(vc: self)
        MR.getPrizeList(vc: self){res in
            App.dismissLoading(vc: self)
            if(res?.data != nil && !(res?.data!.isEmpty)!){
                self.prizeList = (res?.data)!
                self.table.reloadData()
                self.table.setHeight(height: self.table.rowHeight * CGFloat(self.prizeList.count))
                self.myScrollView.contentSize.height = self.table.height + self.table.y + (80 * self.parent!.view.frame.height / 667)
            }
        }
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prizeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : prizeTableViewCell = table.dequeueReusableCell(withIdentifier: "prizeTableViewCell", for: indexPath as IndexPath) as! prizeTableViewCell
        let c = self.prizeList[indexPath.row]
     
        cell.prizeIcon.kf.setImage(with: URL(string: c.icon ?? ""))
        
        cell.prizeTitle.text = c.title ?? ""
        
        cell.gemCost.text = (c.gem ?? 1000).description
        
        return cell
    }

}
