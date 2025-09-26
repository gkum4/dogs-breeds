@testable import DogsBreeds
import Networking
import Testing

private final class BreedDetailsCoordinateSpy: BreedDetailsCoordinating {
    enum Message: Equatable {}
    
    private(set) var messages: [Message] = []
}

private final class BreedDetailsDisplayerSpy: BreedDetailsDisplaying {
    enum Message: Equatable {
        case displayLoading
        case hideLoading
        case displayBreedDetails
        case displayError(_ viewModel: ErrorViewModel)
        case displayTitle
    }
    
    private(set) var messages: [Message] = []
    
    func displayLoading() {
        messages.append(.displayLoading)
    }
    
    func hideLoading() {
        messages.append(.hideLoading)
    }
    
    func displayBreedDetails(viewModel: DogsBreeds.BreedDetailsViewModel) {
        messages.append(.displayBreedDetails)
    }
    
    func displayError(_ viewModel: DogsBreeds.ErrorViewModel) {
        messages.append(.displayError(viewModel))
    }
    
    func displayTitle(_ title: String) {
        messages.append(.displayTitle)
    }
}

private extension BreedDetailsPresenterTests {
    typealias DependencySUT = (
        coordinatorSpy: BreedDetailsCoordinateSpy,
        displayerSpy: BreedDetailsDisplayerSpy,
        sut: BreedDetailsPresenter
    )
    
    func makeSUT() -> DependencySUT {
        let coordinatorSpy = BreedDetailsCoordinateSpy()
        let displayerSpy = BreedDetailsDisplayerSpy()
        let sut = BreedDetailsPresenter(coordinator: coordinatorSpy)
        sut.displayer = displayerSpy
        return (coordinatorSpy, displayerSpy, sut)
    }
}

@MainActor
struct BreedDetailsPresenterTests {
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
    func presentBreedDetails_ShouldDisplayBreedDetails() {
        let args = makeSUT()
        
        args.sut.presentBreedDetails(for: .init(breedName: "",
                                                subBreeds: [],
                                                imagesURLStrings: []))
        
        #expect(args.displayerSpy.messages == [.displayBreedDetails])
    }
    
    @Test(arguments: [
        (ApiError.noConnection, ErrorViewModel.makeNoConnection()),
        (ApiError.cancelled, ErrorViewModel.makeGeneric()),
        (ApiError.notFound, ErrorViewModel.makeGeneric()),
        (ApiError.malformedRequest, ErrorViewModel.makeGeneric()),
    ])
    func presentError_ShouldDisplayCorrectError(error: ApiError,
                                                expectedViewModel: ErrorViewModel) {
        let args = makeSUT()
        
        args.sut.presentErrorState(for: error)
        
        #expect(args.displayerSpy.messages == [.displayError(expectedViewModel)])
    }
    
    @Test
    func presentTitle_ShouldDisplayTitle() {
        let args = makeSUT()
        
        args.sut.presentTitle("")
        
        #expect(args.displayerSpy.messages == [.displayTitle])
    }
}
