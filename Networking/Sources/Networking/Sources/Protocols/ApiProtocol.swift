import Foundation

public protocol ApiProtocol {
    func execute<T: Decodable>(endpoint: ApiEndpointProtocol,
                               decoder: JSONDecoder) async -> Result<T, ApiError>
}
