@testable import DogsBreeds

extension BreedDetails {
    static func fixture(
        images: [String] = [
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg",
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg",
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_10822.jpg"
        ],
        status: String = "Success"
    ) -> Self {
        .init(images: images, status: status)
    }
}
