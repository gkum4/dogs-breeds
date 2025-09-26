import Foundation
import Networking

protocol BreedsListInteracting {
    func fetchBreedsList()
    func tappedOnListItem(breed: BreedsList.BreedListItem)
    func searchBreedsList(with searchText: String)
}

final class BreedsListInteractor {
    typealias Dependencies = HasAsyncTask
    private let presenter: BreedsListPresenting
    private let service: BreedsListServicing
    private let dependencies: Dependencies
    private var breedsList: [BreedsList.BreedListItem] = []
    
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
                await handleFetchBreedsListSuccess(breedsList)
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
    
    func searchBreedsList(with searchText: String) {
        guard !searchText.isEmpty else {
            showPreviousFetchedBreedsList()
            return
        }
        
        let filteredList = breedsList.filter { breedItem in
            breedItem.name.lowercased().contains(searchText.lowercased())
        }
        
        dependencies.asyncTask.execute { [weak self] in
            guard let self else { return }
            
            await presenter.presentBreedsList(filteredList)
        }
    }
}

private extension BreedsListInteractor {
    func handleFetchBreedsListSuccess(_ breedsList: BreedsList) async {
        self.breedsList = breedsList.breeds
        await presenter.presentBreedsList(breedsList.breeds)
    }
    
    func showPreviousFetchedBreedsList() {
        dependencies.asyncTask.execute { [weak self] in
            guard let self else { return }
            
            await presenter.presentBreedsList(breedsList)
        }
    }
}
