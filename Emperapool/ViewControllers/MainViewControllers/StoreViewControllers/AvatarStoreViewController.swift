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
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        App.showLoading(vc: self.parent!.parent! , viewAlpha: 0.3)
        let c = self.avatars[indexPath.item]
        MR.getAvailableToBuy(vc: self, productId: c.id ?? 0){res,status  in
            App.dismissLoading(vc: self.parent!.parent!)
            if(res?.extra_data?.user != nil){
                App.profile = res?.extra_data?.user
                SwiftEventBus.post("profileUpdate")
            }
            if(status == 200 || status == 201){
                if(res != nil){
                    if(res?.data?.available_to_buy == true && res?.data?.ready_to_buy == true){
                        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
                        let vc : VerificationToBuyViewController = (storyboard.instantiateViewController(withIdentifier: "VerificationToBuyViewController")) as! VerificationToBuyViewController
                        vc.setup(coinAmount: c.price ?? "", imgAddress: c.image ?? c.icon ?? "", popupTitle: "آیا از خرید این آواتار مطمئن اید ؟!", productId: c.id ?? 0 , bId: res?.data?.bid ?? 0)
                        self.parent!.parent!.addChild(vc)
                        vc.didMove(toParent: self.parent!.parent!)
                        self.parent!.parent!.view.addSubview(vc.view)
                    }else{
                        self.parent!.parent!.view.makeToast("این محصول آماده ی خرید نمی باشد")
                    }
                }
            }else{
                self.parent!.parent!.view.makeToast("این محصول آماده ی خرید نمی باشد")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : AvatarCollectionViewCell = collection.dequeueReusableCell(withReuseIdentifier: "AvatarCollectionViewCell", for: indexPath as IndexPath) as! AvatarCollectionViewCell
        let c = avatars[indexPath.item]
        
        cell.icon.kf.setImage(with: URL.init(string: c.image ?? ""))
        
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
