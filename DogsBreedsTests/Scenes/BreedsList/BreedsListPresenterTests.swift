@testable import DogsBreeds
import Testing

private final class BreedsListCoordinatorSpy: BreedsListCoordinating {
    enum Message: Equatable {
        case goToBreedDetails
    }
    
    private(set) var messages: [Message] = []
    
    func goToBreedDetails(breedName: String) {
        messages.append(.goToBreedDetails)
    }
}

private final class BreedsListDisplayerSpy: BreedsListDisplaying {
    enum Message: Equatable {
        case displayLoading
        case hideLoading
        case displayBreedsList(_ breedsList: [DogsBreeds.BreedsList.BreedListItem])
        case displayError(title: String, message: String)
    }
    
    private(set) var messages: [Message] = []
    
    func displayLoading() {
        messages.append(.displayLoading)
    }
    
    func hideLoading() {
        messages.append(.hideLoading)
    }
    
    func displayBreedsList(_ breedsList: [DogsBreeds.BreedsList.BreedListItem]) {
        messages.append(.displayBreedsList(breedsList))
    }
    
    func displayError(title: String, message: String) {
        messages.append(.displayError(title: title, message: message))
    }
}

private extension BreedsListPresenterTests {
    typealias DependencySUT = (
        displayerSpy: BreedsListDisplayerSpy,
        coordinatorSpy: BreedsListCoordinatorSpy,
        sut: BreedsListPresenter
    )
    
    func makeSUT() -> DependencySUT {
        let displayerSpy =  BreedsListDisplayerSpy()
        let coordinatorSpy =  BreedsListCoordinatorSpy()
        let sut = BreedsListPresenter(coordinator: coordinatorSpy)
        sut.displayer = displayerSpy
        return (displayerSpy, coordinatorSpy, sut)
    }
}

@MainActor
struct BreedsListPresenterTests {
    @Test
    func startLoading_ShouldDisplayLoading() {
        let args = makeSUT()
        
        args.sut.startLoading()
        
        #expect(args.displayerSpy.messages == [.displayLoading])
    }
    
    @Test
    func stopLoading_ShouldHideLoading() {
        let args = makeSUT()
        
        args.sut.stopLoading()
        
        #expect(args.displayerSpy.messages == [.hideLoading])
    }
    
    @Test
    func presentBreedsList_ShouldDisplayInCorrectOrder() {
        let args = makeSUT()
        let breedsList: [BreedsList.BreedListItem] = [
            .init(name: "A", subBreeds: []),
            .init(name: "C", subBreeds: []),
            .init(name: "D", subBreeds: []),
            .init(name: "B", subBreeds: [])
        ]
        
        args.sut.presentBreedsList(breedsList)
        
        let expectedBreedsList: [BreedsList.BreedListItem] = [
            .init(name: "A", subBreeds: []),
            .init(name: "B", subBreeds: []),
            .init(name: "C", subBreeds: []),
            .init(name: "D", subBreeds: [])
        ]
        #expect(args.displayerSpy.messages == [.displayBreedsList(expectedBreedsList)])
    }
    
    @Test
    func presentErrorState_ShouldHandleDifferentlyForNoConnection() {
        let args = makeSUT()
        
        args.sut.presentErrorState(for: .noConnection)
        args.sut.presentErrorState(for: .cancelled)
        
        #expect(args.displayerSpy.messages.first != args.displayerSpy.messages.last)
    }
    
    @Test
    func presentBreedDetails_ShouldGoToBreedDetails() {
        let args = makeSUT()
        
        args.sut.presentBreedDetails(with: "Akita")
        
        #expect(args.coordinatorSpy.messages == [.goToBreedDetails])
    }
}
