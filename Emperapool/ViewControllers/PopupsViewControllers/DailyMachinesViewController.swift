//
//  DailyMachinesViewController.swift
//  Emperapool
//
//  Created by MAC on 4/24/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class DailyMachinesViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var collection: UICollectionView!
    
    var dailyMachines : [DailyMachineRes] = [DailyMachineRes]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        self.popupView.alpha =  0
        
        collection.register(UINib(nibName: "MachineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MachineCollectionViewCell")
        
        App.showLoading(vc: self , viewAlpha : 0.2)
        MR.getDailyMachine(vc: self){res in
            App.dismissLoading(vc: self)
            if(res != nil && res?.data != nil && !(res?.data!.isEmpty)!){
                self.dailyMachines = (res?.data!)!
                self.collection.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: {

            self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.8)

            self.popupView.alpha = 1
//            self.popupView.frame.origin.y = 57 * self.view.height / 677

        },completion: nil)
        
    }
    
    @IBAction func itsOk(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.clear
            
            self.popupView.frame.origin.y = self.view.frame.height
            
        }){completion in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyMachines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MachineCollectionViewCell = collection.dequeueReusableCell(withReuseIdentifier: "MachineCollectionViewCell", for: indexPath as IndexPath) as! MachineCollectionViewCell
        let c = dailyMachines[indexPath.item]
        
        cell.icon.kf.setImage(with: URL.init(string: c.icon ?? ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collection.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size * 205 / 182)
    }
    
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.clear
            
            self.popupView.frame.origin.y = self.view.frame.height
            
        }){completion in
            
            let storyboard = UIStoryboard(name: "Popups", bundle: nil)
            let vc : MachineViewController = (storyboard.instantiateViewController(withIdentifier: "MachineViewController")) as! MachineViewController
            vc.dailyMachineResponse = self.dailyMachines[indexPath.item]
            self.parent!.addChild(vc)
            vc.didMove(toParent: self.parent)
            self.parent!.view.addSubview(vc.view)
            
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
        
    }
    
}
