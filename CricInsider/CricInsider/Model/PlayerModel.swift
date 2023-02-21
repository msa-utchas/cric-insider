
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
    let imagep_path: String?
    let updatedAt: String?
}




