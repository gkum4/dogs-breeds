@testable import DogsBreeds
import Foundation
import Testing

struct BreedsListTests {
    @Test
    func decode() throws {
        let data = try #require("""
        {
            "message": {
                "affenpinscher": [],
                "african": [
                    "wild"
                ],
                "airedale": [],
                "akita": [],
                "appenzeller": [],
                "australian": [
                    "kelpie",
                    "shepherd"
                ]
            },
            "status": "success"
        }
        """.data(using: .utf8))
        let decoded = try JSONDecoder().decode(BreedsList.self, from: data)
        
        let expectedBreeds: [BreedsList.BreedListItem] = [
            .init(name: "affenpinscher", subBreeds: []),
            .init(name: "african", subBreeds: ["wild"]),
            .init(name: "airedale", subBreeds: []),
            .init(name: "akita", subBreeds: []),
            .init(name: "appenzeller", subBreeds: []),
            .init(name: "australian", subBreeds: ["kelpie", "shepherd"])
        ]
        expectedBreeds.forEach { #expect(decoded.breeds.contains($0)) }
        #expect(decoded.status == "success")
    }
}
