import Networking

protocol BreedDetailsServicing {}

final class BreedDetailsService {
    private let api: ApiProtocol
    
    init(api: ApiProtocol = Api()) {
        self.api = api
    }
}

extension BreedDetailsService: BreedDetailsServicing {}
