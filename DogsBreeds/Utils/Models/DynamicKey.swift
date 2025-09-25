import Foundation

struct DynamicKey: CodingKey {
    var stringValue: String
    var intValue: Int? { nil }
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        return nil
    }
}
