import UIKit

protocol BreedDetailsCoordinating {}

final class BreedDetailsCoordinator {
    weak var viewController: UIViewController?
}

extension BreedDetailsCoordinator: BreedDetailsCoordinating {}
