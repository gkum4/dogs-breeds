protocol BreedDetailsInteracting {
    func fetchBreedDetails()
    func setupTitle()
}

final class BreedDetailsInteractor {
    typealias Dependencies = HasAsyncTask
    private let presenter: BreedDetailsPresenting
    private let service: BreedDetailsServicing
    private let dependencies: Dependencies
    private let breed: BreedsList.BreedListItem
    
    init(presenter: BreedDetailsPresenting,
         service: BreedDetailsServicing,
         dependencies: Dependencies,
         breed: BreedsList.BreedListItem) {
        self.presenter = presenter
        self.service = service
        self.dependencies = dependencies
        self.breed = breed
    }
}

extension BreedDetailsInteractor: BreedDetailsInteracting {
    func fetchBreedDetails() {
        dependencies.asyncTask.execute { [weak self] in
            guard let self else { return }
            
            await presenter.startLoading()
            
            let result = await service.fetchBreedDetails(for: breed.name)
            
            switch result {
            case .success(let breedDetails):
                await handleFetchBreedDetailsSuccess(breedDetails)
            case .failure(let error):
                await presenter.presentErrorState(for: error)
            }
            
            await presenter.stopLoading()
        }
    }
    
    func setupTitle() {
        dependencies.asyncTask.execute { [weak self] in
            guard let self else { return }
            
            await presenter.presentTitle(breed.name)
        }
    }
}

private extension BreedDetailsInteractor {
    func handleFetchBreedDetailsSuccess(_ breedDetails: BreedDetails) async {
        let viewModel = BreedDetailsViewModel(breedName: breed.name,
                                              subBreeds: breed.subBreeds,
                                              imagesURLStrings: breedDetails.images)
        await presenter.presentBreedDetails(for: viewModel)
    }
}
