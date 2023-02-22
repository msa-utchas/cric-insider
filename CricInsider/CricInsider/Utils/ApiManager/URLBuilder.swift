
import Foundation
class URLBuilder {
    //ICTEnAzbmSy2cjmU392cgNuyriPZ19WIOFctfQP6NI3d6UFQEB9TBfZG3pEc
    let baseURL = "https://cricket.sportmonks.com/api/v2.0"
    //let apiToken: String = "h0J6t9SxB02l6U0nRmOiagSZmymozNYQ7GFaTAwmiJ5gSFwIDUC3JJpjtwg7"
    //let apiToken: String = "11xEeZHm5pQSsuUxi6n4JbD1zxY3RYmAHbVKYtZFTP2QqrsXxeB5zxEydna8"
    static let shared = URLBuilder()
    let apiToken: String = "ICTEnAzbmSy2cjmU392cgNuyriPZ19WIOFctfQP6NI3d6UFQEB9TBfZG3pEc"
    

    private init() {}

    func getPlayerURL(playerID: Int) -> URL? {
        let endpoint = "/players/\(playerID)"
        let queryItems = [URLQueryItem(name: "api_token", value: apiToken)]
        return createURL(endpoint: endpoint, queryItems: queryItems)
    }

    func getPlayersURL() -> URL? {
        let endpoint = "/players"
        let queryItems = [
            URLQueryItem(name: "include", value: "country"),
            URLQueryItem(name: "fields[players]", value: "fullname,image_path"),
            URLQueryItem(name: "api_token", value: apiToken)
        ]
        return createURL(endpoint: endpoint, queryItems: queryItems)
    }

    func getFixturesURL() -> URL? {
        let endpoint = "/fixtures"
        let queryItems = [
            URLQueryItem(name: "include", value: "winnerteam,localteam,visitorteam,stage,season,league,runs,lineup"),
            URLQueryItem(name: "api_token", value: apiToken)
        ]
        return createURL(endpoint: endpoint, queryItems: queryItems)
    }
    func getFixturesURLForUpcomingMatches() -> URL? {
        let endpoint = "/fixtures"
        let queryItems = [
            URLQueryItem(name: "include", value: "winnerteam,localteam,visitorteam,stage,season,league,runs,lineup"),
            URLQueryItem(name: "filter[status]", value: "NS,1st Innings,2nd Innings,3rd Innings,4th Innings"),
            URLQueryItem(name: "sort", value: "starting_at"),
            URLQueryItem(name: "api_token", value: apiToken)
        ]
        return createURL(endpoint: endpoint, queryItems: queryItems)
    }
    func getFixturesURLForFinishedMatches() -> URL? {
        let endpoint = "/fixtures"
        let queryItems = [
            URLQueryItem(name: "include", value: "localteam,visitorteam,runs,league,season"),
            URLQueryItem(name: "filter[status]", value: "Finished"),
            URLQueryItem(name: "sort", value: "-starting_at"),
            URLQueryItem(name: "api_token", value: apiToken)
        ]
        return createURL(endpoint: endpoint, queryItems: queryItems)
    }
    
    
    
    
    
    
    
    
    func getMatchDetails(id : Int) -> URL? {
        let endpoint = "/fixtures/\(id)"
        let queryItems = [
            URLQueryItem(name: "include", value: "lineup,bowling.bowler,batting.batsman,localteam,visitorteam,runs,league,season,venue,manofmatch"),
            URLQueryItem(name: "api_token", value: apiToken)
        ]
        return createURL(endpoint: endpoint, queryItems: queryItems)
    }
    
    
    
    
    
    
    
    private func createURL(endpoint: String, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents(string: baseURL + endpoint)
        components?.queryItems = queryItems
        return components?.url
    }
    
    func createAllPlayerListUrl() -> URL?{
        let endpoint = "/fixtures"
        let queryItems = [
            URLQueryItem(name: "fields[players]", value: "fullname,image_path"),
            URLQueryItem(name: "include", value: "country"),
            URLQueryItem(name: "api_token", value: apiToken)
        ]
        return createURL(endpoint: endpoint, queryItems: queryItems)
    }
    
}
