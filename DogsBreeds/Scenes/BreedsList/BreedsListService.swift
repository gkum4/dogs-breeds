import Foundation
import Networking

protocol BreedsListServicing {
    func fetchBreedsList() async -> ApiResult<BreedsList>
}

final class BreedsListService {
    typealias Dependencies = HasApi
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension BreedsListService: BreedsListServicing {
    func fetchBreedsList() async -> ApiResult<BreedsList> {
        return await dependencies.api.execute(endpoint: BreedsListEndpoint.listAll)
    }
}
