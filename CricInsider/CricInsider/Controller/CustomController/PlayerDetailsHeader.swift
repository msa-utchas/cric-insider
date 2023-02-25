//
//  PlayerDetailsHeder.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 24/2/23.
//

import UIKit

class PlayerDetailsHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var labelFormat: UILabel!
    
    @IBOutlet weak var xibBackView: UIView!
    static let identifier = "PlayerDetailsHeader"
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            xibBackView.addShadow()
        }

        

}
