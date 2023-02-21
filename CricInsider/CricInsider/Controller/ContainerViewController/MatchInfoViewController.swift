//
//  MatchInfoViewController.swift
//  CricInsider
//
//  Created by BJIT on 17/2/23.
//

import UIKit
import Combine

class MatchInfoViewController: UIViewController {
    private var cancelable: Set<AnyCancellable> = []
    let matchInfoViewModel = MatchDetailsViewModel.shared

    @IBOutlet weak var teamBImageView: UIImageView!
    @IBOutlet weak var labelLeagueInfo: UILabel!
    @IBOutlet weak var labelTeamBScore: UILabel!
    @IBOutlet weak var labelTeamAScore: UILabel!
    @IBOutlet weak var teamAImageView: UIImageView!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelTeamAName: UILabel!
    @IBOutlet weak var labelTeamBName: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binder()
        // Do any additional setup after loading the view.
    }
    

    func binder(){
        matchInfoViewModel.$matchDetails.sink { (id) in
            if let id = id {
                
            }
            
        }.store(in: &cancelable)
    }

}
