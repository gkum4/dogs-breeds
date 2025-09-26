@testable import DogsBreeds
import NetworkingTesting
import Testing

private extension BreedDetailsServiceTests {
    typealias DependencySUT = (
        apiSpy: ApiSpy,
        sut: BreedDetailsService
    )
    
    func makeSUT() -> DependencySUT {
        let apiSpy = ApiSpy()
        let dependencyContainerMock = DependencyContainerMock(api: apiSpy)
        let sut = BreedDetailsService(dependencies: dependencyContainerMock)
        return (apiSpy, sut)
    }
}

struct BreedDetailsServiceTests {
    @Test
    func fetchBreedsList_ShouldUseCorrectEndpointInfo() async throws {
        let args = makeSUT()
        let breedName = "akita"
        
        _ = await args.sut.fetchBreedDetails(for: breedName)
        
        let executeCall = try #require(args.apiSpy.executeCalls.first)
        #expect(executeCall.endpoint.method == .get)
        #expect(executeCall.endpoint.path == "/breed/\(breedName)/images")
    }
}
