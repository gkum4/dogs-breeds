import Foundation
import Networking

enum BreedDetailsEndpoint {
    case images(breedName: String)
}

extension BreedDetailsEndpoint: ApiEndpointProtocol {
    var baseURL: URL { apiBaseURL }
    
    var path: String {
        switch self {
        case .images(let breedName):
            return "/breed/\(breedName)/images"
        }
    }
}
