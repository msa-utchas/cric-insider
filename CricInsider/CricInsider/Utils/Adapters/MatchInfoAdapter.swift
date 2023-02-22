//
//  MatchInfoAdapter.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 22/2/23.
//

import Foundation
class MatchInfoAdapter{
    static func adapt(_ fixturesModel: FixturesModel)->[MatchInfoModel]{
        guard let fixtures = fixturesModel.data else { return [] }
        
        var matchesInfo = [MatchInfoModel]()
        
        
        for fixture in fixtures {
            
            
            let formattedDateData = Date.formatDateTimeData(fixture.starting_at)
            
            let matchInfo = MatchInfoModel(
                fixtureId: fixture.id, status: fixture.status,
                leagueName: fixture.league?.name,
                seasonName: fixture.season?.name,
                round: fixture.round,
                date: formattedDateData?.0,
                time: formattedDateData?.1,
                localTeamName: fixture.localteam?.code,
                visitorTeamName: fixture.visitorteam?.code,
                localTeamImagePath: fixture.localteam?.image_path,
                visitorTeamImagePath: fixture.visitorteam?.image_path,
                dateObject: formattedDateData?.2,
                matchType: fixture.type,
                note: fixture.note
                
            )
            matchesInfo.append(matchInfo)
        }
        return matchesInfo
    }
}



struct MatchInfoModel{
    
    let fixtureId: Int?
    let status: String?
    let leagueName: String?
    let seasonName: String?
    let round: String?
    let date: String?
    let time: String?
    let localTeamName: String?
    let visitorTeamName: String?
    let localTeamImagePath: String?
    let visitorTeamImagePath: String?
    let dateObject: Date?
    let matchType: String?
    let note: String?
    
    
}

