import Foundation
import Networking

public final class ApiSpy: ApiProtocol {
    public init() {}
    
    public var executeCalls: [(endpoint: Networking.ApiEndpointProtocol, decoder: JSONDecoder)] = []
    public var executeResult: Result<Any, Networking.ApiError>?
    
    public func execute<E: Decodable>(endpoint: Networking.ApiEndpointProtocol,
                                      decoder: JSONDecoder) async -> Result<E, Networking.ApiError> {
        executeCalls.append((endpoint, decoder))
        return (executeResult as? Result<E, Networking.ApiError>) ?? .failure(.malformedRequest)
    }
}
