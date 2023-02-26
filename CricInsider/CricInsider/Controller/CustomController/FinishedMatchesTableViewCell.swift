
import UIKit

class FinishedMatchesTableViewCell: UITableViewCell {
    static let identifier = "FinishedMatchesTableViewCell"
    
    @IBOutlet var labelDate: UILabel!
    @IBOutlet weak var teamBImageView: UIImageView!
    @IBOutlet weak var labelLeagueInfo: UILabel!
    @IBOutlet weak var labelTeamBScore: UILabel!
    @IBOutlet weak var labelTeamAScore: UILabel!
    @IBOutlet var labelType: UILabel!
    @IBOutlet weak var teamAImageView: UIImageView!
    @IBOutlet weak var labelWiningInfo: UILabel!
    @IBOutlet weak var labelTeamAName: UILabel!
    @IBOutlet weak var labelTeamBName: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.cornerRadius = 5
        
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.systemGray3.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.8
        contentView.layer.shadowRadius = 4
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
