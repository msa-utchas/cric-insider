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

    @IBOutlet weak var tableViewLineup: UITableView!
    var squadInfoViewModel = MatchDetailsViewModel.shared
    var localTeamSquad: [Player] = []
    var visitorTeamSquad: [Player] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewLineup.dataSource = self
        tableViewLineup.delegate = self
        binder()
       
    }
    

    func binder(){
        squadInfoViewModel.$matchDetails.sink {[weak self] (matchDetails) in
            guard let self = self else {return}
            self.localTeamSquad = matchDetails?.localTeamSquad ?? []
            self.visitorTeamSquad = matchDetails?.VisitorTeamSquad ?? []
            DispatchQueue.main.async {
                self.tableViewLineup.reloadData()
            }
            
            
        }.store(in: &cancelable)
    }

}

extension SquadsViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "local Team"
        }
        else{
            return "visitorteam" 
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return localTeamSquad.count
        }else{
            return visitorTeamSquad.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewLineup.dequeueReusableCell(withIdentifier: SquadListTableViewCell.identifier, for: indexPath) as! SquadListTableViewCell
        if indexPath.section == 0{
            cell.labelName.text = localTeamSquad[indexPath.row].fullname
        }
        else
        {
            cell.labelName.text = visitorTeamSquad[indexPath.row].fullname
        }
        return cell
    }
    
    
}
