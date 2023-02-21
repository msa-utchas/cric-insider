//
//  SquadListTableViewCell.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 18/2/23.
//

import UIKit

class SquadListTableViewCell: UITableViewCell {
    @IBOutlet var backView: UIView!
    @IBOutlet weak var labelName: UILabel!
    static let identifier = "SquadListTableViewCell"

    @IBOutlet var imageViewPlayer: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 8
        backView.layer.shadowColor = UIColor.systemGray3.cgColor
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backView.layer.shadowOpacity = 0.8
        backView.layer.shadowRadius = 4

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
