import Foundation
import Combine

class MatchDetailsViewModel: ObservableObject {
    
    private var matchDetailsRepository: MatchDetailsRepository
    static let shared = MatchDetailsViewModel()
    var matchID: Int?
    
    @Published var matchDetails: MatchDetailsModel?
    @Published var selectedPlayerId: Int?
    
    init(matchDetailsRepository: MatchDetailsRepository =  FixturesRepository()) {
        self.matchDetailsRepository = matchDetailsRepository
    }

    func setMatchDetails(id: Int) async {
        let data = await matchDetailsRepository.getMatchDetails(id: id)
        switch data{
        case .success(let matchData):
            matchDetails = matchData
        case .failure(let error):
            print(error.localizedDescription)
        
        }
    }
    
    func setSelectedPlayerId(playerId: Int){
        selectedPlayerId = playerId
    }
    
}
