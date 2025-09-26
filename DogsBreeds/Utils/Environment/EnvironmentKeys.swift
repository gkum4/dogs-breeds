import Foundation

enum EnvironmentKeys {
    case dogBaseURL
}

extension EnvironmentKeys {
    func getKey() -> String {
        let key: String
        switch self {
        case .dogBaseURL:
            key = "DOG_BASE_URL"
        }
        
        guard let value = ProcessInfo.processInfo.environment[key] else {
            fatalError("DOG_BASE_URL should be defined as a Environment Variable")
        }
        
        return value
    }
}
