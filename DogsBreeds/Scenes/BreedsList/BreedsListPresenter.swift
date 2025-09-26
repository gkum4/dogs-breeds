import Networking

protocol BreedsListPresenting {
    func startLoading() async
    func stopLoading() async
    func presentBreedsList(_ breedsList: [BreedsList.BreedListItem]) async
    func presentErrorState(for error: ApiError) async
    func presentBreedDetails(for breed: BreedsList.BreedListItem) async
}

final class BreedsListPresenter {
    private let coordinator: BreedsListCoordinating
    weak var displayer: BreedsListDisplaying?
    
    init(coordinator: BreedsListCoordinating) {
        self.coordinator = coordinator
    }
}

@MainActor
extension BreedsListPresenter: BreedsListPresenting {
    func startLoading() {
        displayer?.displayLoading()
    }
    
    func stopLoading() {
        displayer?.hideLoading()
    }
    
    func presentBreedsList(_ breedsList: [BreedsList.BreedListItem]) {
        displayer?.displayBreedsList(breedsList.sorted(by: { $0.name < $1.name }))
    }
    
    func presentErrorState(for error: Networking.ApiError) {
        switch error {
        case .noConnection:
            displayer?.displayError(.makeNoConnection())
        default:
            displayer?.displayError(.makeGeneric())
        }
    }
    
    func presentBreedDetails(for breed: BreedsList.BreedListItem) {
        coordinator.goToBreedDetails(breed: breed)
    }
}
