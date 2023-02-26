import Foundation
import Combine

class LeagueWiseMatchesViewModel {
    
    var leagueWiseFixtureRepository: LeagueWiseFixtureRepository
    
    @Published var matchesInfo: [MatchInfoModel]? = []
    @Published var leaguesList: [League]?
    @Published var selectedIndexData: MatchInfoModel?
    
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
        
        let data = await leagueWiseFixtureRepository.getLeagueWiseFixtures(id: leagueId, status: status)
        switch data{
        case .success(let matches):
            matchesInfo = matches
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func setSelectedIndexData(data : MatchInfoModel){
        selectedIndexData = data
    }
    
}
