import UIKit

enum BreedsListFactory {
    static func make() -> UIViewController {
        let coordinator = BreedsListCoordinator()
        let presenter = BreedsListPresenter(coordinator: coordinator)
        let service = BreedsListService()
        let interactor = BreedsListInteractor(presenter: presenter, service: service)
        let viewController = BreedsListViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.displayer = viewController
        
        return viewController
    }
}
