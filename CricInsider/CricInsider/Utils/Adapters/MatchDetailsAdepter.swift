//
//  MatchDetailsAdepter.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 19/2/23.
//


import Foundation
class MatchDetailsAdepter{
    static func adapt(_ fixtureModel: FixtureModel) -> MatchDetailsModel {
        var localTeamSquad : [Player] = []
        var visitorTeamSquad : [Player] = []
        var localTeamBowling : [Bowling] = []
        var visitorTeamBowling : [Bowling] = []
        var localTeamBatting : [Batting] = []
        var visitorTeamBatting : [Batting] = []
        var localTeamRuns: Run?
        var VisitorTeamRuns: Run?
        
        let fixture = fixtureModel.data
        if let runs = fixture.runs {
            if runs.count == 1 {
                if fixture.localteam_id == runs[0].team_id {
                    localTeamRuns = runs[0]
                } else {
                    VisitorTeamRuns = runs[0]
                }
            } else if runs.count >= 2 {
                if fixture.localteam_id == runs[0].team_id {
                    localTeamRuns = runs[0]
                    VisitorTeamRuns = runs[1]
                } else {
                    localTeamRuns = runs[1]
                    VisitorTeamRuns = runs[0]
                }
            }
        }
        
        if let players = fixtureModel.data.lineup{
            for player in players{
                if (fixtureModel.data.localteam_id == player.lineup?.team_id){
                    localTeamSquad.append(player)
                }
                else{
                    visitorTeamSquad.append(player)
                }
            }
        }
        if let bowling = fixtureModel.data.bowling{
            for player in bowling{
                if (fixtureModel.data.localteam_id == player.team_id){
                    localTeamBowling.append(player)
                }
                else{
                    visitorTeamBowling.append(player)
                }
            }
        }
        if let batting = fixtureModel.data.batting{
            for player in batting{
                if (fixtureModel.data.localteam_id == player.team_id){
                    localTeamBatting.append(player)
                }
                else{
                    visitorTeamBatting.append(player)
                }
            }
        }
        
        return MatchDetailsModel(
            localTeamName: fixtureModel.data.localteam?.name,
            visitorTeamName: fixtureModel.data.visitorteam?.name,
            localTeamSquad: localTeamSquad,
            VisitorTeamSquad: visitorTeamSquad,
            localTeamBowling: localTeamBowling,
            visitorTeamBowling: visitorTeamBowling,
            localTeamBatting: localTeamBatting,
            visitorTeamBatting: visitorTeamBatting,
            leagueName: fixtureModel.data.league?.name,
            season: fixtureModel.data.season?.name,
            localTeamImage: fixtureModel.data.localteam?.image_path,
            visitorTeamImage: fixtureModel.data.visitorteam?.image_path,
            localTeamRun: localTeamRuns, visitorTeamRun: VisitorTeamRuns
            
            
            
        )
    }
    
}
struct MatchDetailsModel{
    let localTeamName: String?
    let visitorTeamName: String?
    let localTeamSquad: [Player]?
    let VisitorTeamSquad: [Player]?
    let localTeamBowling: [Bowling]?
    let visitorTeamBowling: [Bowling]?
    let localTeamBatting: [Batting]
    let visitorTeamBatting: [Batting]
    let leagueName: String?
    let season: String?
    let localTeamImage: String?
    let visitorTeamImage: String?
    let localTeamRun: Run?
    let visitorTeamRun: Run?
    
    
   
    
    
    
}
