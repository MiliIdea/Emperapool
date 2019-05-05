//
//  HomeViewController.swift
//  Emperapool
//
//  Created by MAC on 4/14/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import Kingfisher
import UIColor_Hex_Swift

class HomeViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var gemLabel: UILabel!
    
    
    var gameList : [GameListRes] = [GameListRes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.table.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier:"HomeTableViewCell")
        
        self.table.estimatedRowHeight = 118 * self.parent!.view.frame.height / 667
        
        self.table.rowHeight = 118 * self.parent!.view.frame.height / 667
        
        self.table.delegate = self
        
        self.table.dataSource = self

        self.coinLabel.text = App.profile?.coin?.description
        
        self.gemLabel.text = App.profile?.gem?.description
        
        App.showLoading(vc: self)
        MR.getGameList(vc: self){res in
            App.dismissLoading(vc: self)
            if(res?.data != nil && !(res?.data!.isEmpty)!){
                self.gameList = (res?.data)!
                self.table.reloadData()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HomeTableViewCell = table.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath as IndexPath) as! HomeTableViewCell
        let c = self.gameList[indexPath.row]
        cell.cellsIcon.kf.setImage(with: URL(string: c.icon ?? ""))
        cell.backOfCell.backgroundColor = UIColor(c.color ?? "#888888")
        cell.titleLabel.text = c.title
        if(c.entry_fee_gem ?? 0 == 0 && c.entry_fee_coin ?? 0 == 0){
            cell.gemRequiredback.alpha = 0
            cell.coinRequiredBack.alpha = 0
            cell.freeFeeBack.alpha = 1
            cell.freeFeeLabel.textColor = UIColor("#588646")
            cell.requiredBox.topColor = UIColor("#8BD760")
            cell.requiredBox.bottomColor = UIColor("#588646")
        }else{
            cell.freeFeeBack.alpha = 0
            if(c.entry_fee_coin ?? 0 == 0 && c.entry_fee_gem ?? 0 != 0){
                cell.gemRequiredback.setCenterX(x: cell.requiredBox.frame.width / 2)
                cell.gemRequiredLabel.text = c.entry_fee_gem!.description
                cell.coinRequiredBack.alpha = 0
            }else if(c.entry_fee_gem ?? 0 == 0 && c.entry_fee_coin ?? 0 != 0){
                cell.coinRequiredBack.setCenterX(x: cell.requiredBox.frame.width / 2)
                cell.coinRequiredLabel.text = c.entry_fee_coin!.description
                cell.gemRequiredback.alpha = 0
            }else{
                cell.gemRequiredLabel.text = c.entry_fee_gem!.description
                cell.coinRequiredLabel.text = c.entry_fee_coin!.description
            }
        }
        
        if(c.rules?.prize != nil && !(c.rules?.prize!.isEmpty)!){
            let prize : Prize = (c.rules?.prize!.last!)!
            if(prize.type ?? "once" == "once"){
                cell.prizeConditionLabel.text =  prize.period!.description + " پاسخ درست"
            }else{
                cell.prizeConditionLabel.text = "هر " + prize.period!.description + " پاسخ درست"
            }
            cell.coinAwardLabel.text = prize.coin?.description
            cell.gemAwardLabel.text = prize.gem?.description
            if(prize.coin == 0 && prize.gem != 0){
                cell.coinAwardView.alpha = 0
                cell.gemAwardView.alpha = 1
                cell.gemAwardView.setCenterX(x: cell.awardBack.frame.width / 2)
            }else if(prize.gem == 0 && prize.coin != 0){
                cell.coinAwardView.alpha = 1
                cell.gemAwardView.alpha = 0
                cell.coinAwardView.setCenterX(x: cell.awardBack.frame.width / 2)
            }else{
                
            }
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        
        let vc : PreGameViewController = (storyboard.instantiateViewController(withIdentifier: "PreGameViewController")) as! PreGameViewController
        
        vc.gameRules = self.gameList[indexPath.row]
        
        self.parent!.addChild(vc)
        
        vc.didMove(toParent: self.parent!)
        
        self.parent!.view.addSubview(vc.view)
        
    }
    
    

}
