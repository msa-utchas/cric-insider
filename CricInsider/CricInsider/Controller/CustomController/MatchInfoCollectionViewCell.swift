//
//  MatchInfoCollectionViewCell.swift
//  CricInsider
//
//  Created by BJIT on 16/2/23.
//

import UIKit

class MatchInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var leagueAndSeasonName: UILabel!
    @IBOutlet weak var labelStarsIn: UILabel!
    @IBOutlet weak var viewBackGround: UIView!
    @IBOutlet weak var roundName: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var localTeamLogo: UIImageView!
    @IBOutlet weak var localTeamName: UILabel!
   
    @IBOutlet weak var labelMatchStatus: UILabel!
    @IBOutlet var labelType: UILabel!
    @IBOutlet weak var visitorTeamLogo: UIImageView!
    @IBOutlet weak var visitorTeamName: UILabel!
    @IBOutlet weak var matchHeaderStackView: UIStackView!
    
    @IBOutlet weak var matchSubHeaderStackView: UIStackView!
    var matchStartTime: Date!
    var matchStatus: String?
    var timer: Timer?
    var viewModel = HomeViewModel()
    
    static let identifier = "MatchInfoCollectionViewCell"

    fileprivate func setupXib() {
        viewBackGround.layer.cornerRadius = 10
        labelStarsIn.layer.cornerRadius = 5
        labelStarsIn.layer.masksToBounds = true
        
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.systemGray4.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewBackGround.layer.borderWidth = 1.0
        viewBackGround.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.3).cgColor
        contentView.layer.shadowOpacity = 0.8
        contentView.layer.shadowRadius = 4
        matchHeaderStackView.layer.cornerRadius = 5
        matchSubHeaderStackView.layer.cornerRadius = 5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupXib()
        
        startTimer()
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        stopTimer()
        startTimer()
    }

    
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self = self else {return}
            let time = self.viewModel.updateTimeRemaining(matchStartTime: (self.matchStartTime!))
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                //check time is negative or not
                if time.contains("-") {
                    self.stopTimer()
                    self.labelStarsIn.text = "Match Started"
                }

                self.labelStarsIn.text = time
            }
            
        })
    }
    func stopTimer() {
        timer?.invalidate()
    }

   
    
    deinit{
        timer?.invalidate()
    }
}



