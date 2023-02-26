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
      
    
        binder()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.title = "Match Details"
        navigationController?.navigationBar.tintColor = UIColor.tintColor
        
    }

    func binder(){
        matchDetailsViewModel.$matchDetails.sink {[weak self] (data) in
            guard self != nil else {return}
//            if let data = data{
//                if data.localTeamSquad?.count == 0{
//                    DispatchQueue.main.async {
//                        // remove segment button
//                        self.matchInfoSegmentControl.removeSegment(at: 2, animated: true)
//                    }
//
//                }else{
//                    DispatchQueue.main.async {
//                        if self.matchInfoSegmentControl.numberOfSegments == 2{
//                            self.matchInfoSegmentControl.insertSegment(withTitle: "Squad", at: 2, animated: true)
//                        }
//
//                    }
//                }
//                if (data.localTeamBowling?.count != 0) || (data.localTeamBatting.count != 0) || (data.visitorTeamBowling?.count != 0) || (data.visitorTeamBatting.count != 0) {
//                    DispatchQueue.main.async {
//                        // add segment button if not exist
//                        if self.matchInfoSegmentControl.numberOfSegments == 2{
//
//                            DispatchQueue.main.async {
//                                self.matchInfoSegmentControl.insertSegment(withTitle: "Score Card", at: 1, animated: true)
//                            }
//
//                        }
//
//
//                    }
//                }
//                else {
//                    DispatchQueue.main.async {
//
//                        self.matchInfoSegmentControl.removeSegment(at: 1, animated: true)
//                    }
//                }
//            }

           
            
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
