import Foundation
struct FixtureModel:Codable {
    let data: Fixture
}

struct Fixture: Codable {
    let resource: String?
    let id, league_id, season_id, stage_id: Int?
    let round: String?
    let localteam_id, visitorteam_id: Int?
    let starting_at: String?
    let type: String?
    let live: Bool?
    let status: String?
    let last_period: String?
    let note: String?
    let venue_id: Int?
    let toss_won_team_id, winner_team_id: Int?
    let draw_noresult: String?
    let first_umpire_id: Int?
    let second_umpire_id, tv_umpire_id: Int?
    let referee_id: Int?
    let man_of_match_id: Int?
    let man_of_series_id: Int?
    let total_overs_played: Double?
    let elected: String?
    let super_over, follow_on: Bool?
    let localteam_dl_data, visitorteam_dl_data: TeamDLData?
    let rpc_overs, rpc_target: String?
    let localteam, visitorteam: Team?
    let runs: [Run]?
    let lineup: [Player]?
    let league: League?
    let winnerteam: Team?
    let season: Season?
    let stage: Stage?
    let bowling: [Bowling]?
    let batting: [Batting]?
    let manofmatch: Player?
    let venue: Venue?

}



struct TeamDLData: Codable {
    let score, overs, wicketsOut: String?
    let totalOversPlayed: String?
}

struct Team :Codable{
    let resource: String?
    let id: Int?
    let name: String?
    let code: String?
    let image_path: String?
    let country_id: Int?
    let national_team: Bool?
    let updated_at: String?
}
// MARK: - Run
struct Run: Codable {
    let resource: String
    let id, fixture_id, team_id, inning: Int?
    let score, wickets: Int?
    let overs: Double?
    let pp1: String?
    let pp2, pp3: String?
    let updated_at: String?
}

// MARK: - League
struct League: Codable {
    let resource: String
    let id, season_id, country_id: Int?
    let name: String?
    let code: String?
    let image_path: String?
    let type: String?
    let updated_at: String?
}

// MARK: - Season
struct Season: Codable {
    let resource: String?
    let id, league_id: Int?
    let name, code: String?
    let updated_at: String?
}
struct Stage: Codable {
    let resource: String?
    let id, league_id, season_id: Int?
    let name: String?
    let code: String?
    let type: String?
    let standings: Bool?
    let updated_at: String?
}

//make struct for bowling
struct Bowling:Codable {
    let resource: String?
    let id, sort, fixture_id, team_id: Int?
    let active: Bool?
    let scoreboard: String?
    let player_id: Int?
    let overs: Double?
    let medians: Int?
    let runs: Int?
    let wickets: Int?
    let wide, noball: Int?
    let rate: Double?
    let updated_at: String?
    let bowler: Player?
}


struct Batting:Codable {
    let resource: String?
    let id, sort, fixture_id, team_id: Int?
    let active: Bool?
    let scoreboard: String?
    let player_id: Int?
    let ball: Int?
    let score_id: Int?
    let score: Int?
    let four_x, six_x: Int?
    let catch_stump_player_id: Int?
    let runout_by_id: Int?
    let batsmanout_id: Int?
    let bowling_player_id: Int?
    let fow_score: Int?
    let fow_balls: Double?
    let rate: Int?
    let updated_at: String?
    let batsman: Player?
}

//"venue": {
//    "resource": "venues",
//    "id": 13,
//    "country_id": 98,
//    "name": "Brisbane Cricket Ground",
//    "city": "Woolloongabba,  Brisbane, Queensland",
//    "image_path": "https://cdn.sportmonks.com/images/cricket/venues/13/13.png",
//    "capacity": 37000,
//    "floodlight": true,
//    "updated_at": "2018-11-14T14:16:53.000000Z"
//}
//make struct for venue
struct Venue:Codable {
    let resource: String?
    let id, country_id: Int?
    let name, city: String?
    let image_path: String?
    let capacity: Double?
    let floodlight: Bool?
    let updated_at: String?
}
