import UIKit

protocol BreedsListCoordinating {
    func goToBreedDetails(breed: BreedsList.BreedListItem)
}

final class BreedsListCoordinator {
    weak var viewController: UIViewController?
}

extension BreedsListCoordinator: BreedsListCoordinating {
    func goToBreedDetails(breed: BreedsList.BreedListItem) {
        let vc = BreedDetailsFactory.make(breed: breed)
        viewController?.navigationController?.show(vc, sender: self)
    }
}
