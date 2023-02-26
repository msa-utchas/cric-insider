import UIKit
import Combine
import SDWebImage
import UserNotifications
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewFinishedMatches: UITableView!
    @IBOutlet weak var collectionBackgroundHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewMatches: UICollectionView!
    
    var viewModel = HomeViewModel()
    
    private var cancelable: Set<AnyCancellable> = []
    var upcomingMatchList: [UpcomingMatchModel] = []
    var finishedMatches: [FinishedMatchesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewFinishedMatches.dataSource = self
        tableViewFinishedMatches.delegate = self
        collectionViewMatches.delegate = self
        collectionViewMatches.dataSource = self
        collectionViewMatches.register(UINib(nibName: MatchInfoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MatchInfoCollectionViewCell.identifier)
        collectionViewFlowLayoutSetup()
        
        getDataFromApi()
        binder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func collectionViewFlowLayoutSetup() {
        let collectionViewCellLayout = UICollectionViewFlowLayout()
        let width = (view.frame.size.width)
        collectionViewCellLayout.itemSize = CGSize(width: width, height: 240)
        collectionViewCellLayout.minimumLineSpacing = 10
        collectionViewCellLayout.minimumInteritemSpacing = 10
        
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
                if NetworkReachabilityManager()!.isReachable{
                    self.activityIndicator.startAnimating()
                    self.tableViewFinishedMatches.isUserInteractionEnabled = false
                    self.collectionViewMatches.isUserInteractionEnabled = false
                    let viewController = self.storyboard?.instantiateViewController(identifier: "MatchDetailsViewController") as! MatchDetailsViewController
                    viewController.loadViewIfNeeded()
                    viewController.matchDetailsViewModel.matchID = selectedID
                    Task{
                        
                        await viewController.matchDetailsViewModel.setMatchDetails(id: selectedID)
                        self.activityIndicator.stopAnimating()
                        self.tableViewFinishedMatches.isUserInteractionEnabled = true
                        self.collectionViewMatches.isUserInteractionEnabled = true
                    }
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
                else{
                    self.showAlert(title: "Network Error", message: "Please check your internet connection and try again")
                }
                
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
            
            if NetworkReachabilityManager()!.isReachable{
                
                if let selectedID = selectedId{
                    self.activityIndicator.startAnimating()
                    self.tableViewFinishedMatches.isUserInteractionEnabled = false
                    self.collectionViewMatches.isUserInteractionEnabled = false
                    let viewController = self.storyboard?.instantiateViewController(identifier: "MatchDetailsViewController") as! MatchDetailsViewController
                    viewController.loadViewIfNeeded()
                    Task{
                        viewController.matchDetailsViewModel.matchID =  selectedID
                        await viewController.matchDetailsViewModel.setMatchDetails(id: selectedID)
                        self.activityIndicator.stopAnimating()
                        self.tableViewFinishedMatches.isUserInteractionEnabled = true
                        self.collectionViewMatches.isUserInteractionEnabled = true
                    }
                    self.navigationController?.pushViewController(viewController, animated: true)
                    
                    
                }
            }
            else{
                self.showAlert(title: "Network Error", message: "Please check your internet connection and try again")
            }
            
        }.store(in: &cancelable)
        viewModel.$errorMessage.sink(){[weak self] message in
            guard let self = self else {return}
            if let message = message{
                self.showAlert(title: "Network Error", message: message)
            }
            
        }.store(in: &cancelable)
    }
    
}





extension HomeViewController{
    func getDataFromApi(){
        Task{
            activityIndicator.startAnimating()
            
            if  NetworkReachabilityManager()!.isReachable{
                
                await viewModel.getUpcomingMatches()
                await viewModel.getFinishedMatches()
                if let date = UserDefaults.standard.object(forKey: "Notification-Setup-Time") as? Date {
                    let calendar = Calendar.current
                    if !calendar.isDateInToday(date) {
                        await viewModel.setupNotificationForUpcomingMatches()
                    }
                } else {
                    await viewModel.setupNotificationForUpcomingMatches()
                }
                activityIndicator.stopAnimating()
                
            }
            else{
                
                activityIndicator.stopAnimating()
                showAlert(title: "Network Error", message: "Please check your internet connection and try again.")
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {[weak self] _ in
            guard let self = self else {return}
            self.getDataFromApi()
        }))
        present(alert, animated: true, completion: nil)
    }
}

