import Foundation


class ApiManager {
    static let shared = ApiManager()
    private let cache = NSCache<NSString, NSData>()
    private init() {}

    func fetchDataFromApi<T: Decodable>(url: URL?) async -> Result<T, Error> {
        guard let url = url else {
            return .failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }

        if let cachedData = cache.object(forKey: url.absoluteString as NSString) as? Data {
            do {
                let resource = try JSONDecoder().decode(T.self, from: cachedData)
                print("Decode Successful (Cached)")
                return .success(resource)
            } catch {
                print("Error decoding cached data: \(error)")
            }
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let resource = try JSONDecoder().decode(T.self, from: data)
            print("Decode Successful (Network)")

            cache.setObject(data as NSData, forKey: url.absoluteString as NSString)

            return .success(resource)
        } catch {
            return .failure(error)
        }
    }
}
