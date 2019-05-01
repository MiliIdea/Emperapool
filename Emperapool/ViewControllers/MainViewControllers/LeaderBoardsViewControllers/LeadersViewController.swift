//
//  LeadersViewController.swift
//  Emperapool
//
//  Created by MAC on 4/20/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit
import Kingfisher

class LeadersViewController : UIViewController ,UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var navigationHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationTopSafeArea: NSLayoutConstraint!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var firstGem: UILabel!
    
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var secondName: UILabel!
    @IBOutlet weak var secondGem: UILabel!
    
    @IBOutlet weak var theardImage: UIImageView!
    @IBOutlet weak var theardName: UILabel!
    @IBOutlet weak var theardGem: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var backImage: UIImageView!
    var type : LeaderBoardType = .overall
    
    var overallLeaderBoards : [LeaderboardRes<Int>] = [LeaderboardRes<Int>]()
    
    var leaderBoards : [LeaderboardRes<String>] = [LeaderboardRes<String>]()
    
    var gameId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.register(UINib(nibName: "LeaderboardTableViewCell", bundle: nil), forCellReuseIdentifier:"LeaderboardTableViewCell")
        
        self.table.estimatedRowHeight = 57 * self.parent!.view.frame.height / 667
        
        self.table.rowHeight = 57 * self.parent!.view.frame.height / 667
        
        App.showLoading(vc: self)

        switch self.type {
        case .Month :
            self.navigationHeight.constant = 30
            self.navigationView.alpha = 0
            self.navigationTopSafeArea.constant = 25
            
            self.firstName.text = "fiiirst"
            MR.getMonthLeaderboard(vc: self){res in
                App.dismissLoading(vc: self)
                if(res != nil && res?.data != nil && !(res?.data!.isEmpty)!){
                    self.leaderBoards = (res?.data!)!
                    self.setupView()
                }
            }
            break
        case .Game :
            self.navigationHeight.constant = 70 * self.view.frame.height / 552
            self.closeButton.alpha = 1
            self.backImage.alpha = 1
            MR.getGameLeaderboard(vc: self, gameId: gameId ?? "31"){res in
                App.dismissLoading(vc: self)
                if(res != nil && res?.data != nil && !(res?.data!.isEmpty)!){
                    self.leaderBoards = (res?.data!)!
                    self.setupView()
                }
            }
            break
        case .overall :
            self.navigationHeight.constant = 30
            self.navigationView.alpha = 0
            self.navigationTopSafeArea.constant = 25
            
            self.firstName.text = "sescoonnd"
            MR.getOverallLeaderboard(vc: self){res in
                App.dismissLoading(vc: self)
                if(res != nil && res?.data != nil && !(res?.data!.isEmpty)!){
                    self.overallLeaderBoards = (res?.data!)!
                    self.setupView()
                }
            }
            break
        }
            
        
        // Do any additional setup after loading the view.
    }
    
    func setupView(){

        switch self.type {
        case .overall:
            self.firstName.text = self.overallLeaderBoards.first?.display_name
            self.firstGem.text = self.overallLeaderBoards.first?.point?.description
            if let avat = self.overallLeaderBoards.first?.avatar {
                self.firstImage.kf.setImage(with: URL.init(string: avat))
            }
            self.overallLeaderBoards.removeFirst()
            
            self.secondName.text = self.overallLeaderBoards.first?.display_name
            self.secondGem.text = self.overallLeaderBoards.first?.point?.description
            if let avat = self.overallLeaderBoards.first?.avatar {
                self.secondImage.kf.setImage(with: URL.init(string: avat))
            }
            self.overallLeaderBoards.removeFirst()
            
            self.theardName.text = self.overallLeaderBoards.first?.display_name
            self.theardGem.text = self.overallLeaderBoards.first?.point?.description
            if let avat = self.overallLeaderBoards.first?.avatar {
                self.theardImage.kf.setImage(with: URL.init(string: avat))
            }
            self.overallLeaderBoards.removeFirst()
            
            self.table.setHeight(height: self.table.rowHeight * CGFloat(self.overallLeaderBoards.count))
            self.tableHeight.constant = self.table.rowHeight * CGFloat(self.overallLeaderBoards.count)
            
        default:
            
            self.firstName.text = self.leaderBoards.first?.display_name
            self.firstGem.text = self.leaderBoards.first?.point?.description
            if let avat = self.leaderBoards.first?.avatar {
                self.firstImage.kf.setImage(with: URL.init(string: avat))
            }
            self.leaderBoards.removeFirst()
            
            self.secondName.text = self.leaderBoards.first?.display_name
            self.secondGem.text = self.leaderBoards.first?.point?.description
            if let avat = self.leaderBoards.first?.avatar {
                self.secondImage.kf.setImage(with: URL.init(string: avat))
            }
            self.leaderBoards.removeFirst()
            
            self.theardName.text = self.leaderBoards.first?.display_name
            self.theardGem.text = self.leaderBoards.first?.point?.description
            if let avat = self.leaderBoards.first?.avatar {
                self.theardImage.kf.setImage(with: URL.init(string: avat))
            }
            self.leaderBoards.removeFirst()
            self.table.setHeight(height: self.table.rowHeight * CGFloat(self.leaderBoards.count))
            self.tableHeight.constant = self.table.rowHeight * CGFloat(self.leaderBoards.count)
        }
        self.table.reloadData()
        self.myScrollView.contentSize.height = self.table.height + self.table.y + (80 * self.parent!.view.frame.height / 667)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.type {
            case .overall:
                return self.overallLeaderBoards.count
            default:
                return self.leaderBoards.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LeaderboardTableViewCell = table.dequeueReusableCell(withIdentifier: "LeaderboardTableViewCell", for: indexPath as IndexPath) as! LeaderboardTableViewCell
        
        switch self.type {
        case .overall:
            let o = self.overallLeaderBoards[indexPath.row]
            if let avat = o.avatar {
                cell.icon.kf.setImage(with: URL.init(string: avat))
            }
            cell.gemAmount.text = o.point?.description
            cell.name.text = o.display_name
            cell.rank.text = (indexPath.row + 4).description
        default:
            let c = self.leaderBoards[indexPath.row]
            if let avat = c.avatar {
                cell.icon.kf.setImage(with: URL.init(string: avat))
            }
            cell.gemAmount.text = c.point?.description
            cell.name.text = c.display_name
            cell.rank.text = (indexPath.row + 4).description
        }
        
        return cell
    }
    
    

    @IBAction func close(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
    
    
    

}
