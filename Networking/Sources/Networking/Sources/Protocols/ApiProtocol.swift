import Foundation

public protocol HasApi {
    var api: ApiProtocol { get }
}

public protocol ApiProtocol {
    func execute<T: Decodable>(endpoint: ApiEndpointProtocol,
                               decoder: JSONDecoder) async -> Result<T, ApiError>
}

public extension ApiProtocol {
    func execute<T: Decodable>(endpoint: ApiEndpointProtocol) async -> Result<T, ApiError> {
        await execute(endpoint: endpoint, decoder: JSONDecoder())
    }
}
