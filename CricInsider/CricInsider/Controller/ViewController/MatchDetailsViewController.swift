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
    var matchDetailsViewModel = MatchDetailsViewModel.shared
    var cancelable: Set<AnyCancellable> = []
    override func viewDidLoad() {

        super.viewDidLoad()
        //matchInfoSegmentControl.setEnabled(false, forSegmentAt: 1)
        //matchInfoSegmentControl.removeSegment(at: 1, animated: true)
        //self.navigationController?.isNavigationBarHidden = false
        matchDetailsBackgroundView.layer.cornerRadius = 20
        matchInfoContainerView.isHidden = false
        squadListContainerView.isHidden = true
        scoreCardContainerView.isHidden = true
       self.navigationItem.title = "Cric Insider"
        //chage the title text color to custom1
        //self.navigationItem.titleView?.tintColor = UIColor(named: "custom1")
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
