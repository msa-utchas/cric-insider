//
//  ScoreCardTableViewCell.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 19/2/23.
//

import UIKit

class ScoreCardTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!

    static let identifier = "ScoreCardTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


        
    }

}
