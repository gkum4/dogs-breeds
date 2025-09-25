@testable import DogsBreeds

extension BreedsList {
    static func fixture(
        breeds: [BreedListItem] = [
            .fixture(),
            .fixture(name: "australian", subBreeds: ["kelpie", "shepherd"])
        ],
        status: String = "Success"
    ) -> Self {
        .init(breeds: breeds, status: status)
    }
}

extension BreedsList.BreedListItem {
    static func fixture(name: String = "Akita", subBreeds: [String] = []) -> Self {
        .init(name: name, subBreeds: subBreeds)
    }
}
