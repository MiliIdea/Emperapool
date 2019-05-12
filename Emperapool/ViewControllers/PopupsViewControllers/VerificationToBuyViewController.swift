//
//  VerificationToBuyViewController.swift
//  Emperapool
//
//  Created by MAC on 5/12/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import Kingfisher

class VerificationToBuyViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var titleDesc: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var productId : Int?
    var bId : Int?

    var coinAmount : String = ""
    var imgAddress : String = ""
    var popupTitle : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popupView.setY(y: self.view.height)
    }
    
    func setup(coinAmount : String , imgAddress : String ,popupTitle : String , productId : Int , bId : Int){
        self.coinAmount = coinAmount
        self.imgAddress = imgAddress
        self.popupTitle = popupTitle
        self.productId = productId
        self.bId = bId
    }
    
    override func viewDidLayoutSubviews() {
        self.coinLabel.text = self.coinAmount
        self.img.kf.setImage(with: URL.init(string: self.imgAddress))
        self.titleDesc.text = self.popupTitle
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
            
            self.popupView.setCenterY(y: self.view!.center.y)
            
        },completion: nil)
    }
    
    
    
    @IBAction func buy(_ sender: Any) {
        App.showLoading(vc: self, viewAlpha: 0.3)
        MR.payProduct(vc: self, productId: self.productId ?? 0, bId: self.bId ?? 0){res , status in
            if(res?.extra_data?.user != nil){
                App.profile = res?.extra_data?.user
                SwiftEventBus.post("profileUpdate")
            }
            if(res?.complete == true){
                self.view.makeToast("محصول با موفقیت خریداری شد!")
                SwiftEventBus.post("badgeUpdate")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.dismiss("")
                }
            }
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.clear
            
            self.popupView.frame.origin.y = self.view.frame.height
            
        }){completion in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    

}
