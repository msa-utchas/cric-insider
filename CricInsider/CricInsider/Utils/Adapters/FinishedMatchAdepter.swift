//
//  RecentMatchAdepter.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 18/2/23.
//

import Foundation

class FinishedMatchAdepter {
    static func adapt(_ fixturesModel: FixturesModel) -> [FinishedMatchesModel] {
        guard let fixtures = fixturesModel.data else { return [] }
        var localTeamRuns: Run?
        var VisitorTeamRuns: Run?
        var recentMatches = [FinishedMatchesModel]()
        
        for fixture in fixtures {
            
            let formattedDateData = Date.formatDateTimeData(fixture.starting_at)
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
            let recentMatch = FinishedMatchesModel(
                fixtureId: fixture.id,
                status: fixture.status,
                leagueName: fixture.league?.name,
                seasonName: fixture.season?.name,
                round: fixture.round,
                localTeam: fixture.localteam,
                visitorTeam: fixture.visitorteam,
                localTeamRun: localTeamRuns,
                visitorTeamRun: VisitorTeamRuns,
                note: fixture.note,
                date: formattedDateData?.0,
                time: formattedDateData?.1,
                matchType: fixture.type
            )
            recentMatches.append(recentMatch)
        }
        return recentMatches
    }
}

struct FinishedMatchesModel{
    let fixtureId: Int?
    let status: String?
    let leagueName: String?
    let seasonName: String?
    let round: String?
    let localTeam : Team?
    let visitorTeam : Team?
    let localTeamRun: Run?
    let visitorTeamRun: Run?
    let note: String?
    let date: String?
    let time: String?
    let matchType: String?
}

