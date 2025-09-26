import Networking

typealias DogsBreedsDependencies = HasApi &
    HasAsyncTask

final class DependencyContainer: DogsBreedsDependencies {
    private let dependencyResolver = DependencyResolver.shared
    
    lazy var api: ApiProtocol = dependencyResolver.api()
    lazy var asyncTask: AsyncTaskProtocol = dependencyResolver.asyncTask()
}
