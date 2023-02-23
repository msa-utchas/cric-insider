
import UIKit
import Combine
import SDWebImage
import UserNotifications
import Alamofire

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewFinishedMatches: UITableView!
    @IBOutlet weak var collectionBackgroundHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewMatches: UICollectionView!
    
    
    private var cancelable: Set<AnyCancellable> = []
    var viewModel = HomeViewModel()
    //var finishedMatches: [Data]? = []
    var upcomingMatchList: [UpcomingMatchModel] = []
    var finishedMatches: [FinishedMatchesModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewFinishedMatches.dataSource = self
        tableViewFinishedMatches.delegate = self
        collectionViewMatches.delegate = self
        collectionViewMatches.dataSource = self
        collectionViewMatches.register(UINib(nibName: MatchInfoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MatchInfoCollectionViewCell.identifier)
        collectionViewFlowLayoutSetup()
        //self.navigationController?.isNavigationBarHidden = true
//        labelFinishedMatchTitle.layer.cornerRadius = 10
//        labelFinishedMatchTitle.layer.masksToBounds = true
        
       
    
        
        Task{
            
            await viewModel.getUpcomingMatches()



            await viewModel.getFinishedMatches()
            // setup userDefault for notification if notification set today or not
            
            if let date = UserDefaults.standard.object(forKey: "Notification-Setup-Time") as? Date {
                let calendar = Calendar.current
                if calendar.isDateInToday(date) {
                    print("Notification already set for today")
                } else {
                    await viewModel.setupNotificationForUpcomingMatches()
                }
            } else {
                await viewModel.setupNotificationForUpcomingMatches()
            }

           


        }
        
        binder()
           
        
    }
    
    fileprivate func collectionViewFlowLayoutSetup() {
        let collectionViewCellLayout = UICollectionViewFlowLayout()
        collectionViewCellLayout.scrollDirection = .horizontal
        collectionViewMatches.collectionViewLayout = collectionViewCellLayout
    }
    
    func binder(){
        viewModel.$upcomingMatches.sink{[weak self] upcomingMatches in
            guard let self = self else {return}
            self.upcomingMatchList = upcomingMatches
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                self.collectionViewMatches.reloadData()
            }
        }.store(in: &cancelable)
        
        viewModel.$upcomingMatchSelectedID.sink{[weak self] selectedID in
            guard let self = self else {return}
            if let selectedID = selectedID{
                let viewController = self.storyboard?.instantiateViewController(identifier: "MatchDetailsViewController") as! MatchDetailsViewController
                viewController.loadViewIfNeeded()
                Task{
                    await viewController.matchDetailsViewModel.setMatchDetails(id: selectedID)
                }
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
            
        }.store(in: &cancelable)
        
        viewModel.$finishedMatches.sink{[weak self] finishedMatchesList in
            guard let self = self else {return}
            self.finishedMatches = finishedMatchesList
            DispatchQueue.main.async {
                self.tableViewFinishedMatches.reloadData()
            }
            
            
        }.store(in: &cancelable)
        
        viewModel.$finishedMatchSelectedID.sink{[weak self] selectedId in
            guard let self = self else {return}
            if let selectedID = selectedId{
                let viewController = self.storyboard?.instantiateViewController(identifier: "MatchDetailsViewController") as! MatchDetailsViewController
                viewController.loadViewIfNeeded()
                Task{
                    await viewController.matchDetailsViewModel.setMatchDetails(id: selectedID)
                }
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
            
        }.store(in: &cancelable)
    }
    
}



//MatchInfoCollectionViewCell
extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finishedMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FinishedMatchesTableViewCell.identifier, for: indexPath) as! FinishedMatchesTableViewCell
        let match = finishedMatches[indexPath.row]
        cell.labelLeagueInfo.text = match.leagueName ?? "__"
        cell.labelWiningInfo.text = match.note ?? "__"
//        cell..text = match.localTeam?.code
//        cell.labelTeamB.text = match.visitorTeam?.code
        cell.labelTeamAName.text = match.localTeam?.code ?? ""
        cell.labelTeamBName.text = match.visitorTeam?.code ?? ""
        cell.labelTeamAScore.text = String(match.localTeamRun?.score ?? 0) + "-" + String(match.localTeamRun?.wickets ?? 0) + "(" + String(match.localTeamRun?.overs ?? 0.0) + ")"
        cell.labelTeamBScore.text = String(match.visitorTeamRun?.score ?? 0) + "-" + String(match.visitorTeamRun?.wickets ?? 0) + "(" + String(match.visitorTeamRun?.overs ?? 0.0) + ")"

        cell.teamAImageView.sd_setImage(with: URL(string: match.localTeam?.image_path ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        cell.teamBImageView.sd_setImage(with: URL(string: match.visitorTeam?.image_path ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        cell.labelDate.text = ((match.date ?? "") + " " + (match.time ?? ""))
        cell.labelType.text = match.matchType
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let fixtureId = finishedMatches[indexPath.row].fixtureId{
            
            viewModel.setTableViewSelectedIndex(fixtureId: fixtureId)
        }
    }
 }


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let scrollView = scrollView as? UITableView else {return}
        if scrollView.contentOffset.y > 0 {
            
            UIView.animate(withDuration: 0.6) { [weak self] in
                self?.collectionViewMatches.alpha = 0
                
                self?.collectionBackgroundHeightConstraint.constant = 0
                self?.collectionViewHeightConstraint.constant = 80
                //self?.collectionViewMatches.isHidden = true
                self?.view.layoutIfNeeded()
            }
        }
        
        else {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.collectionViewMatches.alpha = 1
                self?.collectionBackgroundHeightConstraint.constant = 100
                self?.collectionViewHeightConstraint.constant = 240
                
                self?.view.layoutIfNeeded()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingMatchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchInfoCollectionViewCell.identifier, for: indexPath) as! MatchInfoCollectionViewCell
        cell.leagueAndSeasonName.text = (upcomingMatchList[indexPath.row].leagueName ?? "Unknown") + " " + (upcomingMatchList[indexPath.row].seasonName ?? "")
        cell.roundName.text = upcomingMatchList[indexPath.row].round ?? "Unknown"
        cell.startDate.text = (upcomingMatchList[indexPath.row].date ?? "Unknown") + " " + (upcomingMatchList[indexPath.row].time ?? "")
        cell.localTeamName.text = upcomingMatchList[indexPath.row].localTeamName ?? "Unknown"
        cell.visitorTeamName.text = upcomingMatchList[indexPath.row].visitorTeamName ?? "Unknown"
        cell.visitorTeamLogo.sd_setImage(with: URL(string: upcomingMatchList[indexPath.row].visitorTeamImagePath ?? ""))
        cell.localTeamLogo.sd_setImage(with: URL(string: upcomingMatchList[indexPath.row].localTeamImagePath ?? ""))
        cell.matchStartTime = upcomingMatchList[indexPath.row].dateObject
        cell.labelType.text = upcomingMatchList[indexPath.row].matchType
        if(upcomingMatchList[indexPath.row].status != "NS"){
            cell.labelMatchStatus.text = "Live"
        }
        else{
            cell.labelMatchStatus.text = "Upcoming"
        }
        cell.matchStatus = upcomingMatchList[indexPath.row].status
        //cell.inputViewController?.loadView()
        //cell.viewModel.startTimer(matchStartTime: upcomingMatchList[indexPath.row].dateObject!)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height:collectionViewMatches.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let fixtureId = upcomingMatchList[indexPath.row].fixtureId{
            
            viewModel.setCollectionViewSelectedIndex(fixtureId: fixtureId)
        }
    }
    
}
