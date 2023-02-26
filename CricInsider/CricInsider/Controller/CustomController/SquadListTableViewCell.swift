
import UIKit

class SquadListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelPlayerType: UILabel!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var labelName: UILabel!
    static let identifier = "SquadListTableViewCell"
    
    @IBOutlet var imageViewPlayer: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        backView.layer.cornerRadius = 8
        backView.layer.shadowColor = UIColor.systemGray3.cgColor
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backView.layer.shadowOpacity = 0.8
        backView.layer.shadowRadius = 4
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    
    }
    
}
