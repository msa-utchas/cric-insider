//
//  SquadListTableViewCell.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 18/2/23.
//

import UIKit

class SquadListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    static let identifier = "SquadListTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
