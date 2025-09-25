protocol BreedDetailsInteracting {}

final class BreedDetailsInteractor {
    private let presenter: BreedDetailsPresenting
    private let service: BreedDetailsServicing
    private let asyncTask: AsyncTaskProtocol
    
    init(presenter: BreedDetailsPresenting,
         service: BreedDetailsServicing,
         asyncTask: AsyncTaskProtocol = AsyncTask()) {
        self.presenter = presenter
        self.service = service
        self.asyncTask = asyncTask
    }
}

extension BreedDetailsInteractor: BreedDetailsInteracting {}
