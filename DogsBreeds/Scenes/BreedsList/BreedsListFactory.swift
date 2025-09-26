import UIKit

enum BreedsListFactory {
    static func make(dependencies: DogsBreedsDependencies = DependencyContainer()) -> UIViewController {
        let coordinator = BreedsListCoordinator()
        let presenter = BreedsListPresenter(coordinator: coordinator)
        let service = BreedsListService(dependencies: dependencies)
        let interactor = BreedsListInteractor(presenter: presenter, service: service, dependencies: dependencies)
        let viewController = BreedsListViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.displayer = viewController
        
        return viewController
    }
}
