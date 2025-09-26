import Networking

protocol BreedDetailsServicing {
    func fetchBreedDetails(for breedName: String) async -> ApiResult<BreedDetails>
}

final class BreedDetailsService {
    typealias Dependencies = HasApi
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension BreedDetailsService: BreedDetailsServicing {
    func fetchBreedDetails(for breedName: String) async -> ApiResult<BreedDetails> {
        let endpoint = BreedDetailsEndpoint.images(breedName: breedName)
        return await dependencies.api.execute(endpoint: endpoint)
    }
}
