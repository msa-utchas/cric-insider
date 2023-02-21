import Foundation
import Combine

class MatchDetailsViewModel: ObservableObject {
    private var matchDetailsRepository: MatchDetailsRepository
    static let shared = MatchDetailsViewModel()
    @Published var matchDetails: MatchDetailsModel?
    
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
    
}
