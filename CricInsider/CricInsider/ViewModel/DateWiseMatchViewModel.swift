import Foundation

class DateWiseMatchViewModel{
    @Published var matchData: [MatchInfoModel]?
    var dateWiseMatchRepository: DateWiseMatchRepository
    @Published var selectedMatch: MatchInfoModel?
    
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
    func setSelectedMatch(matchInfo: MatchInfoModel){
        selectedMatch = matchInfo
    }
}
