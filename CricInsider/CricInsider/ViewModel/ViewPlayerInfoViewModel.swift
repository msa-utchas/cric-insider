
import Foundation
import Combine

class ViewPlayerInfoViewModel{
    @Published var playerData: PlayerCareerModel?
    let playerCareerRepository: PlayerCareerRepository
    init(playerCareerRepository: PlayerCareerRepository = PlayersRepository()){
        self.playerCareerRepository = playerCareerRepository
    }
    
    func getPlayerData(id: Int) async{
        let result = await playerCareerRepository.getPlayerDetails(for: id)
        switch result{
            
        case .success(let data):
            playerData = data
        case .failure(let error):
            print(error)
        }
    }
}
