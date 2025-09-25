@testable import DogsBreeds

final class AsyncTaskMock: AsyncTaskProtocol {
    private(set) var tasks: [() async -> Void] = []
    func execute(_ code: @escaping () async -> Void) {
        tasks.append(code)
    }
    
    func executeAllTasks() async {
        for task in tasks {
            await task()
        }
        
        tasks = []
    }
}
