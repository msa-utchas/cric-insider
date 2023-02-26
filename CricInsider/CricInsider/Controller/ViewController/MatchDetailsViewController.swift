//
//  MatchDetailsViewController.swift
//  CricInsider
//
//  Created by BJIT on 17/2/23.
//

import UIKit
import Combine

class MatchDetailsViewController: UIViewController {
    
    @IBOutlet weak var squadListContainerView: UIView!
    @IBOutlet weak var matchInfoContainerView: UIView!
    @IBOutlet weak var matchDetailsBackgroundView: UIView!
    
    @IBOutlet weak var matchInfoSegmentControl: UISegmentedControl!
    @IBOutlet weak var scoreCardContainerView: UIView!
    
    var selectedFixtureId: Int!
    var matchStatus:String!
    
    var matchDetailsViewModel = MatchDetailsViewModel.shared
    var cancelable: Set<AnyCancellable> = []
    var timer = Timer()
    var timerStatus: Bool = false
    override func viewDidLoad() {

        super.viewDidLoad()

        matchDetailsBackgroundView.layer.cornerRadius = 20
        matchInfoContainerView.isHidden = false
        squadListContainerView.isHidden = true
        scoreCardContainerView.isHidden = true
        self.navigationItem.title = "Cric Insider"
    
        binder()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.title = "Cric Insider"
    }

    func binder(){
        matchDetailsViewModel.$matchDetails.sink { (id) in
           
            
        }.store(in: &cancelable)
    }

    @IBAction func detailsViewAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            matchInfoContainerView.isHidden = false
            squadListContainerView.isHidden = true
            scoreCardContainerView.isHidden = true
        case 1:
            matchInfoContainerView.isHidden = true
            squadListContainerView.isHidden = true
            scoreCardContainerView.isHidden = false
        case 2:
            squadListContainerView.isHidden = false
            matchInfoContainerView.isHidden = true
            scoreCardContainerView.isHidden = true
        default:
            print("default")
        }
        
    }
}

extension MatchDetailsViewController{

}
