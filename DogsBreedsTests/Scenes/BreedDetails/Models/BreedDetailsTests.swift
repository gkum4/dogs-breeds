@testable import DogsBreeds
import Foundation
import Testing

struct BreedDetailsTests {
    @Test
    func decode() throws {
        let data = try #require("""
        {
            "message": [
                "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
                "https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg",
                "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg",
                "https://images.dog.ceo/breeds/hound-afghan/n02088094_10822.jpg"
            ],
            "status": "success"
        }
        """.data(using: .utf8))
        let decoded = try JSONDecoder().decode(BreedDetails.self, from: data)
        
        #expect(decoded.images == [
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg",
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg",
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_10822.jpg"
        ])
        #expect(decoded.status == "success")
    }
}
