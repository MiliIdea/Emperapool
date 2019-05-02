//
//  ChatViewController.swift
//  Emperapool
//
//  Created by MAC on 4/29/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChatViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var collection: UICollectionView!
    
    var chats : [ChatRow] = [ChatRow]()
    
    var chatWords : [String] = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collection.register(UINib(nibName: "ChatWordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ChatWordCollectionViewCell")
        
        self.table.register(UINib(nibName: "ChatRowTableViewCell", bundle: nil), forCellReuseIdentifier:"ChatRowTableViewCell")
        
        self.table.estimatedRowHeight = 30 * self.view.frame.height / 677
        
        self.table.rowHeight = 30 * self.view.frame.height / 677

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.chatWords = App.introRes?.chat_words ?? [String]()
        
        if(chatWords.isEmpty){
            self.collection.alpha = 0
        }
        self.collection.reloadData()
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatWords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ChatWordCollectionViewCell = collection.dequeueReusableCell(withReuseIdentifier: "ChatWordCollectionViewCell", for: indexPath as IndexPath) as! ChatWordCollectionViewCell
        let c = chatWords[indexPath.item]
        cell.wordLabel.text = c
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let font = UIFont.init(name: "SHABNAM-FD", size: 16) {
            let c = chatWords[indexPath.item]
            let fontAttributes = [NSAttributedString.Key.font: font]
            let myText = c
            let size = (myText as NSString).size(withAttributes: fontAttributes)
            return CGSize(width: size.width + (30 * self.view.frame.width / 375) , height: self.collection.height)
        }else{
            return CGSize(width: 100 , height: self.collection.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
