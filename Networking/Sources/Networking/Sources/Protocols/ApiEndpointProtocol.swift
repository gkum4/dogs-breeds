import Foundation

public protocol ApiEndpointProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var timeout: Float { get }
    var body: Data? { get }
    var shouldAppendBody: Bool { get }
    var parameters: [String: String] { get }
    var customHeaders: [String: String] { get }
    var contentType: ContentType { get }
}

public extension ApiEndpointProtocol {
    var method: HTTPMethod { .get }
    
    var body: Data? { nil }
    
    var shouldAppendBody: Bool { method != .get && method != .delete && body != nil }
    
    var timeout: Float { 20 }
    
    var parameters: [String: String] { [:] }
    
    var customHeaders: [String: String] { [:] }
    
    var absoluteURLString: String {
        let baseURLString = baseURL.absoluteString
        let safeBaseURLString = baseURLString.hasSuffix("/") ? String(baseURLString.dropLast()) : baseURLString
        let safePath = path.starts(with: "/") || path.isEmpty ? path : "/\(path)"
        return "\(safeBaseURLString)\(safePath)"
    }
    
    var contentType: ContentType { .applicationJson }
}
