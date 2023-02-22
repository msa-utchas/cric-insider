//
//  DateWiseMatchViewModel.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 22/2/23.
//

import Foundation

class DateWiseMatchViewModel{
    @Published var matchData: [MatchInfoModel]?
    var dateWiseMatchRepository: DateWiseMatchRepository
    
    init(dateWiseMatchRepository: DateWiseMatchRepository = FixturesRepository()) {
        self.dateWiseMatchRepository = dateWiseMatchRepository
    }
    
    func getDateWiseMatches(date: Date) async {
        let result = await dateWiseMatchRepository.getDateWiseMatches(date: date)
        switch result{
        case .success(let data):
            self.matchData = data
        case .failure(let error):
            debugPrint(error)
        }
    }

}
