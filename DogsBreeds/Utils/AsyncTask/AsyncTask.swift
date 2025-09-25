protocol AsyncTaskProtocol {
    func execute(_ code: @escaping () async -> Void)
}

final class AsyncTask: AsyncTaskProtocol {
    func execute(_ code: @escaping () async -> Void) {
        Task {
            await code()
        }
    }
}
