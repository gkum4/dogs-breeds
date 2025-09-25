import Foundation
import Networking

protocol BreedsListInteracting {
    func fetchBreedsList()
}

final class BreedsListInteractor {
    private let presenter: BreedsListPresenter
    private let service: BreedsListService
    private let asyncTask: AsyncTaskProtocol
    
    init(presenter: BreedsListPresenter,
         service: BreedsListService,
         asyncTask: AsyncTaskProtocol = AsyncTask()) {
        self.presenter = presenter
        self.service = service
        self.asyncTask = asyncTask
    }
}

extension BreedsListInteractor: BreedsListInteracting {
    func fetchBreedsList() {
        asyncTask.execute { [weak self] in
            guard let self else { return }
            
            await presenter.startLoading()
            
            let result = await service.fetchBreedsList()
            
            switch result {
            case .success(let breedsList):
                await presenter.presentBreedsList(breedsList.breeds)
            case .failure(let error):
                await presenter.presentErrorState(for: error)
            }
            
            await presenter.stopLoading()
        }
    }
}

private extension BreedsListInteractor {}
