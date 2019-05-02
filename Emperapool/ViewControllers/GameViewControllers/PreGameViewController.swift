//
//  PreGameViewController.swift
//  Emperapool
//
//  Created by MAC on 4/15/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class PreGameViewController: UIViewController  ,UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var table: UITableView!
    
    var gameRules : GameListRes?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popupView.frame.origin.y = self.view.frame.height
        
        self.table.register(UINib(nibName: "PreGameTableViewCell", bundle: nil), forCellReuseIdentifier:"PreGameTableViewCell")
        
        self.table.estimatedRowHeight = 30 
        
        self.table.rowHeight = 30
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.3, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
            
            self.popupView.frame.origin.y = 0
            
        },completion: nil)
        
    }
    
    
    @IBAction func startGame(_ sender: Any) {
        self.parent!.navigate(storyboardName: "Game", vc: GameBoardViewController.self){vc in
            vc.gameRules = self.gameRules
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
        
    }
    
    @IBAction func decline(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0 , options: .curveEaseInOut, animations: {
            
            self.popupView.frame.origin.y = self.view.frame.height
            
        }){completion in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    @IBAction func goLeaderboards(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc : LeadersViewController = (storyboard.instantiateViewController(withIdentifier: "LeadersViewController")) as! LeadersViewController
        
        vc.type = .Game
        
        vc.gameId = self.gameRules?.id?.description
        
        self.parent!.parent!.addChild(vc)
        
        vc.didMove(toParent: self.parent!.parent!)
        
        vc.view.frame = self.parent!.parent!.view.frame
        
        self.parent!.parent!.view.addSubview(vc.view)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.gameRules?.rules?.prize?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PreGameTableViewCell = table.dequeueReusableCell(withIdentifier: "PreGameTableViewCell", for: indexPath as IndexPath) as! PreGameTableViewCell
       
        let c = self.gameRules?.rules?.prize![indexPath.row]
        
        if(c?.type == "once"){
            cell.prizeLabel.text = "به ازای " + (c?.period?.description ?? "0") + " پاسخ درست"
            
        }else{
            
            cell.prizeLabel.text = "به ازای هر " + (c?.period?.description ?? "0") + " پاسخ درست"
        }
        
        if(c?.coin == 0){
            cell.coinBox.setWidth(width: 0)
        }else{
            cell.coinLabel.text = "X " + (c?.coin?.description ?? "0")
        }
        if(c?.gem == 0){
            cell.gemBox.setWidth(width: 0)
        }else{
            cell.gemLabel.text = "X " + (c?.gem?.description ?? "0")
        }
        
        cell.badgeBox.setWidth(width: 0)
        cell.gemBox.setX(x: cell.badgeBox.x)
        cell.coinBox.setX(x: cell.gemBox.width + cell.gemBox.x)
        
        return cell
    }
    
}
