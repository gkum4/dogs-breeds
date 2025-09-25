import Foundation
import Networking

enum BreedsListEndpoint {
    case listAll
}

extension BreedsListEndpoint: ApiEndpointProtocol {
    var baseURL: URL { apiBaseURL }

    var path: String {
        switch self {
        case .listAll:
            return "/breeds/list/all"
        }
    }
}
