//
//  ProfileViewController.swift
//  Emperapool
//
//  Created by MAC on 4/11/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import DCKit
import Kingfisher

class ProfileViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var birthdate: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var gem: UILabel!
    @IBOutlet weak var coin: UILabel!
    @IBOutlet weak var badgeView: DCBorderedView!
    @IBOutlet weak var collection: UICollectionView!
    
    var badges : [Badges] = [Badges]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.register(UINib(nibName: "BadgeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BadgeCollectionViewCell")
        
        SwiftEventBus.onMainThread(self, name: "profileUpdate") { result in
            
            
        }
        App.showLoading(vc: self)
        MR.getProfile(vc: self){res in
            App.dismissLoading(vc: self)
            if(res != nil && res?.data != nil && !(res?.data!.isEmpty)!){
                App.profile = res?.data?.first!
                self.updateProfileView()
            }
        }
        
        MR.getMyBadge(vc: self){res in
            if(res != nil && res?.data != nil && !(res?.data!.isEmpty)!){
                self.badges = (res?.data!)!
                self.collection.reloadData()
                let h = self.collection.collectionViewLayout.collectionViewContentSize.height
                self.collection.frame.size.height = h
                self.badgeView.setHeight(height: self.collection.y + h + 15)
                self.myScrollView.contentSize.height = self.badgeView.height + self.badgeView.y + (30 * self.view.frame.height / 603)

            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    func updateProfileView(){
        if(App.profile?.avatar != nil && App.profile?.avatar != ""){
            self.profileImage.kf.setImage(with: URL.init(string: (App.profile?.avatar!)!), for: .normal)
        }
        self.profileImage.imageView?.contentMode = .scaleAspectFit
        self.name.text = App.profile?.display_name ?? ""
        self.city.text = App.profile?.city ?? ""
        self.birthdate.text = App.profile?.birthday ?? ""
        self.job.text = App.profile?.job ?? ""
        self.level.text = "سطح " + (App.profile?.level ?? 1).description
        self.coin.text = (App.profile?.coin ?? 0).description
        self.gem.text = (App.profile?.gem ?? 0).description
    }
    

    @IBAction func moreBadge(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : BadgeCollectionViewCell = collection.dequeueReusableCell(withReuseIdentifier: "BadgeCollectionViewCell", for: indexPath as IndexPath) as! BadgeCollectionViewCell
        let c = badges[indexPath.item]
        
        cell.icon.kf.setImage(with: URL(string: c.image ?? ""))
        
        cell.badgeTitle.text = c.title ?? ""
        
        cell.back.backgroundColor = UIColor(c.color ?? "#FFFFFF")
        
        cell.backCoin.alpha = 0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collection.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size * 205 / 160)
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
