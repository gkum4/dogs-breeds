@testable import DogsBreeds
import Testing
import UIKit

private extension BreedsListCoordinatorTests {
    typealias DependencySUT = (
        navigationControllerSpy: UINavigationControllerSpy,
        sut: BreedsListCoordinator
    )
    
    func makeSUT() -> DependencySUT {
        let viewController = UIViewController()
        let navigationControllerSpy = UINavigationControllerSpy(rootViewController: viewController)
        let sut = BreedsListCoordinator()
        
        sut.viewController = navigationControllerSpy.topViewController
        
        return (navigationControllerSpy, sut)
    }
}

@MainActor
struct BreedsListCoordinatorTests {
    @Test
    func goToBreedDetails_ShouldShowViewController() {
        let args = makeSUT()
        
        args.sut.goToBreedDetails(breedName: "Akita")
        
        #expect(args.navigationControllerSpy.showCallCount == 1)
    }
}
