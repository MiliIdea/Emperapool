//
//  LoserPopupViewController.swift
//  Emperapool
//
//  Created by MAC on 5/5/19.
//  Copyright © 2019 Mili. All rights reserved.
//

import UIKit

class LoserPopupViewController: UIViewController {

    
    @IBOutlet weak var correctQuestion: UILabel!
    @IBOutlet weak var coin: UILabel!
    @IBOutlet weak var gem: UILabel!
    @IBOutlet weak var badge: UILabel!
    
    var scoreCalculator : ScoreCalculatorInQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.correctQuestion.text = (scoreCalculator!.questionNumber - 1).description
        
        coin.text = scoreCalculator?.questionScores.coin.description
        
        gem.text = scoreCalculator?.questionScores.gem.description
        
        badge.text = "0"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ok(_ sender: Any) {
        self.parent?.navigationController?.popViewController(animated: true)
    }
    
    

}
