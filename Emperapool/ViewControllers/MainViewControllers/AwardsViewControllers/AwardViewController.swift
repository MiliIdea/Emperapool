//
//  AwardViewController.swift
//  Emperapool
//
//  Created by MAC on 4/14/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class AwardViewController: UIViewController  ,UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var table: UITableView!
    
    var prizeList : [PrizeRes] = [PrizeRes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.table.register(UINib(nibName: "prizeTableViewCell", bundle: nil), forCellReuseIdentifier:"prizeTableViewCell")
        
        self.table.estimatedRowHeight = 170 * self.parent!.view.frame.height / 667
        
        self.table.rowHeight = 170 * self.parent!.view.frame.height / 667
        
        self.table.delegate = self
        
        self.table.dataSource = self
        
        
        
        App.showLoading(vc: self)
        MR.getPrizeList(vc: self){res in
            App.dismissLoading(vc: self)
            if(res?.data != nil && !(res?.data!.isEmpty)!){
                self.prizeList = (res?.data)!
                self.table.reloadData()
                self.table.setHeight(height: self.table.rowHeight * CGFloat(self.prizeList.count))
                self.myScrollView.contentSize.height = self.table.height + self.table.y + (80 * self.parent!.view.frame.height / 667)
            }
        }
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prizeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : prizeTableViewCell = table.dequeueReusableCell(withIdentifier: "prizeTableViewCell", for: indexPath as IndexPath) as! prizeTableViewCell
        let c = self.prizeList[indexPath.row]
     
        cell.prizeIcon.kf.setImage(with: URL(string: c.icon ?? ""))
        
        cell.prizeTitle.text = c.title ?? ""
        
        cell.gemCost.text = (c.gem ?? 1000).description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        App.showLoading(vc: self.parent!.parent! , viewAlpha: 0.3)
        let c = self.prizeList[indexPath.row]
        MR.getAvailableToBuyPrize(vc: self, productId: c.id ?? 0){res,status  in
            App.dismissLoading(vc: self.parent!.parent!)
            if(res?.extra_data?.user != nil){
                App.profile = res?.extra_data?.user
                SwiftEventBus.post("profileUpdate")
            }
            if(status == 200 || status == 201){
                if(res != nil){
                    if(res?.data?.available_to_request == true && res?.data?.ready_to_request == true){
                        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
                        let vc : VerificationToBuyViewController = (storyboard.instantiateViewController(withIdentifier: "VerificationToBuyViewController")) as! VerificationToBuyViewController
                        vc.refId = res?.data?.ref_code ?? ""
                        vc.setup(coinAmount: c.gem?.description ?? "" , imgAddress: c.image ?? c.icon ?? "", popupTitle: "آیا از خرید این محصول مطمئن اید ؟!", productId: c.id ?? 0 , bId: res?.data?.pid ?? 0 , isCoinType: false)
                        self.parent!.addChild(vc)
                        vc.didMove(toParent: self.parent!)
                        self.parent!.view.addSubview(vc.view)
                    }else{
                        self.parent!.view.makeToast("این محصول آماده ی خرید نمی باشد")
                    }
                }
            }else{
                self.parent!.view.makeToast("این محصول آماده ی خرید نمی باشد")
            }
        }
    }

}
