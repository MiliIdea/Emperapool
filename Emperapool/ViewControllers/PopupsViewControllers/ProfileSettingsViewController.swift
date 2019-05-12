//
//  ProfileSettingsViewController.swift
//  Emperapool
//
//  Created by MAC on 4/11/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import DCKit

class ProfileSettingsViewController: UIViewController  , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var popupBackView: UIView!
    @IBOutlet weak var collection: UICollectionView!
    
    var avatars : [Avatars] = [Avatars]()
    
    @IBOutlet weak var nameTxtField: DCBorderedTextField!
    @IBOutlet weak var BDTxtField: DCBorderedTextField!
    
    @IBOutlet weak var cityTxtField: DCBorderedTextField!
    
    @IBOutlet weak var jobTxtField: DCBorderedTextField!
    
    @IBOutlet weak var introduceCodeTxtField: DCBorderedTextField!
    
    var profileRes : ProfileRes?
    
    var selectedAvatar : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        
        self.popupBackView.frame.origin.y = self.view.frame.height
        
        collection.register(UINib(nibName: "AvatarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AvatarCollectionViewCell")
        
        App.showLoading(vc: self , viewAlpha : 0.2)
        MR.getMyAvatars(vc: self){res in
            App.dismissLoading(vc: self)
            if(res != nil && res!.data != nil && !res!.data!.isEmpty){
                self.avatars = res!.data!
                self.collection.reloadData()
            }
        }
        
        if(profileRes != nil){
            self.nameTxtField.text = profileRes?.display_name
            self.BDTxtField.text = profileRes?.birthday
            self.cityTxtField.text = profileRes?.city
            self.jobTxtField.text = profileRes?.job
            self.introduceCodeTxtField.text = profileRes?.introduced_by ?? ""
            self.selectedAvatar = profileRes?.avatar ?? ""
            self.collection.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
            
            self.popupBackView.frame.origin.y = 0
            
        },completion: nil)
        
    }
    

    @IBAction func accept(_ sender: Any) {
        
        if(self.nameTxtField.text == ""){
            self.view.makeToast("لطفا نام کاربری خود را تکمیل کنید")
            return
        }
        self.profileRes?.display_name = self.nameTxtField.text
        
        self.profileRes?.birthday = self.BDTxtField.text
        
        self.profileRes?.city = self.cityTxtField.text
        
        self.profileRes?.job = self.jobTxtField.text
        
        self.profileRes?.introduced_by = self.introduceCodeTxtField.text
        
        print(["display_name" : profileRes?.display_name ?? "" , "birthday" : self.profileRes?.birthday ?? "" , "city" : self.profileRes?.city ?? "" , "job" : self.profileRes?.job ?? "" , "introduced_by" : self.profileRes?.introduced_by ?? ""])
        
            MR.updateUser(vc: self, profile: ["display_name" : profileRes?.display_name ?? "" , "birthday" : self.profileRes?.birthday ?? "" , "city" : self.profileRes?.city ?? "" , "job" : self.profileRes?.job ?? "" , "introduced_by" : self.profileRes?.introduced_by ?? ""]){res in
                if(res != nil && res?.data != nil){
                    
                    App.profile = self.profileRes
                    
                    SwiftEventBus.post("profileUpdate")
                    
                    UIView.animate(withDuration: 0.2, delay: 0 , options: .curveEaseInOut, animations: {
                        
                        self.view.backgroundColor = UIColor.clear
                        
                        self.popupBackView.frame.origin.y = self.view.frame.height
                        
                    }){completion in
                        self.view.removeFromSuperview()
                        self.removeFromParent()
                    }
                }
            }
//        }catch{
//            print(error)
//        }
    }
    
    @IBAction func deny(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.clear
            
            self.popupBackView.frame.origin.y = self.view.frame.height
            
        }){completion in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
        
    }
    
    
    @IBAction func goBD(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
        let vc : ProfileDatePickerViewController = (storyboard.instantiateViewController(withIdentifier: "ProfileDatePickerViewController")) as! ProfileDatePickerViewController
        self.addChild(vc)
        vc.didMove(toParent: self)
        self.view.addSubview(vc.view)
    }
    
    @IBAction func goCity(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
        let vc : ProfileListSelectorViewController = (storyboard.instantiateViewController(withIdentifier: "ProfileListSelectorViewController")) as! ProfileListSelectorViewController
        vc.isCity = true
        vc.selectedItem = self.cityTxtField.text ?? ""
        self.addChild(vc)
        vc.didMove(toParent: self)
        self.view.addSubview(vc.view)
    }
    
    @IBAction func goJob(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
        let vc : ProfileListSelectorViewController = (storyboard.instantiateViewController(withIdentifier: "ProfileListSelectorViewController")) as! ProfileListSelectorViewController
        vc.isCity = false
        vc.selectedItem = self.jobTxtField.text ?? ""
        self.addChild(vc)
        vc.didMove(toParent: self)
        self.view.addSubview(vc.view)
    }
    
    
    @IBAction func moreAvatars(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.clear
            
            self.popupBackView.frame.origin.y = self.view.frame.height
            
        }){completion in
            (self.parent as! MainViewController).goTab(3)
            ((self.parent as! MainViewController).children[2] as! StoreViewController).goTab(2)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : AvatarCollectionViewCell = collection.dequeueReusableCell(withReuseIdentifier: "AvatarCollectionViewCell", for: indexPath as IndexPath) as! AvatarCollectionViewCell
        let c = avatars[indexPath.item]
        
        cell.icon.kf.setImage(with: URL.init(string: c.image ?? ""))
        
        cell.priceLabel.alpha = 0
        
        cell.coinBackView.alpha = 0
        
        cell.backView.backgroundColor = UIColor(c.color ?? "#FFFFFF")
        
        if(c.image == self.selectedAvatar){
            //on kardane tik
            cell.checkBox.alpha = 1
        }else{
            cell.checkBox.alpha = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedAvatar = avatars[indexPath.item].image ?? ""
        self.collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collection.frame.size.width - space) / 3.0
        return CGSize(width: size, height: size)
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
