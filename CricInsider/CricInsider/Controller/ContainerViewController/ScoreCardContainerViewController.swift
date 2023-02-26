
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

