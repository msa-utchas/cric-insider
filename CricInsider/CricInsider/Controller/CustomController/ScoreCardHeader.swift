
import UIKit

class ScoreCardHeader: UITableViewHeaderFooterView {

    @IBOutlet var backView: UIView!
    
    @IBOutlet weak var labelCountryName: UILabel!
    @IBOutlet weak var labelT1: UILabel!
    @IBOutlet weak var labelT2: UILabel!
    @IBOutlet weak var labelT3: UILabel!
    @IBOutlet weak var labelT4: UILabel!
    @IBOutlet weak var labelT5: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 2
        backView.layer.masksToBounds = true
    }

}
