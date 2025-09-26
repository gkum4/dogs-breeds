import UIKit

protocol BreedDetailsDisplaying: AnyObject {
    func displayLoading()
    func hideLoading()
    func displayBreedDetails(viewModel: BreedDetailsViewModel)
    func displayError(_ viewModel: ErrorViewModel)
    func displayTitle(_ title: String)
}

final class BreedDetailsViewController: UIViewController {
    private let interactor: BreedDetailsInteracting
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 300, height: 400)
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(BreedDetailsCollectionViewCell.self,
                                forCellWithReuseIdentifier: BreedDetailsCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var subBreedsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var breedImagesURLs: [String] = []
    
    init(interactor: BreedDetailsInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViewHierarchy()
        setupConstraints()
        setupView()
        interactor.fetchBreedDetails()
        interactor.setupTitle()
    }
}

private extension BreedDetailsViewController {
    func buildViewHierarchy() {
        containerStackView.addArrangedSubview(collectionView)
        containerStackView.addArrangedSubview(subBreedsLabel)
        view.addSubview(containerStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
    }
}
 
extension BreedDetailsViewController: BreedDetailsDisplaying {
    func displayLoading() {
        showLoadingScreen()
    }
    
    func hideLoading() {
        hideLoadingScreen()
    }
    
    func displayBreedDetails(viewModel: BreedDetailsViewModel) {
        breedImagesURLs = viewModel.imagesURLStrings
        
        subBreedsLabel.isHidden = viewModel.subBreeds.isEmpty
        subBreedsLabel.text = "Sub-breeds:\n• " + viewModel.subBreeds.joined(separator: "\n• ")
        
        collectionView.reloadData()
    }
    
    func displayError(_ viewModel: ErrorViewModel) {
        showErrorView(delegate: self, viewModel: viewModel)
    }
    
    func displayTitle(_ title: String) {
        self.title = title
    }
}

extension BreedDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        breedImagesURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BreedDetailsCollectionViewCell.identifier,
            for: indexPath
        ) as? BreedDetailsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell.setup(imageURLString: breedImagesURLs[indexPath.row])
    }
}

extension BreedDetailsViewController: ErrorViewDelegate {
    func errorViewButtonTapped() {
        hideErrorView()
        interactor.fetchBreedDetails()
    }
}
