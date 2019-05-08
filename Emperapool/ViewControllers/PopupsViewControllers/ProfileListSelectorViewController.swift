//
//  ProfileListSelectorViewController.swift
//  Emperapool
//
//  Created by MAC on 5/7/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class ProfileListSelectorViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var collection: UICollectionView!
    
    var list : [String] = [String]()
    
    var isCity : Bool = true
    
    var selectedItem : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collection.register(UINib(nibName: "ProfileListSelectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileListSelectCollectionViewCell")
        // Do any additional setup after loading the view.
        
        App.showLoading(vc: self)
        MR.getStatesList(vc: self){res in
            App.dismissLoading(vc: self)
            if(res != nil && res?.data != nil){
                if(self.isCity){
                    self.list = res?.data?.cities ?? [String]()
                }else{
                    self.list = res?.data?.jobs ?? [String]()
                }
                self.collection.reloadData()
            }
        }
        
    }
    

    @IBAction func choose(_ sender: Any) {
        if(isCity){
            (self.parent as! ProfileSettingsViewController).cityTxtField.text = self.selectedItem
        }else{
            (self.parent as! ProfileSettingsViewController).jobTxtField.text = self.selectedItem
        }
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ProfileListSelectCollectionViewCell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileListSelectCollectionViewCell", for: indexPath as IndexPath) as! ProfileListSelectCollectionViewCell
        let c = list[indexPath.item]
        if(c == selectedItem){
            cell.checkBox.on = true
        }else{
            cell.checkBox.on = false
        }
        cell.txt.text = c
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedItem = self.list[indexPath.item]
        self.collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collection.frame.size.width - space) / 2.0
        return CGSize(width: size, height: 30)
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
