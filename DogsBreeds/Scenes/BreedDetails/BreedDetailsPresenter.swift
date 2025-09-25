protocol BreedDetailsPresenting {}

final class BreedDetailsPresenter {
    weak var displayer: BreedDetailsDisplaying?
}

@MainActor
extension BreedDetailsPresenter: BreedDetailsPresenting {}
