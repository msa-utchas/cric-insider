//
//  MatchesTableViewCell.swift
//  CricInsider
//
//  Created by BJIT on 22/2/23.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelVisitorTeamName: UILabel!
    @IBOutlet weak var labelMatchType: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelVisitorTeamFlag: UIImageView!
    @IBOutlet weak var labelLocalTeamName: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelLocalTeamFlag: UIImageView!
    @IBOutlet weak var labelLeagueNameWithSeason: UILabel!
    static let identifier = "MatchesTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state


    }
    
}
