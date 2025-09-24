public enum ApiError: Error {
    case noConnection
    case malformedRequest
    case unknown(_ error: Error)
    case cancelled
    case notFound
    case serverError(code: Int)
    case decode(_ error: Error)
}
