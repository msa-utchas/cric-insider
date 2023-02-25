//
//  LeagueWiseMatchesViewModel.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 25/2/23.
//

import Foundation
import Combine
class LeagueWiseMatchesViewModel {
    var leagueWiseFixtureRepository: LeagueWiseFixtureRepository
    @Published var matchesInfo: [MatchInfoModel]? = []
    @Published var isLoading: Bool?
    @Published var leaguesList: [League]?
    
    init(leagueWiseFixtureRepository : LeagueWiseFixtureRepository = FixturesRepository()) {
        self.leagueWiseFixtureRepository = leagueWiseFixtureRepository
    }
    
    func getAllLeagues() async {
        let data = await leagueWiseFixtureRepository.getAllLeagues()
        switch data{
        case .success(let leagues):
            leaguesList = leagues.data
        case .failure(let error):
            print(error.localizedDescription)
            
        }
    }
    func getMatchesInfo(leagueId: Int, status: String) async {
        isLoading = true
        let data = await leagueWiseFixtureRepository.getLeagueWiseFixtures(id: leagueId, status: status)
        switch data{
        case .success(let matches):
            matchesInfo = matches
        case .failure(let error):
            print(error.localizedDescription)

        }
        isLoading = false
    }
}
