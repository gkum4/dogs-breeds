@testable import DogsBreeds
import Networking
import Testing

private final class BreedDetailsPresenterSpy: BreedDetailsPresenting {
    enum Message: Equatable {
        case startLoading
        case stopLoading
        case presentBreedDetails
        case presentErrorState
        case presentTitle(_ title: String)
    }
    
    private(set) var messages: [Message] = []
    
    func startLoading() async {
        messages.append(.startLoading)
    }
    
    func stopLoading() async {
        messages.append(.stopLoading)
    }
    
    func presentBreedDetails(for viewModel: DogsBreeds.BreedDetailsViewModel) async {
        messages.append(.presentBreedDetails)
    }
    
    func presentErrorState(for error: Networking.ApiError) async {
        messages.append(.presentErrorState)
    }
    
    func presentTitle(_ title: String) async {
        messages.append(.presentTitle(title))
    }
}

private final class BreedDetailsServiceSpy: BreedDetailsServicing {
    private(set) var fetchBreedDetailsCalls: [String] = []
    var fetchBreedDetailsResult: ApiResult<DogsBreeds.BreedDetails>?
    func fetchBreedDetails(for breedName: String) async -> ApiResult<DogsBreeds.BreedDetails> {
        fetchBreedDetailsCalls.append(breedName)
        return fetchBreedDetailsResult ?? .failure(.cancelled)
    }
}

private extension BreedDetailsInteractorTests {
    typealias DependencySUT = (
        presenterSpy: BreedDetailsPresenterSpy,
        serviceSpy: BreedDetailsServiceSpy,
        asyncTaskMock: AsyncTaskMock,
        sut: BreedDetailsInteractor
    )
    
    func makeSUT(breed: BreedsList.BreedListItem = .fixture()) -> DependencySUT {
        let presenterSpy = BreedDetailsPresenterSpy()
        let serviceSpy = BreedDetailsServiceSpy()
        let asyncTaskMock = AsyncTaskMock()
        let dependencyContainerMock = DependencyContainerMock(asyncTask: asyncTaskMock)
        let sut = BreedDetailsInteractor(presenter: presenterSpy,
                                         service: serviceSpy,
                                         dependencies: dependencyContainerMock,
                                         breed: breed)
        return (presenterSpy, serviceSpy, asyncTaskMock, sut)
    }
}

struct BreedDetailsInteractorTests {
    @Test
    func fetchBreedDetails_WhenServiceSuccess_ShouldPresentBreedDetails() async {
        let args = makeSUT()
        args.serviceSpy.fetchBreedDetailsResult = .success(.fixture())
        
        args.sut.fetchBreedDetails()
        await args.asyncTaskMock.executeAllTasks()
        
        #expect(args.presenterSpy.messages == [
            .startLoading,
            .presentBreedDetails,
            .stopLoading
        ])
        #expect(args.serviceSpy.fetchBreedDetailsCalls.isEmpty == false)
    }
    
    @Test
    func fetchBreedDetails_WhenServiceFailure_ShouldPresentErrorState() async {
        let args = makeSUT()
        args.serviceSpy.fetchBreedDetailsResult = .failure(.cancelled)
        
        args.sut.fetchBreedDetails()
        await args.asyncTaskMock.executeAllTasks()
        
        #expect(args.presenterSpy.messages == [
            .startLoading,
            .presentErrorState,
            .stopLoading
        ])
        #expect(args.serviceSpy.fetchBreedDetailsCalls.isEmpty == false)
    }
    
    @Test
    func setupTitle_ShouldPresentTitleWithBreedName() async {
        let breedName = "Kuma"
        let args = makeSUT(breed: .fixture(name: breedName))
        
        args.sut.setupTitle()
        await args.asyncTaskMock.executeAllTasks()
        
        #expect(args.presenterSpy.messages == [.presentTitle(breedName)])
    }
}
