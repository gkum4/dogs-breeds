protocol BreedsListPresenting {}

final class BreedsListPresenter {
    weak var displayer: BreedsListDisplaying?
}

extension BreedsListPresenter: BreedsListPresenting {}
