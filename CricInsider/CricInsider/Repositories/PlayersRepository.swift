//
//  PlayersRepository.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 19/2/23.
//

import Foundation
import CoreData

protocol SearchPlayerDataRepository{
    func fuzzySearchPlayerData(searchText: String) async -> Result<[PlayersInfo], Error>
    func checkPlayerAvailabilityInCoreData()->[PlayersInfo]
    func savePlayerData(playerInfo: PlayersModel) async -> Result<Bool, Error>
    func getAllPlayers() async -> Result<PlayersModel,Error>
}

protocol PlayerCareerRepository{
    func getPlayerDetails(for id: Int) async -> Result<PlayerCareerModel,Error>
}

class PlayersRepository: SearchPlayerDataRepository, PlayerCareerRepository{
    
    private let privateContext = CoreDataManager.shared.privateContext
    private let context = CoreDataManager.shared.context
    
    func checkPlayerAvailabilityInCoreData()->[PlayersInfo]  {
        var playersInfo: [PlayersInfo] = []
        do {
            try privateContext.performAndWait {[weak self] in
                guard let self = self else {return}
                let fetchRequest = NSFetchRequest<PlayersInfo>(entityName: "PlayersInfo")
                playersInfo = try self.privateContext.fetch(fetchRequest)
            }
            
        } catch {
            debugPrint(error)
        }
        return playersInfo
    }
    
    func fuzzySearchPlayerData(searchText: String) async -> Result<[PlayersInfo], Error> {
        do {
            var result: [PlayersInfo] = []
            try await privateContext.perform {[weak self] in
                guard let self = self else {return}
                let fetchRequest = NSFetchRequest<PlayersInfo>(entityName: "PlayersInfo")
                fetchRequest.predicate = NSPredicate(format: "fullName CONTAINS[cd] %@", searchText)
                result = try self.privateContext.fetch(fetchRequest)
            }
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func getAllPlayers() async -> Result<PlayersModel,Error>{
        let url =  URLBuilder.shared.getPlayersURL()
        let data: Result<PlayersModel,Error> = await ApiManager.shared.fetchDataFromApi(url: url)
        return data
    }
    
    func savePlayerData(playerInfo: PlayersModel) async -> Result<Bool, Error>{
        let deleteResult = deleteAllData()
        switch deleteResult{
        case .success(let flag):
            print("Data deleted successfully: \(flag)")
            do {
                try privateContext.performAndWait {[weak self] in
                    guard let self = self else {return}
                    for player in playerInfo.data! {
                        let playerData = PlayersInfo(context: self.privateContext)
                        playerData.id = Int32(player.id ?? 0)
                        playerData.fullName = player.fullname ?? "Not Available"
                        playerData.imagePath = player.image_path  ?? "Not Available"
                        playerData.country = player.country?.name ?? "Not Available"
                    }
                    try self.privateContext.save()
                    try self.context.save()
                }
                return .success(true)
            } catch {
                return .failure(error)
            }
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func deleteAllData() -> Result<Bool, Error> {
        do {
            try  privateContext.performAndWait {[weak self] in
                guard let self = self else {return}
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayersInfo")
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                try self.privateContext.execute(deleteRequest)
                try self.privateContext.save()
                try self.context.save()
            }
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func getPlayerDetails(for id: Int) async -> Result<PlayerCareerModel,Error>{
        let url = URLBuilder.shared.getPlayerURL(playerID: id)
        let result: Result<PlayerModel,Error> = await ApiManager.shared.fetchDataFromApi(url: url)
        switch result{
            
        case .success(let data):
            let careerInfo = PlayerCareerAdepter.adapt(player: data)
            return .success(careerInfo)
            
        case .failure(let error):
            return .failure(error)
        }
    }
}
