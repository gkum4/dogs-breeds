import UIKit

enum BreedDetailsFactory {
    static func make(breed: BreedsList.BreedListItem,
                     dependencies: DogsBreedsDependencies = DependencyContainer()) -> UIViewController {
        let coordinator = BreedDetailsCoordinator()
        let presenter = BreedDetailsPresenter(coordinator: coordinator)
        let service = BreedDetailsService(dependencies: dependencies)
        let interactor = BreedDetailsInteractor(presenter: presenter,
                                                service: service,
                                                dependencies: dependencies,
                                                breed: breed)
        let viewController = BreedDetailsViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.displayer = viewController
        
        return viewController
    }
}
