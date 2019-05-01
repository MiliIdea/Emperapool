//
//  GameBoardViewController.swift
//  Emperapool
//
//  Created by MAC on 4/30/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class GameBoardViewController: UIViewController  , EmperapoolXMPPDelegate{
    
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var chatView: UIView!
    
    var questionViewController : QuestionViewController?
    
    var chatViewController : ChatViewController?
    
    var xmpp : XMPPController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            self.xmpp = try XMPPController.init(hostName: "chat.emperapool.com", userJIDString: "88_emp@chat.emperapool.com", password: "I17KIAALO31VMWI")
            self.xmpp?.delegate = self
            self.xmpp!.connect()
            
        }catch{
            print(error)
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
