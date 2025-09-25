import Foundation

struct BreedsList: Decodable, Equatable {
    let breeds: [BreedListItem]
    let status: String
    
    enum CodingKeys: CodingKey {
        case message
        case status
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try container.decode(String.self, forKey: .status)
        
        let nestedContainer = try container.nestedContainer(keyedBy: DynamicKey.self, forKey: .message)
        self.breeds = try nestedContainer.allKeys.map {
            .init(name: $0.stringValue,
                  subBreeds: try nestedContainer.decode([String].self, forKey: $0))
        }
    }
}

extension BreedsList {
    struct BreedListItem: Equatable {
        let name: String
        let subBreeds: [String]
    }
}
