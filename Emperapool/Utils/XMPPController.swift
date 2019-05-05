//
//  XMPPController.swift
//  Emperapool
//
//  Created by MAC on 4/28/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import XMPPFramework
import SWXMLHash

enum XMPPControllerError: Error {
    case wrongUserJID
}

public protocol EmperapoolXMPPDelegate: AnyObject {
    func reciveQuestion(sender: Question)
    func reciveChat(sender: ChatRow)
    func updateOnlineUser(sender : OnlineUsers?)
    func nowIsOnline()
}

class XMPPController: NSObject {
    
    var xmppStream: XMPPStream
    
    var chatRoom : XMPPRoom?
    
    var dataRoom : XMPPRoom?
    
    weak var delegate: EmperapoolXMPPDelegate?
    
    let hostName: String
    let userJID: XMPPJID
    let hostPort: UInt16
    let password: String
    let dataRoomAddress : String
    let chatRoomAddress : String
    
    init(hostName: String, userJIDString: String, hostPort: UInt16 = 5222, password: String , dataRoomAddress : String , chatRoomAddress : String) throws {

        guard let userJID = XMPPJID(string: userJIDString) else {
            throw XMPPControllerError.wrongUserJID
        }
        
        self.hostName = hostName
        self.userJID = userJID
        self.hostPort = hostPort
        self.password = password
        self.dataRoomAddress = dataRoomAddress
        self.chatRoomAddress = chatRoomAddress
        
        // Stream Configuration
        self.xmppStream = XMPPStream()
        self.xmppStream.hostName = hostName
        self.xmppStream.hostPort = hostPort
        self.xmppStream.startTLSPolicy = XMPPStreamStartTLSPolicy.allowed
        self.xmppStream.myJID = userJID
    
        super.init()
        self.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    func connect() {
        if !self.xmppStream.isDisconnected {
            return
        }
        
        try! self.xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
    }
    
    
    func sendMessage(txt : String){
        if(self.chatRoom?.isJoined ?? false){
            let row : ChatRow = .init(name: App.profile?.display_name, avatar: App.profile?.avatar, txt: txt)
            let message : XMPPMessage = .init()
            message.addBody(row.name ?? "", withLanguage: "nikName")
            message.addBody(row.avatar ?? "", withLanguage: "avatar")
            message.addBody(row.messageText ?? "")
            self.chatRoom?.send(message)
        }
    }
}

extension XMPPController: XMPPStreamDelegate {
    
    func xmppStreamDidConnect(_ stream: XMPPStream) {
        print("Stream: Connected")
        try! stream.authenticate(withPassword: self.password)
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        self.delegate?.nowIsOnline()
        do{
            self.xmppStream.send(XMPPPresence())
            print("Stream: Authenticated")
            let roomStorage: XMPPRoomMemoryStorage = XMPPRoomMemoryStorage()
            //"data_49_0@conference.chat.emperapool.com"
            self.dataRoom = XMPPRoom.init(roomStorage: roomStorage, jid: XMPPJID.init(string: self.dataRoomAddress)! , dispatchQueue: .main)
            self.dataRoom?.activate(self.xmppStream)
            self.dataRoom?.addDelegate(self, delegateQueue: .main)
            self.dataRoom?.join(usingNickname: self.userJID.bare, history: try .init(xmlString: "<history maxstanzas='0'/>"))
            //"chat_49_0@conference.chat.emperapool.com"
            self.chatRoom = XMPPRoom.init(roomStorage: roomStorage, jid: XMPPJID.init(string: self.chatRoomAddress)! , dispatchQueue: .main)
            self.chatRoom?.activate(self.xmppStream)
            self.chatRoom?.addDelegate(self, delegateQueue: .main)
            self.chatRoom?.join(usingNickname: self.userJID.bare, history: try .init(xmlString: "<history maxstanzas='0'/>"))
        }catch{
            print(error)
        }
    }
    
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        print("Stream: Fail to Authenticate")
    }
    
    func xmppStream(_ sender: XMPPStream, willReceive message: XMPPMessage) -> XMPPMessage? {
        print("---->")
        if(message.body == nil){
            return nil
        }
        do {

            let result = try App.decoder.decode(StreamDataRes.self, from: message.body!.data(using: .utf8)!)
            if(result.question != nil){
                self.delegate?.reciveQuestion(sender: result.question!)
            }
            if(result.onlineUsers != nil){
                self.delegate?.updateOnlineUser(sender: result.onlineUsers )
            }
        } catch {
            let name : String = message.body(forLanguage: "nikName") ?? ""
            let avatar : String = message.body(forLanguage: "avatar") ?? ""
            let txt : String = message.body(forLanguage: "") ?? ""
            do{
                let result = try App.decoder.decode(StreamDataRes.self, from: txt.data(using: .utf8)!)
                if(result.question != nil){
                    self.delegate?.reciveQuestion(sender: result.question!)
                }
                if(result.onlineUsers != nil){
                    self.delegate?.updateOnlineUser(sender: result.onlineUsers )
                }
            }catch{
                let row = ChatRow.init(name: name, avatar: avatar, txt: txt)
                self.delegate?.reciveChat(sender: row)
            }
            
        }
        return nil
    }
}

public struct ChatRow {
    let name : String?
    let avatar : String?
    let messageText : String?
    init(name : String? , avatar : String? , txt : String?) {
        self.name = name
        self.avatar = avatar
        self.messageText = txt
    }
}

