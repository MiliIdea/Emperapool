//
//  AvatarStoreViewController.swift
//  Emperapool
//
//  Created by MAC on 4/17/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import Kingfisher
import UIColor_Hex_Swift

class AvatarStoreViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var avatars : [Avatars] = [Avatars]()
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var on: UIImageView!
    @IBOutlet weak var off: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.avatars = (self.parent! as! StoreViewController).shopListResponse?.avatars ?? [Avatars]()
        
        collection.register(UINib(nibName: "AvatarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AvatarCollectionViewCell")
        
        Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(runOnAndOff), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    @objc func runOnAndOff(){
        if(self.on.alpha == 1){
            UIView.animate(withDuration: 0.8 , delay: 0 , options: .curveEaseInOut, animations: {
                self.on.alpha = 0
                self.off.alpha = 1
            },completion: nil)
        }else{
            UIView.animate(withDuration: 1 , delay: 0 , options: .curveEaseInOut, animations: {
                self.on.alpha = 1
                self.off.alpha = 0
            },completion: nil)
        }
    }

    override func viewDidLayoutSubviews() {
        let h = self.collection.collectionViewLayout.collectionViewContentSize.height
        self.collection.frame.size.height = h
        self.myScrollView.contentSize.height = h + self.collection.y + 20
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : AvatarCollectionViewCell = collection.dequeueReusableCell(withReuseIdentifier: "AvatarCollectionViewCell", for: indexPath as IndexPath) as! AvatarCollectionViewCell
        let c = avatars[indexPath.item]
        
        cell.icon.kf.setImage(with: URL.init(string: c.icon ?? ""))
        
        cell.priceLabel.text = c.price ?? "0"
        
        cell.backView.backgroundColor = UIColor(c.color ?? "#FFFFFF")
        
        return cell
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
