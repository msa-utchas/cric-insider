//
//  SearchedPlayerTableViewCell.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 20/2/23.
//

import UIKit

class SearchedPlayerTableViewCell: UITableViewCell {
    static let Identifier: String = "SearchedPlayerTableViewCell"
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelCountryName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.addShadow()
        imageViewProfile.addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
