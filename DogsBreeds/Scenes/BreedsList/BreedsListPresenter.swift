import Networking

protocol BreedsListPresenting {
    func startLoading() async
    func stopLoading() async
    func presentBreedsList(_ breedsList: [BreedsList.BreedListItem]) async
    func presentErrorState(for error: ApiError) async
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
            displayer?.displayError(title: "Ops, sem internet",
                                    message: "Verifique sua conexão e tente novamente.")
        default:
            displayer?.displayError(title: "Ops, encontramos um problema",
                                    message: "Encontramos um problema ao buscar a lista de raças, tente novamente.")
        }
    }
}
