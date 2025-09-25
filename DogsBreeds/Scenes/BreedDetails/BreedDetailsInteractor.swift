protocol BreedDetailsInteracting {}

final class BreedDetailsInteractor {
    private let presenter: BreedDetailsPresenting
    private let service: BreedDetailsServicing
    private let asyncTask: AsyncTaskProtocol
    private let breed: BreedsList.BreedListItem
    
    init(presenter: BreedDetailsPresenting,
         service: BreedDetailsServicing,
         asyncTask: AsyncTaskProtocol = AsyncTask(),
         breed: BreedsList.BreedListItem) {
        self.presenter = presenter
        self.service = service
        self.asyncTask = asyncTask
        self.breed = breed
    }
}

extension BreedDetailsInteractor: BreedDetailsInteracting {}
