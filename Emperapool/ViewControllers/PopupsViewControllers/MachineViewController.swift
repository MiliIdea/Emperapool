//
//  MachineViewController.swift
//  Emperapool
//
//  Created by MAC on 4/24/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import iCarousel

class MachineViewController: UIViewController  , iCarouselDelegate , iCarouselDataSource{
    
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var wheelView: iCarousel!
    
    @IBOutlet weak var rollView: UIImageView!
    
    @IBOutlet weak var rollButton: UIButton!
    
    @IBOutlet weak var arrow: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var retryButton: UIButton!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    @IBOutlet weak var retryLabel: UILabel!
    
    @IBOutlet weak var lightOn: UIImageView!
    
    @IBOutlet weak var lightOff: UIImageView!
    
    var imageArrays : [UIImage] = [UIImage]()
    
    var dailyMachineResponse : DailyMachineRes?
    
    var firstPosition : CGPoint?
    
    var choice : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        App.showLoading(vc: self)
        self.wheelView.setHeight(height: self.wheelView.width)
        self.wheelView.layer.cornerRadius = self.wheelView.height / 2
        self.firstPosition = self.rollButton.frame.origin
        if(dailyMachineResponse != nil){
            _ = UIImageView.init().kf.setImage(with: URL.init(string: dailyMachineResponse?.image ?? "")){res ,er , c ,t in
                self.imageArrays = self.splitImage(row: self.dailyMachineResponse!.options!.count, oImg: res!)
                self.wheelView.type = .invertedCylinder
                self.wheelView.isVertical = true
                self.wheelView.delegate = self
                self.wheelView.dataSource = self
                self.wheelView.scrollToItemBoundary = false
                self.wheelView.isUserInteractionEnabled = false
            }
            
        }
        
        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(runOnAndOff), userInfo: nil, repeats: true)
        rollButton.addTarget(self, action: #selector(wasDragged(btnVar:evtVar:)), for: UIControl.Event.touchDragInside)
        rollButton.addTarget(self, action: #selector(releaseDrag), for: UIControl.Event.touchUpOutside)
        rollButton.addTarget(self, action: #selector(releaseDrag), for: UIControl.Event.touchUpInside)
        rollButton.addTarget(self, action: #selector(releaseDrag), for: UIControl.Event.touchCancel)
        
        MR.getRollMachine(vc: self, machineId: (self.dailyMachineResponse?.id!.description)!){res in
            App.dismissLoading(vc: self)
            if(res != nil && res?.data != nil && !res!.data!.isEmpty){
                self.choice = res?.extra_data?.choice
            }
        }
    }
    
    func roll() {
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(rotateWheel), userInfo: nil, repeats: false)
        wheelView.autoscroll = 15
    }
    
   
    @IBAction func retry(_ sender: Any) {
        self.rollButton.isUserInteractionEnabled = true
    }
    
    @objc func runOnAndOff(){
        if(self.lightOn.alpha == 1){
            UIView.animate(withDuration: 0.8 , delay: 0 , options: .curveEaseInOut, animations: {
                self.lightOn.alpha = 0
                self.lightOff.alpha = 1
            },completion: nil)
        }else{
            UIView.animate(withDuration: 1 , delay: 0 , options: .curveEaseInOut, animations: {
                self.lightOn.alpha = 1
                self.lightOff.alpha = 0
            },completion: nil)
        }
    }
    
    @objc func wasDragged(btnVar : UIButton, evtVar :UIEvent)
    {
        let touch : UITouch = (evtVar.touches(for: btnVar)?.first)! as UITouch
        let previousLocation : CGPoint = touch .previousLocation(in: btnVar)
        let location : CGPoint = touch .location(in: btnVar)
        let delta_y :CGFloat = location.y - previousLocation.y
        var newY = btnVar.center.y + delta_y
        if(newY < self.firstPosition!.y){
            newY = self.firstPosition!.y
        }
        if(newY > self.rollView.y + self.rollView.height - (self.rollButton.height / 2)){
            newY = self.rollView.y + self.rollView.height - (self.rollButton.height / 2)
            btnVar.center = CGPoint(x: btnVar.center.x , y: newY)
            self.updateArrowView()
            self.roll()
            self.releaseDrag()
            self.rollButton.isUserInteractionEnabled = false
            return
        }
        btnVar.center = CGPoint(x: btnVar.center.x , y: newY)
        self.updateArrowView()
    }
    
    @objc func releaseDrag(){
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: {
            self.rollButton.frame.origin = self.firstPosition!
            self.updateArrowView()
        },completion: nil)
    }
    
    func updateArrowView(){
        self.arrow.setY(y: self.rollButton.y + self.rollButton.height)
        self.arrow.setHeight(height: (self.rollView.y + self.rollView.height) - self.arrow.y)
    }
    
    
    @IBAction func closeMachine(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
    @objc func rotateWheel() {
        wheelView.autoscroll = 0
        wheelView.scrollToItem(at: choice ?? 0, animated: true)
        self.closeButton.alpha = 1
        self.closeLabel.alpha = 1
        self.retryButton.alpha = 1
        self.retryLabel.alpha = 1
    }
    
    
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.imageArrays.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
//        var img : UIImageView = UIImageView.init(image: UIImage.init(named: "22"))
        let img : UIImageView = UIImageView.init(image: self.imageArrays[index])
        let w = 100 * self.view.height / 677
        img.frame.size = .init(width: w, height: w)
        return img
    }
    

    
    func splitImage(row : Int , oImg : UIImage) -> [UIImage]{
        
        let column : Int = 1
        let height =  (oImg.size.height) /  CGFloat (row) //height of each image tile
        let width =  (oImg.size.width)  / CGFloat (column)  //width of each image tile
        
        let scale = (oImg.scale) //scale conversion factor is needed as UIImage make use of "points" whereas CGImage use pixels.
        
        var imageArr = [[UIImage]]() // will contain small pieces of image
        for x in 0..<column{
            var yArr = [UIImage]()
            for y in 0..<row{
                UIGraphicsBeginImageContextWithOptions(
                    CGSize(width:width, height:height),
                    false, 0)
                let i =  oImg.cgImage?.cropping(to:  CGRect.init(x: CGFloat(x) * width * scale, y:  CGFloat(y) * height * scale  , width: width * scale  , height: height * scale) )
                
                let newImg = UIImage.init(cgImage: i!)
                
                yArr.append(newImg)
                
                UIGraphicsEndImageContext();
                
            }
            
            imageArr.append(yArr)
        }
        
        return imageArr[0]
    }
}
