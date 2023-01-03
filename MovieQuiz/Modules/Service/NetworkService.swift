import Foundation

protocol NetworkServiceDataProviderProtocol {
    func fetchJSON <T: Codable> (of type: T.Type, forResource name: String, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceDataProviderProtocol {
    func fetchJSON <T: Codable> (of type: T.Type, forResource name: String, completion: @escaping (Result<T, Error>) -> Void) {
        if let quizesURL = Bundle.main.url(forResource: name, withExtension: "json") {
            do {
                let data = try Data(contentsOf: quizesURL)
                let quizes = try JSONDecoder().decode(T.self, from: data)
                completion(.success(quizes))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
