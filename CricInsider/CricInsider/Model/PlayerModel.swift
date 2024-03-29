
import Foundation

struct PlayerModel: Codable {
    let data: Player?
}

struct Player: Codable{
    let resource: String?
    let id, country_id: Int?
    let firstname, lastname, fullname: String?
    let image_path: String?
    let dateofbirth: String?
    let gender: String?
    let battingstyle: String?
    let bowlingstyle: String?
    let position: Position?
    let updatedAt: String?
    let lineup : Lineup?
    let country: Country?
    let career: [Career]?
}

struct Lineup: Codable {
    let team_id: Int?
    let captain, wicketkeeper, substitution: Bool?
}

struct Position: Codable {
    let resource: String?
    let id: Int?
    let name: String?
}

struct Country:Codable {
    let resource: String?
    let id, continent_id: Int?
    let name: String?
    let image_path: String?
    let updatedAt: String?
}

struct Career: Codable{
    struct Bowling: Codable {
        let matches: Int?
        let overs: Double?
        let innings: Int?
        let econ_rate: Double?
        let runs: Int?
        let wickets: Int?
    }
    struct  Batting: Codable {
        let matches: Int?
        let innings: Int?
        let runs_scored: Int?
        let strike_rate: Double?
        let balls_faced: Double?
        let average: Double?
    }
    
    let type: String?
    let bowling: Bowling?
    let batting: Batting?
}




