import Foundation

protocol UpcomingMatchesFixturesRepository{
    func getUpcomingMatches() async -> Result<[UpcomingMatchModel], Error>
}
protocol MatchDetailsRepository{
    func getMatchDetails(id: Int) async -> Result<MatchDetailsModel, Error>
}
protocol FinishedMatchesFixtureRepository{
    func getFinishedMatches() async -> Result<[FinishedMatchesModel], Error>
}
protocol DateWiseMatchRepository{
    func getDateWiseMatches(date : Date) async ->Result<[MatchInfoModel], Error>
}

protocol  FixtureMatchesListRepository: UpcomingMatchesFixturesRepository,FinishedMatchesFixtureRepository{}

protocol LeagueWiseFixtureRepository{
    
    func getAllLeagues() async -> Result<LeaguesModel, Error>
    func getLeagueWiseFixtures(id: Int, status: String) async -> Result<[MatchInfoModel], Error>
}


class FixturesRepository: FixtureMatchesListRepository,MatchDetailsRepository,DateWiseMatchRepository,LeagueWiseFixtureRepository{
    
    func getAllLeagues() async -> Result<LeaguesModel,Error> {
        let url = URLBuilder.shared.getAllLeaguesUrl()
        let result: Result<LeaguesModel,Error> = await ApiManager.shared.fetchDataFromApi(url: url)
        switch result{
        case .success(let leagueData):
            return .success(leagueData)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getDateWiseMatches(date : Date) async ->Result<[MatchInfoModel], Error> {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        let startDate = "\(dateString)T00:00:00.000Z"
        let endDate = "\(dateString)T23:59:59.000Z"
        
        let url = URLBuilder.shared.getDateWiseFixtureUrl(startDate: startDate, endDate: endDate)
        
        let result: Result<FixturesModel,Error> = await ApiManager.shared.fetchDataFromApi(url: url)
        
        switch result{
        case .success(let matchData):
            let adaptedData = MatchInfoAdapter.adapt(matchData)
            return .success(adaptedData)
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
    func getLeagueWiseFixtures(id: Int, status: String) async -> Result<[MatchInfoModel], Error> {
        let url = URLBuilder.shared.getFixtureByLeagueId(leagueId: id, status: status)
        let result: Result<FixturesModel,Error> = await ApiManager.shared.fetchDataFromApi(url: url)
        switch result{
        case .success(let matchData):
            let adaptedData = MatchInfoAdapter.adapt(matchData)
            return .success(adaptedData)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getMatchDetails(id: Int) async -> Result<MatchDetailsModel, Error> {
        let url = URLBuilder.shared.getMatchDetails(id: id)
        let data: Result<FixtureModel,Error> = await ApiManager.shared.fetchDataFromApi(url: url)
        switch data{
        case .success(let data):
            let matchDetails =  MatchDetailsAdepter.adapt(data)
            return.success(matchDetails)
        case .failure(let error):
            debugPrint(error)
            return .failure(error)
        }
    }
    
    func getFinishedMatches() async -> Result<[FinishedMatchesModel], Error> {
        let url = URLBuilder.shared.getFixturesURLForFinishedMatches()
        let data: Result<FixturesModel,Error> = await ApiManager.shared.fetchDataFromApi(url: url)
        switch data{
        case .success(let data):
            let finishedMatches = FinishedMatchAdepter.adapt(data)
            return.success(finishedMatches)
        case .failure(let error):
            debugPrint(error)
            return .failure(error)
        }
    }
    
    func getUpcomingMatches() async -> Result<[UpcomingMatchModel], Error>{
        let url = URLBuilder.shared.getFixturesURLForUpcomingMatches()
        let data: Result<FixturesModel,Error> = await ApiManager.shared.fetchDataFromApi(url: url)
        switch data{
        case .success(let data):
            let fixtureData = UpcomingMatchesAdapter.adapt(data)
            return.success(fixtureData)
        case .failure(let error):
            return .failure(error)
        }
    }
}

