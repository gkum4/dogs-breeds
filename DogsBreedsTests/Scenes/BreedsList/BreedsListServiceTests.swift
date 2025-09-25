@testable import DogsBreeds
import NetworkingTesting
import Testing

private extension BreedsListServiceTests {
    typealias DependencySUT = (
        apiSpy: ApiSpy,
        sut: BreedsListService
    )
    
    func makeSUT() -> DependencySUT {
        let apiSpy = ApiSpy()
        let sut = BreedsListService(api: apiSpy)
        return (apiSpy, sut)
    }
}

struct BreedsListServiceTests {
    @Test
    func fetchBreedsList_ShouldUseCorrectEndpointInfo() async throws {
        let args = makeSUT()
        
        _ = await args.sut.fetchBreedsList()
        
        let executeCall = try #require(args.apiSpy.executeCalls.first)
        #expect(executeCall.endpoint.method == .get)
        #expect(executeCall.endpoint.path == "/breeds/list/all")
    }
    
    @Test
    func fetchBreedsList_ShouldCallApi() async {
        let args = makeSUT()
        
        _ = await args.sut.fetchBreedsList()
        
        #expect(args.apiSpy.executeCalls.isEmpty == false)
    }
}
