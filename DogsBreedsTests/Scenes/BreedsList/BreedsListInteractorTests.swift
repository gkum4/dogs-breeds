@testable import DogsBreeds
import Networking
import Testing

private final class BreedsListPresenterSpy: BreedsListPresenting {
    enum Message: Equatable {
        case startLoading
        case stopLoading
        case presentBreedsList(_ breedsList: [BreedsList.BreedListItem])
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
        messages.append(.presentBreedsList(breedsList))
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
        let breedsList = BreedsList.fixture()
        args.serviceSpy.fetchBreedsListResult = .success(breedsList)
        
        args.sut.fetchBreedsList()
        await args.asyncTaskMock.executeAllTasks()
        
        #expect(args.presenterSpy.messages == [
            .startLoading,
            .presentBreedsList(breedsList.breeds),
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
    
    @Test
    func searchBreedsList_WhenSearchTextEmpty_ShouldReturnPreviouslySearchedBreedsList() async {
        let args = makeSUT()
        let breedsList = BreedsList.fixture()
        args.serviceSpy.fetchBreedsListResult = .success(breedsList)
        
        args.sut.fetchBreedsList()
        await args.asyncTaskMock.executeAllTasks()
        args.sut.searchBreedsList(with: "")
        await args.asyncTaskMock.executeAllTasks()
        
        #expect(args.presenterSpy.messages.last == .presentBreedsList(breedsList.breeds))
    }
    
    @Test
    func searchBreedsList_ShouldFilterPreviouslyFetchedBreedsListByName() async {
        let args = makeSUT()
        let breedsList = BreedsList.fixture(breeds: [
            .fixture(name: "akita"),
            .fixture(name: "German"),
            .fixture(name: "Pug"),
            .fixture(name: "puggle")
        ])
        args.serviceSpy.fetchBreedsListResult = .success(breedsList)
        
        args.sut.fetchBreedsList()
        await args.asyncTaskMock.executeAllTasks()
        args.sut.searchBreedsList(with: "pug")
        await args.asyncTaskMock.executeAllTasks()
        
        let expectedFilterdBreedsList: [BreedsList.BreedListItem] = [
            .fixture(name: "Pug"),
            .fixture(name: "puggle")
        ]
        #expect(args.presenterSpy.messages.last == .presentBreedsList(expectedFilterdBreedsList))
    }
}

