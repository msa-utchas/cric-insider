
import Foundation

class PlayerCareerAdepter {
    static func adapt(player: PlayerModel) -> PlayerCareerModel{
        
        let playerData = player.data
        let playerCareer = playerData?.career ?? []
        
        let playerCareerModel = PlayerCareerModel(
            id: playerData?.id,
            fullname: playerData?.fullname,
            image_path: playerData?.image_path,
            dateofbirth: playerData?.dateofbirth,
            battingstyle: playerData?.battingstyle,
            bowlingstyle: playerData?.bowlingstyle,
            position: playerData?.position,
            lineup: playerData?.lineup,
            country: playerData?.country,
            t20Career: analyzeCareerData(career: playerCareer, type: "T20"),
            odiCareer: analyzeCareerData(career: playerCareer, type: "ODI"),
            testCareer: analyzeCareerData(career: playerCareer, type: "Test/5day"),
            t20iCareer: analyzeCareerData(career: playerCareer, type: "T20I")
        )
        return playerCareerModel
    }
    
    static func analyzeCareerData(career: [Career], type: String) -> Career {
        var matchesBating = 0
        var inningsBating = 0
        var runs_scored = 0
        var strike_rate = 0.0
        var balls_faced = 0.0
        var average = 0.0
        var matchesBowling = 0
        var inningsBowling = 0
        var overs = 0.0
        var econ_rate = 0.0
        var runs = 0
        var wickets = 0
        
        for career in career {
            if career.type == type {
                if career.batting != nil {
                    matchesBating += career.batting?.matches ?? 0
                    inningsBating += career.batting?.innings ?? 0
                    runs_scored += career.batting?.runs_scored ?? 0
                    // strike_rate += career.batting?.strike_rate ?? 0.0
                    balls_faced += career.batting?.balls_faced ?? 0.0
                    // average += career.batting?.average ?? 0.0
                }
                if career.bowling != nil {
                    matchesBowling += career.bowling?.matches ?? 0
                    inningsBowling += career.bowling?.innings ?? 0
                    overs += career.bowling?.overs ?? 0.0
                    // econ_rate += career.bowling?.econ_rate ?? 0.0
                    runs += career.bowling?.runs ?? 0
                    wickets += career.bowling?.wickets ?? 0
                }
            }
        }
        

        strike_rate = (Double(runs_scored) / balls_faced) * 100
        average = Double(runs_scored) / Double(inningsBating)
        econ_rate = Double(runs) / overs
        
        let careerModel = Career(
            type: type,
            bowling: Career.Bowling(
                matches: matchesBowling,
                overs: overs,
                innings: inningsBowling,
                econ_rate: econ_rate,
                runs: runs,
                wickets: wickets
            ),
            batting: Career.Batting(
                matches: matchesBating,
                innings: inningsBating,
                runs_scored: runs_scored,
                strike_rate: strike_rate,
                balls_faced: balls_faced,
                average: average
            )
        )
        
        return careerModel
    }
}

struct PlayerCareerModel: Codable {
    let id: Int?
    let fullname: String?
    let image_path: String?
    let dateofbirth: String?
    let battingstyle: String?
    let bowlingstyle: String?
    let position: Position?
    let lineup: Lineup?
    let country: Country?
    let t20Career: Career?
    let odiCareer: Career?
    let testCareer: Career?
    let t20iCareer: Career?
}
