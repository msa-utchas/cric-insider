//
//  LeagueWiseMatchesViewController.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 25/2/23.
//

import UIKit
import Combine
import SDWebImage


class LeagueWiseMatchesViewController: UIViewController {
    
    @IBOutlet weak var matchSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableViewMatches: UITableView!
    @IBOutlet weak var collectionViewLeague: UICollectionView!
    var viewModel = LeagueWiseMatchesViewModel()
    private var cancelable: Set<AnyCancellable> = []
    var leagueList: [League] = []
    var matchData: [MatchInfoModel] = []
    var selectedStatus: String = "NS"
    var selectedLeagueId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLeague.dataSource = self
        collectionViewLeague.delegate = self
        collectionViewLeague.register(UINib(nibName: LeaguesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: LeaguesCollectionViewCell.identifier)
        
        // setup the layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        // setup the layout
        //seup the with only three acomodation
        let width = (view.frame.size.width - 20) / 3
        layout.itemSize = CGSize(width: width, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionViewLeague.collectionViewLayout = layout
        tableViewMatches.dataSource = self
        tableViewMatches.delegate = self
        tableViewMatches.register(UINib(nibName: MatchesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MatchesTableViewCell.identifier)
        binder()
        Task{
            await viewModel.getAllLeagues()
        }
        
    }
    @IBAction func getSelectedMatchSegment(_ sender: Any) {
        switch matchSegmentControl.selectedSegmentIndex {
        case 0:
            selectedStatus = "NS"
        case 1:
            selectedStatus = "Finished"
        case 2:
            selectedStatus = "1st Innings,2nd Innings"
        default:
            selectedStatus = "NS"
        }
        Task{
            await viewModel.getMatchesInfo(leagueId: selectedLeagueId, status: selectedStatus)
        }
    }
    
    func binder() {
        viewModel.$leaguesList.sink{[weak self] data in
            guard let self else {return}
            if let data = data{
                if data.count > 0{
                    self.selectedLeagueId = data[0].id
                    Task{
                        await self.viewModel.getMatchesInfo(leagueId: self.selectedLeagueId, status: self.selectedStatus)
                    }
                }
                self.leagueList = data
                
                DispatchQueue.main.async {
                    self.collectionViewLeague.reloadData()
                }
            }
        }.store(in: &cancelable)
        
        viewModel.$matchesInfo.sink{[weak self] data in
            guard let self else {return}
            if let data = data{
                self.matchData = data
                DispatchQueue.main.async {
                    self.tableViewMatches.reloadData()
                }
            }
            
        }.store(in: &cancelable)
    }
   
    
    
}

extension LeagueWiseMatchesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        leagueList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewLeague.dequeueReusableCell(withReuseIdentifier: LeaguesCollectionViewCell.identifier, for: indexPath) as! LeaguesCollectionViewCell
        cell.imageViewLogo.sd_setImage(with: URL(string: leagueList[indexPath.row].image_path ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        cell.imageViewCodeName.text = leagueList[indexPath.row].code
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedLeagueId = leagueList[indexPath.row].id
        Task{
            await viewModel.getMatchesInfo(leagueId: selectedLeagueId, status: selectedStatus)
        }
    }
}

extension LeagueWiseMatchesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMatches.dequeueReusableCell(withIdentifier: MatchesTableViewCell.identifier, for: indexPath) as! MatchesTableViewCell
        let data = matchData[indexPath.row]
        cell.labelDate.text = (data.date ?? "") + " " + (data.time ?? "")
        cell.labelVisitorTeamName.text = data.visitorTeamName
        cell.labelMatchType.text = data.matchType
        cell.labelStatus.text = data.status
        cell.labelVisitorTeamFlag.sd_setImage(with: URL(string: data.visitorTeamImagePath ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
        cell.labelLocalTeamName.text = data.localTeamName
        cell.labelNote.text = data.note
    
        cell.labelLocalTeamFlag.sd_setImage(with: URL(string: data.localTeamImagePath ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
        cell.labelLeagueNameWithSeason.text = (data.leagueName ?? "") + "," + (data.seasonName ?? "")
        

        return cell
    }
    
}