protocol BreedDetailsInteracting {}

final class BreedDetailsInteractor {
    private let presenter: BreedDetailsPresenting
    private let service: BreedDetailsServicing
    private let asyncTask: AsyncTaskProtocol
    private let breedName: String
    
    init(presenter: BreedDetailsPresenting,
         service: BreedDetailsServicing,
         asyncTask: AsyncTaskProtocol = AsyncTask(),
         breedName: String) {
        self.presenter = presenter
        self.service = service
        self.asyncTask = asyncTask
        self.breedName = breedName
    }
}

extension BreedDetailsInteractor: BreedDetailsInteracting {}
