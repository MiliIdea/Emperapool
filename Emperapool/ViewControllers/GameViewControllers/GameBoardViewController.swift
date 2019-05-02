//
//  GameBoardViewController.swift
//  Emperapool
//
//  Created by MAC on 4/30/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
import DCKit

class GameBoardViewController: UIViewController  , EmperapoolXMPPDelegate{
    
    @IBOutlet weak var hideCommentButton: DCBorderedButton!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var chatView: UIView!
    
    var questionViewController : QuestionViewController?
    
    var chatViewController : ChatViewController?
    
    var xmpp : XMPPController?
    
    var gameRules : GameListRes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MR.joinGame(vc: self, gameId: (self.gameRules?.id)!){res in
            if(res != nil && res?.extra_data != nil){
                do{
                    //"88_emp@chat.emperapool.com"
                    //"I17KIAALO31VMWI"
                    self.xmpp = try XMPPController.init(hostName: "chat.emperapool.com", userJIDString: ((App.profile?.id!.description)! + "_emp@chat.emperapool.com"), password: (App.profile?.chat_token)!, dataRoomAddress: res?.extra_data?.data_room ?? "" , chatRoomAddress : res?.extra_data?.chat_room ?? "" )
                    self.xmpp?.delegate = self
                    self.xmpp!.connect()
                    
                }catch{
                    print(error)
                }
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        self.hideCommentButton.setY(y: self.questionView.height + self.questionView.y)
        self.chatView.setY(y: self.hideCommentButton.height + self.hideCommentButton.y)
    }
    
    @IBAction func hideComments(_ sender: Any) {
        if(self.hideCommentButton.y == self.questionView.height + self.questionView.y){
            UIView.animate(withDuration: 0.2, delay: 0.0 , options: .curveEaseInOut, animations: {
                self.hideCommentButton.setY(y: self.view.height - self.hideCommentButton.height - 10)
                self.chatView.setY(y: self.view.height)
                self.hideCommentButton.setTitle("نمایش نظرات", for: .normal)
                self.hideCommentButton.setImage(UIImage.init(named: "arrowup"), for: .normal)
            }){completion in }
        }else{
            UIView.animate(withDuration: 0.2, delay: 0.0 , options: .curveEaseInOut, animations: {
                self.hideCommentButton.setY(y: self.questionView.height + self.questionView.y)
                self.chatView.setY(y: self.hideCommentButton.height + self.hideCommentButton.y)
                self.hideCommentButton.setTitle("پنهان کردن نظرات", for: .normal)
                self.hideCommentButton.setImage(UIImage.init(named: "updown1"), for: .normal)
            }){completion in }
        }
        
    }
    
    
    func reciveQuestion(sender: Question) {
        print("recive question")
        print(sender)
        self.questionViewController?.previewQuestion(question: sender)
    }
    
    func reciveChat(sender: ChatRow) {
        print("recive chat")
        print(sender)
        self.chatViewController?.chats.append(sender)
        self.chatViewController?.updateTable()
    }
    
    func updateOnlineUser(sender: OnlineUsers?) {
        self.questionViewController?.updateOnlineCount(onlineCount: sender)
    }
    
    func nowIsOnline() {
        self.questionViewController?.isOfflineButton.setTitle("آنلاین", for: .normal)
        self.questionViewController?.isOfflineButton.backgroundColor = UIColor("#8BD760")
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questionIdentifier" {
            questionViewController = segue.destination as? QuestionViewController
        }else if(segue.identifier == "chatIdentifier"){
            chatViewController = segue.destination as? ChatViewController
        }
    }
 

    
}
