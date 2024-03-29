
import Foundation
import UIKit

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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableViewStatistics.dequeueReusableHeaderFooterView(withIdentifier: PlayerDetailsHeader.identifier) as! PlayerDetailsHeader
        if section == 0{
            cell.labelFormat.text = "Batting"
        }
        else
        {
            cell.labelFormat.text = "Bowling"
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewStatistics.dequeueReusableCell(withIdentifier: PlayerDetailsTableViewCell.identifier, for: indexPath) as!PlayerDetailsTableViewCell
        cell.selectionStyle = .none
        if indexPath.section == 0{
            
            
            if indexPath.row == 0 {
                cell.labelFormat.text = "Matches"
                cell.labelODI.text = formatIntValue(playerInfo?.odiCareer?.batting?.matches)
                cell.labelT20.text = formatIntValue(playerInfo?.t20Career?.batting?.matches)
                cell.labelTest.text = formatIntValue(playerInfo?.testCareer?.batting?.matches)
                cell.labelT20I.text = formatIntValue(playerInfo?.t20iCareer?.batting?.matches)
            } else if indexPath.row == 1 {
                cell.labelFormat.text = "Innings"
                cell.labelODI.text = formatIntValue(playerInfo?.odiCareer?.batting?.innings)
                cell.labelT20.text = formatIntValue(playerInfo?.t20Career?.batting?.innings)
                cell.labelTest.text = formatIntValue(playerInfo?.testCareer?.batting?.innings)
                cell.labelT20I.text = formatIntValue(playerInfo?.t20iCareer?.batting?.innings)
            } else if indexPath.row == 2 {
                cell.labelFormat.text = "Runs"
                cell.labelODI.text = formatIntValue(playerInfo?.odiCareer?.batting?.runs_scored)
                cell.labelT20.text = formatIntValue(playerInfo?.t20Career?.batting?.runs_scored)
                cell.labelTest.text = formatIntValue(playerInfo?.testCareer?.batting?.runs_scored)
                cell.labelT20I.text = formatIntValue(playerInfo?.t20iCareer?.batting?.runs_scored)
            } else if indexPath.row == 3 {
                cell.labelFormat.text = "Balls Faced"
                cell.labelODI.text = formatDoubleValue(playerInfo?.odiCareer?.batting?.balls_faced)
                cell.labelT20.text = formatDoubleValue(playerInfo?.t20Career?.batting?.balls_faced)
                cell.labelTest.text = formatDoubleValue(playerInfo?.testCareer?.batting?.balls_faced)
                cell.labelT20I.text = formatDoubleValue(playerInfo?.t20iCareer?.batting?.balls_faced)
            } else if indexPath.row == 4 {
                cell.labelFormat.text = "Average"
                cell.labelODI.text = formatDoubleValue(playerInfo?.odiCareer?.batting?.average)
                cell.labelT20.text = formatDoubleValue(playerInfo?.t20Career?.batting?.average)
                cell.labelTest.text = formatDoubleValue(playerInfo?.testCareer?.batting?.average)
                cell.labelT20I.text = formatDoubleValue(playerInfo?.t20iCareer?.batting?.average)
            } else if indexPath.row == 5 {
                cell.labelFormat.text = "Strike Rate"
                cell.labelODI.text = formatDoubleValue(playerInfo?.odiCareer?.batting?.strike_rate)
                cell.labelT20.text = formatDoubleValue(playerInfo?.t20Career?.batting?.strike_rate)
                cell.labelTest.text = formatDoubleValue(playerInfo?.testCareer?.batting?.strike_rate)
                cell.labelT20I.text = formatDoubleValue(playerInfo?.t20iCareer?.batting?.strike_rate)
            }
        }
        else{
            if (indexPath.row == 0){
                cell.labelFormat.text = "Matches"
                cell.labelODI.text = formatIntValue(playerInfo?.odiCareer?.bowling?.matches)
                cell.labelT20.text = formatIntValue(playerInfo?.t20Career?.bowling?.matches)
                cell.labelTest.text = formatIntValue(playerInfo?.testCareer?.bowling?.matches)
                cell.labelT20I.text = formatIntValue(playerInfo?.t20iCareer?.bowling?.matches)
            }
            else if (indexPath.row == 1){
                cell.labelFormat.text = "Innings"
                cell.labelODI.text = formatIntValue(playerInfo?.odiCareer?.bowling?.innings)
                cell.labelT20.text = formatIntValue(playerInfo?.t20Career?.bowling?.innings)
                cell.labelTest.text = formatIntValue(playerInfo?.testCareer?.bowling?.innings)
                cell.labelT20I.text = formatIntValue(playerInfo?.t20iCareer?.bowling?.innings)
            }
            else if (indexPath.row == 2){
                cell.labelFormat.text = "Overs"
                cell.labelODI.text = formatDoubleValue(playerInfo?.odiCareer?.bowling?.overs)
                cell.labelT20.text = formatDoubleValue(playerInfo?.t20Career?.bowling?.overs)
                cell.labelTest.text = formatDoubleValue(playerInfo?.testCareer?.bowling?.overs)
                cell.labelT20I.text = formatDoubleValue(playerInfo?.t20iCareer?.bowling?.overs)
            }
            else if (indexPath.row == 3){
                cell.labelFormat.text = "Runs"
                cell.labelODI.text = formatIntValue(playerInfo?.odiCareer?.bowling?.runs)
                cell.labelT20.text = formatIntValue(playerInfo?.t20Career?.bowling?.runs)
                cell.labelTest.text = formatIntValue(playerInfo?.testCareer?.bowling?.runs)
                cell.labelT20I.text = formatIntValue(playerInfo?.t20iCareer?.bowling?.runs)
            }
            else if (indexPath.row == 4){
                cell.labelFormat.text = "Wickets"
                cell.labelODI.text = formatIntValue(playerInfo?.odiCareer?.bowling?.wickets)
                cell.labelT20.text = formatIntValue(playerInfo?.t20Career?.bowling?.wickets)
                cell.labelTest.text = formatIntValue(playerInfo?.testCareer?.bowling?.wickets)
                cell.labelT20I.text = formatIntValue(playerInfo?.t20iCareer?.bowling?.wickets)
            }
            else if (indexPath.row == 5){
                cell.labelFormat.text = "Economy"
                cell.labelODI.text = formatDoubleValue(playerInfo?.odiCareer?.bowling?.econ_rate)
                cell.labelT20.text = formatDoubleValue(playerInfo?.t20Career?.bowling?.econ_rate)
                cell.labelTest.text = formatDoubleValue(playerInfo?.testCareer?.bowling?.econ_rate)
                cell.labelT20I.text = formatDoubleValue(playerInfo?.t20iCareer?.bowling?.econ_rate)
            }
        }
        
        return cell
    }
    
   
    
    func formatIntValue(_ value: Int?, defaultString: String = "N/A") -> String {
        guard let value = value else {
            return defaultString
        }
        if String(value) == "nan"{
            return defaultString
        }
        return String(value)
    }
    
    func formatDoubleValue(_ value: Double?, format: String = "%.2f", defaultString: String = "N/A") -> String {
        guard let value = value else {
            return defaultString
        }
        if String(value) == "nan" {
            return defaultString
        }
        return String(format: format, value)
    }
    
}
