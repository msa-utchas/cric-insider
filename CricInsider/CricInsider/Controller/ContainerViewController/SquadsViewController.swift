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
    var localTeamName : String?
    var visitorTeamName: String?

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
            self.localTeamName = matchDetails?.localTeamName
            self.visitorTeamName = matchDetails?.visitorTeamName
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
            return localTeamName
        }
        else{
            return visitorTeamName
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
            cell.imageViewPlayer.sd_setImage(with: URL(string: localTeamSquad[indexPath.row].image_path ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
            cell.labelPlayerType.text = localTeamSquad[indexPath.row].position?.name ?? "N\\A"


        }
        else
        {
            cell.labelName.text = visitorTeamSquad[indexPath.row].fullname
            cell.imageViewPlayer.sd_setImage(with: URL(string: visitorTeamSquad[indexPath.row].image_path ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        //headerView.addShadow()
        
        let titleLabel = UILabel()
        //set team name
        if section == 0{
            titleLabel.text = localTeamName
            //set background color
        }
        else{
            titleLabel.text = visitorTeamName
        }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)


        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true




        
        return headerView
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    
}
