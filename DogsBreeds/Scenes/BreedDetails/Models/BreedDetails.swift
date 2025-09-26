import Foundation

struct BreedDetails: Decodable, Equatable {
    let images: [String]
    let status: String
    
    enum CodingKeys: CodingKey {
        case message
        case status
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.images = try container.decode([String].self, forKey: .message)
        self.status = try container.decode(String.self, forKey: .status)
    }
    
    #if DEBUG
    init(images: [String], status: String) {
        self.images = images
        self.status = status
    }
    #endif
}
