//
//  HomeViewController.swift
//  Emperapool
//
//  Created by MAC on 4/14/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var gemLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.table.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier:"HomeTableViewCell")
        
        self.table.estimatedRowHeight = 125 * self.view.frame.height / 667
        
        self.table.rowHeight = 125 * self.view.frame.height / 667
        
        self.table.delegate = self
        
        self.table.dataSource = self

        
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HomeTableViewCell = table.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath as IndexPath) as! HomeTableViewCell
        
        
        return cell
    }
    
    
    

}
