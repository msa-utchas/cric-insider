//
//  PlayerDetailsTableViewCellTableViewCell.swift
//  CricInsider
//
//  Created by BJIT on 24/2/23.
//

import UIKit

class PlayerDetailsTableViewCell: UITableViewCell {
    static let identifier = "PlayerDetailsTableViewCell"
    @IBOutlet weak var labelT20: UILabel!
    @IBOutlet weak var labelTest: UILabel!
    @IBOutlet weak var labelODI: UILabel!
    @IBOutlet weak var labelFormat: UILabel!
 
    @IBOutlet weak var labelT20I: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

}
