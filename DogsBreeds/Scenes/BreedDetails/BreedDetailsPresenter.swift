import Networking

protocol BreedDetailsPresenting {
    func startLoading() async
    func stopLoading() async
    func presentBreedDetails(for viewModel: BreedDetailsViewModel) async
    func presentErrorState(for error: ApiError) async
    func presentTitle(_ title: String) async
}

final class BreedDetailsPresenter {
    private let coordinator: BreedDetailsCoordinating
    weak var displayer: BreedDetailsDisplaying?
    
    init(coordinator: BreedDetailsCoordinating) {
        self.coordinator = coordinator
    }
}

@MainActor
extension BreedDetailsPresenter: BreedDetailsPresenting {
    func startLoading() {
        displayer?.displayLoading()
    }
    
    func stopLoading() {
        displayer?.hideLoading()
    }
    
    func presentBreedDetails(for viewModel: BreedDetailsViewModel) {
        displayer?.displayBreedDetails(viewModel: viewModel)
    }
    
    func presentErrorState(for error: Networking.ApiError) {
        switch error {
        case .noConnection:
            displayer?.displayError(.makeNoConnection())
        default:
            displayer?.displayError(.makeGeneric())
        }
    }
    
    func presentTitle(_ title: String) {
        displayer?.displayTitle(title)
    }
}
