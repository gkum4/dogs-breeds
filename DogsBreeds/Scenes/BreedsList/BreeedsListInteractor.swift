import Foundation

protocol BreedsListInteracting {}

final class BreedsListInteractor {
    private let presenter: BreedsListPresenter
    private let service: BreedsListService
    
    init(presenter: BreedsListPresenter, service: BreedsListService) {
        self.presenter = presenter
        self.service = service
    }
}

extension BreedsListInteractor: BreedsListInteracting {}
