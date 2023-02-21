//
//  ScoreCardContainerViewController.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 18/2/23.
//

import UIKit
import Combine

class ScoreCardContainerViewController: UIViewController {

    @IBOutlet weak var scoreCardTableView: UITableView!
    private var cancelable: Set<AnyCancellable> = []
    var scoreCardViewModel = MatchDetailsViewModel.shared
    var localTeamBatting: [Batting] = []
    var localTeamBowling: [Bowling] = []
    var visitorTeamBatting: [Batting] = []
    var visitorTeamBowling: [Bowling] = []
    var localTeamName: String?
    var visitorTeamName: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        scoreCardTableView.dataSource = self
        scoreCardTableView.delegate = self
        // register nib
        scoreCardTableView.register(UINib(nibName: ScoreCardTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ScoreCardTableViewCell.identifier)
        // register header
        scoreCardTableView.register(UINib(nibName: "ScoreCardHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "ScoreCardHeader")
        binder()
    }

}


extension ScoreCardContainerViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ScoreCardHeader") as! ScoreCardHeader
        if section == 0 {
            header.labelCountryName.text = localTeamName
        }
        if section == 1 {
            header.labelCountryName.text = localTeamName
        }
        if section == 2 {
            header.labelCountryName.text = visitorTeamName
        }
        if section == 3 {
            header.labelCountryName.text = visitorTeamName
        }
        return header
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 60
        if section == 0 {
            if localTeamBatting.count == 0 {
                height = 0
            }
        }
        if section == 1 {
            if localTeamBowling.count == 0 {
                height = 0
            }
        }
        if section == 2 {
            if visitorTeamBatting.count == 0 {
                height = 0
            }
        }
        if section == 3 {
            if visitorTeamBowling.count == 0 {
                height = 0
            }
        }
        return height

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return localTeamBatting.count
        } else if section == 1 {
            return localTeamBowling.count
        } else if section == 2 {
            return visitorTeamBatting.count
        } else {
            return visitorTeamBowling.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScoreCardTableViewCell.identifier, for: indexPath) as! ScoreCardTableViewCell
        if indexPath.section == 0 {
            let localTeamBatingData = localTeamBatting[indexPath.row]
            cell.labelName.text = localTeamBatingData.batsman?.fullname
            cell.labelOne.text = String(localTeamBatingData.score ?? 0)
            cell.labelTwo.text = String(localTeamBatingData.ball ?? 0)
            cell.labelThree.text = String(localTeamBatingData.four_x ?? 0)
            cell.labelFour.text = String(localTeamBatingData.six_x ?? 0)
            cell.labelFive.text = String(localTeamBatingData.rate ?? 0)
        }
        if indexPath.section == 1 {
            let localTeamBowlingData = localTeamBowling[indexPath.row]
            cell.labelName.text = localTeamBowlingData.bowler?.fullname
            cell.labelOne.text = String(localTeamBowlingData.overs ?? 0)
            cell.labelTwo.text = String(localTeamBowlingData.medians ?? 0)
            cell.labelThree.text = String(localTeamBowlingData.runs ?? 0)
            cell.labelFour.text = String(localTeamBowlingData.wickets ?? 0)
            cell.labelFive.text = String(localTeamBowlingData.rate ?? 0)
        }
        if indexPath.section == 2 {
            let visitorTeamBatingData = visitorTeamBatting[indexPath.row]
            cell.labelName.text = visitorTeamBatingData.batsman?.fullname
            cell.labelOne.text = String(visitorTeamBatingData.score ?? 0)
            cell.labelTwo.text = String(visitorTeamBatingData.ball ?? 0)
            cell.labelThree.text = String(visitorTeamBatingData.four_x ?? 0)
            cell.labelFour.text = String(visitorTeamBatingData.six_x ?? 0)
            cell.labelFive.text = String(visitorTeamBatingData.rate ?? 0)
        }
        if indexPath.section == 3 {
            let visitorTeamBowlingData = visitorTeamBowling[indexPath.row]
            cell.labelName.text = visitorTeamBowlingData.bowler?.fullname
            cell.labelOne.text = String(visitorTeamBowlingData.overs ?? 0)
            cell.labelTwo.text = String(visitorTeamBowlingData.medians ?? 0)
            cell.labelThree.text = String(visitorTeamBowlingData.runs ?? 0)
            cell.labelFour.text = String(visitorTeamBowlingData.wickets ?? 0)
            cell.labelFive.text = String(visitorTeamBowlingData.rate ?? 0)
        }


        return cell
    }

    // height for cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }


}

extension ScoreCardContainerViewController {
    func binder() {
        scoreCardViewModel.$matchDetails.sink { [weak self] (matchDetails) in
                    guard let self = self else {
                        return
                    }
                    self.localTeamBatting = matchDetails?.localTeamBatting ?? []
                    self.localTeamBowling = matchDetails?.localTeamBowling ?? []
                    self.visitorTeamBatting = matchDetails?.visitorTeamBatting ?? []
                    self.visitorTeamBowling = matchDetails?.visitorTeamBowling ?? []
                    self.localTeamName = matchDetails?.localTeamName
                    self.visitorTeamName = matchDetails?.visitorTeamName
                    DispatchQueue.main.async {
                        self.scoreCardTableView.reloadData()
                    }


                }
                .store(in: &cancelable)
    }

}

