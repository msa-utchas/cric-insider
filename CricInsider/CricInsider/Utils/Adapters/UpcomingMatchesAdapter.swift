import Foundation
class UpcomingMatchesAdapter {
    
    static func adapt(_ fixturesModel: FixturesModel) -> [UpcomingMatchModel] {
        guard let fixtures = fixturesModel.data else { return [] }
        var upcomingMatches = [UpcomingMatchModel]()
        
        var count = 0
        
        for fixture in fixtures {
            
            if count > 6{
                break
            }
            count += 1
            
            let formattedDateData = Date.formatDateTimeData(fixture.starting_at)
            
            let upcomingMatch = UpcomingMatchModel(
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
                dateObject: formattedDateData?.2, matchType: fixture.type
            )
            upcomingMatches.append(upcomingMatch)
        }
        return upcomingMatches
    }
}

struct UpcomingMatchModel{
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
}
