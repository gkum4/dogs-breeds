import UIKit

enum BreedDetailsFactory {
    static func make(breed: BreedsList.BreedListItem) -> UIViewController {
        let presenter = BreedDetailsPresenter()
        let service = BreedDetailsService()
        let interactor = BreedDetailsInteractor(presenter: presenter,
                                                service: service,
                                                breed: breed)
        let viewController = BreedDetailsViewController(interactor: interactor)
        
        presenter.displayer = viewController
        
        return viewController
    }
}
