//
//  LeaguesCollectionViewCell.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 25/2/23.
//

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
    
}
