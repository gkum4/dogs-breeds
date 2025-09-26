@testable import DogsBreeds
import Networking
import Testing

private final class BreedsListPresenterSpy: BreedsListPresenting {
    enum Message: Equatable {
        case startLoading
        case stopLoading
        case presentBreedsList
        case presentErrorState
        case presentBreedDetails
    }
    
    private(set) var messages: [Message] = []
    
    func startLoading() async {
        messages.append(.startLoading)
    }
    
    func stopLoading() async {
        messages.append(.stopLoading)
    }
    
    func presentBreedsList(_ breedsList: [DogsBreeds.BreedsList.BreedListItem]) async {
        messages.append(.presentBreedsList)
    }
    
    func presentErrorState(for error: Networking.ApiError) async {
        messages.append(.presentErrorState)
    }
    
    func presentBreedDetails(for breed: DogsBreeds.BreedsList.BreedListItem) async {
        messages.append(.presentBreedDetails)
    }
}

private final class BreedsListServiceSpy: BreedsListServicing {
    private(set) var fetchBreedsListCallCount = 0
    var fetchBreedsListResult: ApiResult<DogsBreeds.BreedsList>?
    
    func fetchBreedsList() async -> Networking.ApiResult<DogsBreeds.BreedsList> {
        fetchBreedsListCallCount += 1
        return fetchBreedsListResult ?? .failure(.cancelled)
    }
}

private extension BreedsListInteractorTests {
    typealias DependencySUT = (
        presenterSpy: BreedsListPresenterSpy,
        serviceSpy: BreedsListServiceSpy,
        asyncTaskMock: AsyncTaskMock,
        sut: BreedsListInteractor
    )
    
    func makeSUT() -> DependencySUT {
        let presenterSpy = BreedsListPresenterSpy()
        let serviceSpy = BreedsListServiceSpy()
        let asyncTaskMock = AsyncTaskMock()
        let dependencyContainerMock = DependencyContainerMock(asyncTask: asyncTaskMock)
        let sut = BreedsListInteractor(presenter: presenterSpy,
                                       service: serviceSpy,
                                       dependencies: dependencyContainerMock)
        return (presenterSpy, serviceSpy, asyncTaskMock, sut)
    }
}

struct BreedsListInteractorTests {
    @Test
    func fetchBreedsList_WhenServiceSuccess_ShouldPresentBreedsList() async {
        let args = makeSUT()
        args.serviceSpy.fetchBreedsListResult = .success(.fixture())
        
        args.sut.fetchBreedsList()
        await args.asyncTaskMock.executeAllTasks()
        
        #expect(args.presenterSpy.messages == [
            .startLoading,
            .presentBreedsList,
            .stopLoading
        ])
    }
    
    @Test
    func fetchBreedsList_WhenServiceFailure_ShouldPresentError() async {
        let args = makeSUT()
        args.serviceSpy.fetchBreedsListResult = .failure(.noConnection)
        
        args.sut.fetchBreedsList()
        await args.asyncTaskMock.executeAllTasks()
        
        #expect(args.presenterSpy.messages == [
            .startLoading,
            .presentErrorState,
            .stopLoading
        ])
    }
    
    @Test
    func tappedOnListItem_ShouldPresentBreedDetails() async {
        let args = makeSUT()
        
        args.sut.tappedOnListItem(breed: .fixture())
        await args.asyncTaskMock.executeAllTasks()
        
        #expect(args.presenterSpy.messages == [.presentBreedDetails])
    }
}

