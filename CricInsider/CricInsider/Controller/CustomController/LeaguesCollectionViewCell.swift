
import UIKit

class LeaguesCollectionViewCell: UICollectionViewCell {
    static let identifier = "LeaguesCollectionViewCell"
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewCodeName: UILabel!
    @IBOutlet weak var imageViewLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.addShadow()
        
    }
   
    override var isSelected: Bool {
            didSet {
                if isSelected {
                    // Change appearance when selected
                    self.viewBackground.backgroundColor = UIColor(named: "custom1")
                    self.imageViewCodeName.textColor = .white
                } else {
                    // Change appearance when deselected
                    self.imageViewCodeName.textColor = .black
                    self.viewBackground.backgroundColor = .white
                }
            }
        }
    
}
