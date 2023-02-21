import Foundation


class ApiManager{
    static let shared = ApiManager()
    private init() {}
    
    func fetchDataFromApi<T: Decodable>(url: URL?) async -> Result<T, Error> {
        guard let url = url else {
            return .failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }
        // write NSCache to cache the api response
//        if let cachedResponse = cache.object(forKey: url.absoluteString as NSString) {
//            completion(cachedResponse as Data, nil)
//            return
//        }



        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let resource = try JSONDecoder().decode(T.self, from: data)
            print("Decode Successful")
    
            return .success(resource)
        } catch {
            return .failure(error)
        }
    }
}
