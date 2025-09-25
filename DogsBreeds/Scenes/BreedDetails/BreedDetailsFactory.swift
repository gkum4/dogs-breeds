import UIKit

enum BreedDetailsFactory {
    static func make() -> UIViewController {
        let presenter = BreedDetailsPresenter()
        let service = BreedDetailsService()
        let interactor = BreedDetailsInteractor(presenter: presenter, service: service)
        let viewController = BreedDetailsViewController(interactor: interactor)
        
        presenter.displayer = viewController
        
        return viewController
    }
}
