import UIKit

protocol BreedsListCoordinating {
    func goToBreedDetails(breedName: String)
}

final class BreedsListCoordinator {
    weak var viewController: UIViewController?
}

extension BreedsListCoordinator: BreedsListCoordinating {
    func goToBreedDetails(breedName: String) {
        let vc = BreedDetailsFactory.make(breedName: breedName)
        viewController?.navigationController?.show(vc, sender: self)
    }
}
