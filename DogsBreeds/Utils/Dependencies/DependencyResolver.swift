import Networking

final class DependencyResolver {
    var api: () -> ApiProtocol = {
        Api()
    }
    
    var asyncTask: () -> AsyncTaskProtocol = {
        AsyncTask()
    }
    
    static var shared: DependencyResolver = .init()
    
    private init() {}
}
