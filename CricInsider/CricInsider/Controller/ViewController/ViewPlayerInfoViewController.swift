//
//  ViewPlayerInfoViewController.swift
//  CricInsider
//
//  Created by BJIT on 24/2/23.
//

import UIKit
import Combine

class ViewPlayerInfoViewController: UIViewController {
    @IBOutlet weak var labelCountryImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCountryName: UILabel!
    @IBOutlet weak var labelBirthDate: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelBatingStyle: UILabel!
    @IBOutlet weak var labelBowlingStyle: UILabel!
    @IBOutlet weak var imageViewProfileImage: UIImageView!
    @IBOutlet weak var tableViewStatistics: UITableView!
    static let identifier  = "ViewPlayerInfoViewController"
    private var cancelable: Set<AnyCancellable> = []
    var playerInfo: PlayerCareerModel?
    let viewModel =  ViewPlayerInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageViewProfileImage.layer.borderWidth = 1
        imageViewProfileImage.layer.masksToBounds = false
        imageViewProfileImage.layer.borderColor = UIColor.white.cgColor
        imageViewProfileImage.clipsToBounds = true
        tableViewStatistics.dataSource = self
        tableViewStatistics.delegate = self
        tableViewStatistics.register(UINib(nibName: PlayerDetailsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PlayerDetailsTableViewCell.identifier)
        tableViewStatistics.register(UINib(nibName: PlayerDetailsHeader.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: PlayerDetailsHeader.identifier)
        
        
        binder()
        
    }
    
    func binder(){
        viewModel.$playerData.sink(){[weak self] data in
            guard let self = self else {return}
            if let data = data{
                self.playerInfo = data
                DispatchQueue.main.async {
                    self.labelName.text = data.fullname ?? "N\\A"
                    self.labelCountryName.text = data.country?.name ?? "N\\A"
                    self.labelRole.text = data.position?.name ?? "N\\A"
                    self.labelBirthDate.text = data.dateofbirth ?? "N\\A"
                    self.labelBatingStyle.text = data.battingstyle ?? "N\\A"
                    self.labelBowlingStyle.text = data.bowlingstyle ?? "N\\A"
                    self.imageViewProfileImage.sd_setImage(with: URL(string: data.image_path ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
                    self.labelCountryImage.sd_setImage(with: URL(string: data.country?.image_path ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
                    
                    self.tableViewStatistics.reloadData()
                }
            }
            
        }.store(in: &cancelable)
        
    }
    
}

