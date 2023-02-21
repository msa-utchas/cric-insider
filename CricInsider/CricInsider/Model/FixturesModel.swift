import Foundation

struct FixturesModel: Codable {
    let data: [Fixture]?
    let links: Links?
    let meta: Meta?
}

struct Links: Codable {
    let first, last: String?
    let prev: String?
    let next: String?
}

struct Meta: Codable {
    let currentPage, from, lastPage: Int?
    let links: [Link]?
    let path: String?
    let perPage, to, total: Int?
}

struct Link: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}


