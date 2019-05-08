//
//  ChatViewController.swift
//  Emperapool
//
//  Created by MAC on 4/29/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import DCKit
import UICircularProgressRing

class ChatViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var collection: UICollectionView!
    
    var chats : [ChatRow] = [ChatRow]()
    
    var chatWords : [String] = [String]()
    
    @IBOutlet weak var dynamicView: UIView!
    
    @IBOutlet weak var staticView: UIView!
    
    @IBOutlet weak var txtField: DCBorderedTextField!
    
    @IBOutlet weak var stopChatView: UIView!
    
    @IBOutlet weak var chatTimer: UICircularTimerRing!
    
    @IBOutlet weak var goDynamicBox: DCBorderedView!
    
    @IBOutlet weak var goStaticButton: UIButton!
    
    @IBOutlet weak var stopLabel: UILabel!
    
    var chatIsLock : Bool = false
    
    var chatType : Int = 2
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        IQKeyboardManager.shared.enable = true
        
        IQKeyboardManager.setAccessibilityElementsHidden(true)
        
//        self.hideKeyboardWhenTappedAround()
        
        collection.register(UINib(nibName: "ChatWordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ChatWordCollectionViewCell")
        
        self.table.register(UINib(nibName: "ChatRowTableViewCell", bundle: nil), forCellReuseIdentifier:"ChatRowTableViewCell")
        
        self.table.estimatedRowHeight = 30 * self.view.frame.height / 677
        
        self.table.rowHeight = 30 * self.view.frame.height / 677

        self.dynamicView.alpha = 0
        
        self.staticView.alpha = 1
        
        self.chatTimer.alpha = 0
        
        self.chatTimer.valueFormatter = UICircularProgressRingFormatter.init(valueIndicator: "", rightToLeft: true, showFloatingPoint: false, decimalPlaces: 2)
        
        self.chatTimer.innerCapStyle = .round
        
        self.chatTimer.font = UIFont.init(name: "Shabnam-FD", size: 23)!
        
        self.stopChatView.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.chatWords = App.introRes?.chat_words ?? [String]()
        
        if(chatWords.isEmpty){
            self.collection.alpha = 0
        }
        self.collection.reloadData()
        
        self.chatType = (self.parent as! GameBoardViewController).gameRules?.rules?.conditions?.chat_type ?? 2
        
        switch chatType {
        case 0:
            self.stopChatView.alpha = 1
        case 1:
            self.goDynamicBox.alpha = 0
        case 3:
            self.goStaticButton.alpha = 0
            self.staticView.alpha = 0
            self.dynamicView.alpha = 1
        default:
            print("chat is free")
        }
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
    
    func sendMessage(txt : String){
        if(!chatIsLock){
            (self.parent as! GameBoardViewController).xmpp?.sendMessage(txt: txt)
            chatIsLock = true
            if(self.staticView.alpha == 1){
                self.staticView.alpha = 0.4
            }
            if(self.dynamicView.alpha == 1){
                self.dynamicView.alpha = 0.4
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.chatIsLock = false
                if(self.staticView.alpha != 0){
                    self.staticView.alpha = 1
                }
                if(self.dynamicView.alpha != 0){
                    self.dynamicView.alpha = 1
                }
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ChatWordCollectionViewCell = collection.dequeueReusableCell(withReuseIdentifier: "ChatWordCollectionViewCell", for: indexPath as IndexPath) as! ChatWordCollectionViewCell
        let c = chatWords[indexPath.item]
        cell.wordLabel.text = c
        
        return cell
    }
    @IBAction func sendEmoji(_ sender: Any) {
        self.sendMessage(txt: (sender as! UIButton).title(for: .normal) ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.sendMessage(txt: self.chatWords[indexPath.item])
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

    
    @IBAction func sendDynamicComment(_ sender: Any) {
        if(self.txtField.text == nil || self.txtField.text == ""){
            return
        }
        self.sendMessage(txt: self.txtField.text!)
        self.txtField.text = ""
        self.view.endEditing(true)
    }
    
    @IBAction func goStaticChat(_ sender: Any) {
        if(!self.chatIsLock){
            self.staticView.alpha = 1
            self.dynamicView.alpha = 0
        }
    }
    
    @IBAction func goKeyboard(_ sender: Any) {
        if(!self.chatIsLock){
            self.staticView.alpha = 0
            self.dynamicView.alpha = 1
            self.txtField.resignFirstResponder()
        }
        
    }
    
    
    func stopChat(time : Int , chatQuestionType : Int){
        if(chatQuestionType == 0 || chatQuestionType == 3){
            self.view.endEditing(true)
            UIView.animate(withDuration: 0.2, delay: 0.0 , options: .curveEaseInOut, animations: {
                self.stopChatView.alpha = 1
            }){completion in }
            if(chatQuestionType == 3){
                self.chatTimer.alpha = 1
                self.stopLabel.alpha = 1
            }
            self.chatTimer.startTimer(to: TimeInterval(time)) { state in
                switch state {
                case .finished:
                    self.stopChatView.alpha = 0
                    self.chatTimer.alpha = 0
                    self.stopLabel.alpha = 0
                    self.chatTimer.resetTimer()
                case .continued(let time):
                    print("continued: \(time ?? 0)")
                case .paused(let time):
                    print("paused: \(time ?? 0)")
                }
            }
        }else if(chatQuestionType == 2){
            self.view.endEditing(true)
            self.goDynamicBox.alpha = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
                self.goDynamicBox.alpha = 1
            }
        }
        
        
        
        switch chatType {
        case 0:
            self.stopChatView.alpha = 1
        case 1:
            self.goDynamicBox.alpha = 0
        case 3:
            self.goStaticButton.alpha = 0
            self.staticView.alpha = 0
            self.dynamicView.alpha = 1
        default:
            print("chat is free")
        }
    }
}
