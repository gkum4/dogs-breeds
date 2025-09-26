@testable import DogsBreeds
import Networking
import NetworkingTesting

final class DependencyContainerMock: DogsBreedsDependencies {
    var asyncTask: AsyncTaskProtocol
    var api: ApiProtocol
    
    init(
        asyncTask: AsyncTaskProtocol =  AsyncTaskMock(),
        api: ApiProtocol = ApiSpy()
    ) {
        self.asyncTask = asyncTask
        self.api = api
    }
}
