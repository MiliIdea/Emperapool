//
//  ChatViewController.swift
//  Emperapool
//
//  Created by MAC on 4/29/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var table: UITableView!
    
    var chats : [ChatRow] = [ChatRow]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.table.register(UINib(nibName: "ChatRowTableViewCell", bundle: nil), forCellReuseIdentifier:"ChatRowTableViewCell")
        
        self.table.estimatedRowHeight = 40 * self.view.frame.height / 677
        
        self.table.rowHeight = 40 * self.view.frame.height / 677

        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ChatRowTableViewCell = table.dequeueReusableCell(withIdentifier: "ChatRowTableViewCell", for: indexPath as IndexPath) as! ChatRowTableViewCell
        let c = self.chats[indexPath.row]
        if(c.avatar == nil || c.avatar == ""){
            cell.profileImage.image = UIImage.init(named: "22")
        }else{
            cell.profileImage.kf.setImage(with: URL.init(string: c.avatar ?? ""))
        }
        cell.name.text = c.name!
        let maximumLabelSize: CGSize = CGSize(width: 280, height: 9999)
        let expectedLabelSize: CGSize = cell.name.sizeThatFits(maximumLabelSize)
        cell.nameWidth.constant = expectedLabelSize.width
        cell.txt.text = c.messageText
        
        return cell
    }
    
    func updateTable(){
        self.table.beginUpdates()
        self.table.insertRows(at: [IndexPath(row: chats.count-1, section: 0)], with: .bottom)
        self.table.endUpdates()
        self.scrollToBottom()
    }

    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.chats.count-1, section: 0)
            self.table.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
