//
//  SearchPlayerViewModel.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 19/2/23.
//


import Foundation
import Combine

class SearchPlayerViewModel {
    let searchPlayerDataRepository: SearchPlayerDataRepository
    @Published var playerList: [PlayersInfo] = []
    
    init(searchPlayerDataRepository: SearchPlayerDataRepository = PlayersRepository()) {
        self.searchPlayerDataRepository = searchPlayerDataRepository
    }
    func callApiAndSaveDataIfNeeded() async{
        let count = searchPlayerDataRepository.checkPlayerAvailabilityInCoreData()
        if (count < 1){
            let data = await searchPlayerDataRepository.getAllPlayers()
            switch data{
            case .success(let playersData):
                await savePlayerToCoreData(data: playersData)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func performSearch(searchText: String) async{
        let result = await searchPlayerDataRepository.fuzzySearchPlayerData(searchText: searchText)
        
        switch result{
        case .success(let data):
            playerList = data
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    private func savePlayerToCoreData(data: PlayersModel) async{
        let result =  await searchPlayerDataRepository.savePlayerData(playerInfo: data)
        switch result{
        case .success(_):
            print("Save Successful in core Data")
            
        case .failure(let error):
            debugPrint(error)
        }
    }
}

