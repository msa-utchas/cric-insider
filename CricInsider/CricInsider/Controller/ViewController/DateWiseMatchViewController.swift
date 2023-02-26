//
//  DateWiseMatchViewController.swift
//  CricInsider
//
//  Created by BJIT on 22/2/23.
//

import UIKit
import Combine

class DateWiseMatchViewController: UIViewController {
    @IBOutlet weak var textBackView: UIView!
    
    @IBOutlet weak var activityContainerView: UIView!
    
    @IBOutlet weak var leagueWiseMatchesBackView: UIView!
    @IBOutlet weak var backView: UIView!
    let viewModel = DateWiseMatchViewModel()
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var leagueWiseBackView: UIView!
    @IBOutlet weak var tableViewMatchList: UITableView!
    var cancelable: Set<AnyCancellable> = []
    var matchData: [MatchInfoModel] = []
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        self.navigationItem.title = "Cric Insider"
        view.isUserInteractionEnabled = false
        leagueWiseBackView.addShadow()
        textBackView.layer.cornerRadius = 4
        textBackView.addShadow()
        backView.addShadow()
        tableViewMatchList.dataSource = self
        tableViewMatchList.delegate = self
        let nib = UINib(nibName: MatchesTableViewCell.identifier, bundle: nil)
        tableViewMatchList.register(nib, forCellReuseIdentifier: MatchesTableViewCell.identifier)
        Task {
            await viewModel.getDateWiseMatches(date: datePicker.date)
            view.isUserInteractionEnabled = true
            
            //activityContainerView.isHidden = true
            
        }
        binder()
        
    }
    
    @IBAction func showLeagueWiseMatches(_ sender: Any) {
        let viewController =  self.storyboard?.instantiateViewController(identifier: "LeagueWiseMatchesViewController") as! LeagueWiseMatchesViewController
        viewController.loadViewIfNeeded()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func searchMatchAction(_ sender: Any) {
        Task {
            
            await viewModel.getDateWiseMatches(date: datePicker.date)
            view.isUserInteractionEnabled = true
            
        }
    }
    func binder(){
        viewModel.$matchData.sink { [weak self] data in
            guard let self = self else {return}
            
            if let data = data{
                self.matchData = data
                DispatchQueue.main.async {
                    self.tableViewMatchList.reloadData()
                }
            }
            
            
            
            
        }.store(in: &cancelable)
        
        viewModel.$selectedMatch.sink(){[weak self] data in
            guard let self = self else {return}
            if let data = data{
                let storyBoard = UIStoryboard(name: "Home", bundle: nil)
                let viewController = storyBoard.instantiateViewController(identifier: "MatchDetailsViewController") as! MatchDetailsViewController
                viewController.loadViewIfNeeded()
                viewController.matchDetailsViewModel.matchID = data.fixtureId
                Task{
                    await viewController.matchDetailsViewModel.setMatchDetails(id: data.fixtureId ?? 47099)
                }
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
        }.store(in: &cancelable)
    }
    
    
}
extension DateWiseMatchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMatchList.dequeueReusableCell(withIdentifier: MatchesTableViewCell.identifier, for: indexPath) as! MatchesTableViewCell
        let data = matchData[indexPath.row]
        cell.labelDate.text = (data.date ?? "") + " " + (data.time ?? "")
        cell.labelVisitorTeamName.text = data.visitorTeamName
        cell.labelMatchType.text = data.matchType
        cell.labelStatus.text = data.status
        if data.status == "NS"{
            cell.labelStatus.text = "Upcoming"
        }
        cell.labelVisitorTeamFlag.sd_setImage(with: URL(string: data.visitorTeamImagePath ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
        cell.labelLocalTeamName.text = data.localTeamName
        cell.labelNote.text = data.note
        
        cell.labelLocalTeamFlag.sd_setImage(with: URL(string: data.localTeamImagePath ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
        cell.labelLeagueNameWithSeason.text = (data.leagueName ?? "") + "," + (data.seasonName ?? "")
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setSelectedMatch(matchInfo: matchData[indexPath.row])
    }
    
    
}
