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

protocol  FixtureMatchesListRepository: UpcomingMatchesFixturesRepository,FinishedMatchesFixtureRepository{
    
}
class FixturesRepository: FixtureMatchesListRepository,MatchDetailsRepository{
    
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
