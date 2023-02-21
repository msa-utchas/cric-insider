//
//  HomeViewModel.swift
//  CricInsider
//
//  Created by BJIT on 15/2/23.
//

import Foundation
import Combine

class HomeViewModel{
     private var fixtureMatchListRepository: FixtureMatchesListRepository
    @Published var upcomingMatches: [UpcomingMatchModel] = []
    @Published var finishedMatches:[FinishedMatchesModel] = []
    @Published var upcomingMatchSelectedID : Int?
    @Published var finishedMatchSelectedID : Int?
    
    
    var timer: Timer?
    
    
    init(fixtureMatchListRepository: FixtureMatchesListRepository =  FixturesRepository()) {
        self.fixtureMatchListRepository = fixtureMatchListRepository
    }

        func getUpcomingMatches() async {
            let data = await fixtureMatchListRepository.getUpcomingMatches()
            switch data{
            case .success(let data):
                upcomingMatches = data    
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
    
        }
    func getFinishedMatches() async {
        let data = await fixtureMatchListRepository.getFinishedMatches()
        switch data{
        case .success(let data):
             finishedMatches = data
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }

    }
    func setCollectionViewSelectedIndex(fixtureId: Int){
        upcomingMatchSelectedID = fixtureId
    }
    func setTableViewSelectedIndex(fixtureId: Int){
        finishedMatchSelectedID = fixtureId
    }
    
    func updateTimeRemaining(matchStartTime: Date)->String {
        // Calculate the time remaining
        let timeRemaining = matchStartTime.timeIntervalSinceNow
    
        // Update the cell with the time remaining
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        let timeRemainingString = formatter.string(from: timeRemaining)!
        return "Match Starts In: " + timeRemainingString
    }
}
