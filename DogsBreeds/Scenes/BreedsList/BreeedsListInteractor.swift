import Foundation
import Networking

protocol BreedsListInteracting {
    func fetchBreedsList()
    func tappedOnListItem(breed: BreedsList.BreedListItem)
}

final class BreedsListInteractor {
    typealias Dependencies = HasAsyncTask
    private let presenter: BreedsListPresenting
    private let service: BreedsListServicing
    private let dependencies: Dependencies
    
    
    init(presenter: BreedsListPresenting,
         service: BreedsListServicing,
         dependencies: Dependencies) {
        self.presenter = presenter
        self.service = service
        self.dependencies = dependencies
    }
}

extension BreedsListInteractor: BreedsListInteracting {
    func fetchBreedsList() {
        dependencies.asyncTask.execute { [weak self] in
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
    
    func tappedOnListItem(breed: BreedsList.BreedListItem) {
        dependencies.asyncTask.execute { [weak self] in
            guard let self else { return }
            
            await presenter.presentBreedDetails(for: breed)
        }
        
    }
}
