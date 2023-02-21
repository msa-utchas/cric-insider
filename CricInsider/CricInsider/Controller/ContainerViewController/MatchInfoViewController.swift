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
