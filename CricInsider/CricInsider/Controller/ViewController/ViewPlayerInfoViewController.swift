//
//  ViewPlayerInfoViewController.swift
//  CricInsider
//
//  Created by BJIT on 24/2/23.
//

import UIKit
import Combine

class ViewPlayerInfoViewController: UIViewController {
    @IBOutlet weak var tableViewStatistics: UITableView!
    static let identifier  = "ViewPlayerInfoViewController"
    private var cancelable: Set<AnyCancellable> = []
    var playerInfo: PlayerCareerModel?
    let viewModel =  ViewPlayerInfoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewStatistics.dataSource = self
        tableViewStatistics.delegate = self
        
        tableViewStatistics.register(UINib(nibName: PlayerDetailsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PlayerDetailsTableViewCell.identifier)
        binder()
        Task{
            await viewModel.getPlayerData(id: 239)
        }
        
    }
    
    func binder(){
        viewModel.$playerData.sink(){[weak self] data in
            guard let self = self else {return}
            if let data = data{
                self.playerInfo = data
                DispatchQueue.main.async {
                    self.tableViewStatistics.reloadData()
                }
            }
            
        }.store(in: &cancelable)
        
    }
    
}
extension ViewPlayerInfoViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        if playerInfo != nil{
            return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if playerInfo != nil{
            return 6
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewStatistics.dequeueReusableCell(withIdentifier: PlayerDetailsTableViewCell.identifier, for: indexPath) as!PlayerDetailsTableViewCell
        if indexPath.section == 0{
            
            
            if (indexPath.row == 0){
                cell.labelFormat.text = "Matches"
                cell.labelODI.text = String(playerInfo?.odiCareer?.batting?.matches ?? 0)
                cell.labelT20.text = String(playerInfo?.t20Career?.batting?.matches ?? 0)
                cell.labelTest.text = String(playerInfo?.testCareer?.batting?.matches ?? 0)
                cell.labelT20I.text = String(playerInfo?.t20iCareer?.batting?.matches ?? 0)
            }
            else if (indexPath.row == 1){
                cell.labelFormat.text = "Innings"
                cell.labelODI.text = String(playerInfo?.odiCareer?.batting?.innings ?? 0)
                cell.labelT20.text = String(playerInfo?.t20Career?.batting?.innings ?? 0)
                cell.labelTest.text = String(playerInfo?.testCareer?.batting?.innings ?? 0)
                cell.labelT20I.text = String(playerInfo?.t20iCareer?.batting?.innings ?? 0)
            }
            else if (indexPath.row == 2){
                cell.labelFormat.text = "Runs"
                cell.labelODI.text = String(playerInfo?.odiCareer?.batting?.runs_scored ?? 0)
                cell.labelT20.text = String(playerInfo?.t20Career?.batting?.runs_scored ?? 0)
                cell.labelTest.text = String(playerInfo?.testCareer?.batting?.runs_scored ?? 0)
                cell.labelT20I.text = String(playerInfo?.t20iCareer?.batting?.runs_scored ?? 0)
            }
            else if (indexPath.row == 3){
                cell.labelFormat.text = "Balls Faced"
                cell.labelODI.text = String(playerInfo?.odiCareer?.batting?.balls_faced ?? 0)
                cell.labelT20.text = String(playerInfo?.t20Career?.batting?.balls_faced ?? 0)
                cell.labelTest.text = String(playerInfo?.testCareer?.batting?.balls_faced ?? 0)
                cell.labelT20I.text = String(playerInfo?.t20iCareer?.batting?.balls_faced ?? 0)
            }
            else if (indexPath.row == 4){
                cell.labelFormat.text = "Average"
                cell.labelODI.text = String(format: "%.2f",playerInfo?.odiCareer?.batting?.average ?? 0)
                cell.labelT20.text = String(format: "%.2f",playerInfo?.t20Career?.batting?.average ?? 0)
                cell.labelTest.text = String(format: "%.2f",playerInfo?.testCareer?.batting?.average ?? 0)
                cell.labelT20I.text = String(format: "%.2f",playerInfo?.t20iCareer?.batting?.average ?? 0)
            }
            else if (indexPath.row == 5){
                cell.labelFormat.text = "Strike Rate"
                cell.labelODI.text = String(format: "%.2f",playerInfo?.odiCareer?.batting?.strike_rate ?? 0)
                cell.labelT20.text = String(format: "%.2f",playerInfo?.t20Career?.batting?.strike_rate ?? 0)
                cell.labelTest.text = String(format: "%.2f",playerInfo?.testCareer?.batting?.strike_rate ?? 0)
                cell.labelT20I.text = String(format: "%.2f",playerInfo?.t20iCareer?.batting?.strike_rate ?? 0)
            }
            
        }
        else{
            if (indexPath.row == 0){
                cell.labelFormat.text = "Matches"
                cell.labelODI.text = String(playerInfo?.odiCareer?.bowling?.matches ?? 0)
                cell.labelT20.text = String(playerInfo?.t20Career?.bowling?.matches ?? 0)
                cell.labelTest.text = String(playerInfo?.testCareer?.bowling?.matches ?? 0)
                cell.labelT20I.text = String(playerInfo?.t20iCareer?.bowling?.matches ?? 0)
            }
            else if (indexPath.row == 1){
                cell.labelFormat.text = "Innings"
                cell.labelODI.text = String(playerInfo?.odiCareer?.bowling?.innings ?? 0)
                cell.labelT20.text = String(playerInfo?.t20Career?.bowling?.innings ?? 0)
                cell.labelTest.text = String(playerInfo?.testCareer?.bowling?.innings ?? 0)
                cell.labelT20I.text = String(playerInfo?.t20iCareer?.bowling?.innings ?? 0)
            }
            else if (indexPath.row == 2){
                cell.labelFormat.text = "Overs"
                cell.labelODI.text = String(format: "%.2f",playerInfo?.odiCareer?.bowling?.overs ?? 0)
                cell.labelT20.text = String(format: "%.2f",playerInfo?.t20Career?.bowling?.overs ?? 0)
                cell.labelTest.text = String(format: "%.2f",playerInfo?.testCareer?.bowling?.overs ?? 0)
                cell.labelT20I.text = String(format: "%.2f",playerInfo?.t20iCareer?.bowling?.overs ?? 0)
            }
            else if (indexPath.row == 3){
                cell.labelFormat.text = "Runs"
                cell.labelODI.text = String(playerInfo?.odiCareer?.bowling?.runs ?? 0)
                cell.labelT20.text = String(playerInfo?.t20Career?.bowling?.runs ?? 0)
                cell.labelTest.text = String(playerInfo?.testCareer?.bowling?.runs ?? 0)
                cell.labelT20I.text = String(playerInfo?.t20iCareer?.bowling?.runs ?? 0)
            }
            else if (indexPath.row == 4){
                cell.labelFormat.text = "Wickets"
                cell.labelODI.text = String(playerInfo?.odiCareer?.bowling?.wickets ?? 0)
                cell.labelT20.text = String(playerInfo?.t20Career?.bowling?.wickets ?? 0)
                cell.labelTest.text = String(playerInfo?.testCareer?.bowling?.wickets ?? 0)
                cell.labelT20I.text = String(playerInfo?.t20iCareer?.bowling?.wickets ?? 0)
            }
            else if (indexPath.row == 5){
                cell.labelFormat.text = "Economy"
                cell.labelODI.text = String(format: "%.2f",playerInfo?.odiCareer?.bowling?.econ_rate ?? 0)
                cell.labelT20.text = String(format: "%.2f",playerInfo?.t20Career?.bowling?.econ_rate ?? 0)
                cell.labelTest.text = String(format: "%.2f",playerInfo?.testCareer?.bowling?.econ_rate ?? 0)
                cell.labelT20I.text = String(format: "%.2f",playerInfo?.t20iCareer?.bowling?.econ_rate ?? 0)
            }
        }
            
            return cell
        }

    
    
}
