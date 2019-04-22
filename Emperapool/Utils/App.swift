//
//  App.swift
//  Emperapool
//
//  Created by MAC on 4/9/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import Foundation
import UIKit
import Lottie

public class App {
    
    static let defaults: UserDefaults = UserDefaults.standard
    
    static var decoder : JSONDecoder {
        get{
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            return decoder
        }
    }
    
    static func publicHeader(_ token : String = ((App.defaults.object(forKey: DefaultStrings.token) as? String) ?? "") , api : String = "1.0") -> [String : String] {
        var head = ["os" : "iOS" , "os-version" : UIDevice.current.systemVersion , "app-version" : Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String , "api-version" : api]
        if(token != ""){
            head["Authorization"] = "Bearer " + token
            print(head["Authorization"] as Any)
        }
        print(head)
        return head
    }
    
    // - MARK: LoadingMethodes
    
    static func showLoading(vc : UIViewController , navBotOrigin : CGFloat = 0 , viewAlpha : CGFloat = 1 , withLoading : Bool = true){
        
        let nav : CGFloat = navBotOrigin
        
//        if(navBotOrigin == -1){
//            nav = 0 * vc.view.frame.height / 677
//        }
        
        let h = vc.view.frame.height - nav
        
        let w = vc.view.frame.width
        
        let loadingView : UIView = UIView.init(frame: .init(x: 0, y: nav, width: w, height: h))
        
        let lotWidth = 40 * vc.view.frame.height / 677
        
        let lottieView : UIView = UIView.init(frame: .init(x: ((w / 2) - (lotWidth / 2)), y: ((h / 2) - (lotWidth / 2)) , width: lotWidth, height: lotWidth ))
        
        lottieView.backgroundColor = UIColor.clear
        
        lottieView.tag = 4321
        
        if(withLoading){
            loadingView.addSubview(lottieView)
        }
        
        loadingView.backgroundColor = UIColor.white
        
        loadingView.alpha = viewAlpha
        
        loadingView.tag = 1234
        
        if(vc.view.viewWithTag(1234) != nil){
            return
        }
        
        vc.view.addSubview(loadingView)
        
        let animationView = AnimationView(name: "loading")
        
        animationView.frame.size = lottieView.frame.size
        
        animationView.frame.origin = .init(x: 0, y: 0)
        
        animationView.contentMode = UIView.ContentMode.scaleAspectFit
        
        animationView.alpha = 1
        
        if(withLoading){
            
            lottieView.addSubview(animationView)
            
            animationView.loopMode = .loop
            
            animationView.play()
            
        }
    }
    
    
    static func dismissLoading(vc : UIViewController){
        
        let v = vc.view.viewWithTag(1234)
        
        if(v != nil){
            UIView.animate(withDuration: 0.2, delay: 0.0 , options: .curveEaseInOut, animations: {
                v?.alpha = 0
            }){completion in
                v?.removeFromSuperview()
            }
        }
        
    }
    
}
