import UIKit

enum BreedDetailsFactory {
    static func make(breedName: String) -> UIViewController {
        let presenter = BreedDetailsPresenter()
        let service = BreedDetailsService()
        let interactor = BreedDetailsInteractor(presenter: presenter,
                                                service: service,
                                                breedName: breedName)
        let viewController = BreedDetailsViewController(interactor: interactor)
        
        presenter.displayer = viewController
        
        return viewController
    }
}
