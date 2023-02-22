//
//  SquadsViewController.swift
//  CricInsider
//
//  Created by BJIT on 17/2/23.
//

import UIKit
import Combine

class SquadsViewController: UIViewController {
    private var cancelable: Set<AnyCancellable> = []
    
    var squadData: [Player] = []
    var teamName: String = ""
    var localTeamCode: String = ""
    var visitorTeamCode :String = ""
    @IBOutlet weak var squadSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableViewLineup: UITableView!
    var squadInfoViewModel = MatchDetailsViewModel.shared
    var localTeamSquad: [Player] = []
    var visitorTeamSquad: [Player] = []
    var localTeamName: String?
    var visitorTeamName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewLineup.dataSource = self
        tableViewLineup.delegate = self
        
        binder()
        
    }
    
    @IBAction func segmentControlChangeTeamAction(_ sender: Any) {
        if squadSegmentControl.selectedSegmentIndex == 0 {
            squadData = localTeamSquad
            teamName = localTeamName ?? ""
        } else {
            squadData = visitorTeamSquad
            teamName = visitorTeamName ?? ""
        }
        tableViewLineup.reloadData()
    }
    
    
    func binder() {
        squadInfoViewModel.$matchDetails.sink { [weak self] (matchDetails) in
            guard let self = self else {
                return
            }
            self.localTeamSquad = matchDetails?.localTeamSquad ?? []
            self.visitorTeamSquad = matchDetails?.VisitorTeamSquad ?? []
            self.localTeamName = matchDetails?.localTeamName
            self.visitorTeamName = matchDetails?.visitorTeamName
            self.squadData = matchDetails?.localTeamSquad ?? []
            self.teamName = matchDetails?.localTeamName ?? ""
            //set segment control button title
            self.localTeamCode = matchDetails?.localTeamCodeName ?? ""
            self.visitorTeamCode = matchDetails?.visitorTeamCodeName ?? ""
            
            DispatchQueue.main.async { [self] in
                self.squadSegmentControl.setTitle(self.localTeamCode, forSegmentAt: 0)
                self.squadSegmentControl.setTitle(self.visitorTeamCode, forSegmentAt: 1)
                self.tableViewLineup.reloadData()
            }
            
            
        }
        .store(in: &cancelable)
    }

    
}

extension SquadsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return teamName
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return squadData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewLineup.dequeueReusableCell(withIdentifier: SquadListTableViewCell.identifier, for: indexPath) as! SquadListTableViewCell
        if indexPath.section == 0 {
            cell.labelName.text = squadData[indexPath.row].fullname
            cell.imageViewPlayer.sd_setImage(with: URL(string: squadData[indexPath.row].image_path ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
            cell.labelPlayerType.text = squadData[indexPath.row].position?.name ?? "N\\A"
            
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    
}
