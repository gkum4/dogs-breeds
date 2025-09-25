import Foundation
import Networking

protocol BreedsListServicing {
    func fetchBreedsList() async -> ApiResult<BreedsList>
}

final class BreedsListService {
    private let api: ApiProtocol
    
    init(api: ApiProtocol = Api()) {
        self.api = api
    }
}

extension BreedsListService: BreedsListServicing {
    func fetchBreedsList() async -> ApiResult<BreedsList> {
        return await api.execute(endpoint: BreedsListEndpoint.listAll)
    }
}
