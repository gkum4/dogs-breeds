import UIKit

protocol BreedsListDisplaying: AnyObject {
    func displayLoading()
    func hideLoading()
    func displayBreedsList(_ breedsList: [BreedsList.BreedListItem])
    func displayError(_ viewModel: ErrorViewModel)
}

final class BreedsListViewController: UIViewController {
    private let interactor: BreedsListInteracting
    
    private var breedsList: [BreedsList.BreedListItem] = []
    
    private var searchTimer: Timer?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .default
        searchBar.placeholder = "Find the dog breed"
        searchBar.frame = CGRect(x: 0,
                                 y: 0,
                                 width: view.frame.width,
                                 height: 44)
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BreedsListTableViewCell.self, forCellReuseIdentifier: BreedsListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(interactor: BreedsListInteracting) {
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
        interactor.fetchBreedsList()
    }
}

private extension BreedsListViewController {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.titleView = searchBar
        setupDismissKeyboardWhenTappedOutside()
    }
}

extension BreedsListViewController: BreedsListDisplaying {
    func displayLoading() {
        showLoadingScreen()
    }
    
    func hideLoading() {
        hideLoadingScreen()
    }
    
    func displayBreedsList(_ breedsList: [BreedsList.BreedListItem]) {
        self.breedsList = breedsList
        tableView.reloadData()
    }
    
    func displayError(_ viewModel: ErrorViewModel) {
        showErrorView(delegate: self, viewModel: viewModel)
    }
}

extension BreedsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breedsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let breedsListCell = tableView.dequeueReusableCell(
            withIdentifier: BreedsListTableViewCell.identifier,
            for: indexPath
        ) as? BreedsListTableViewCell else {
            return UITableViewCell()
        }
        
        return breedsListCell.setupCell(with: breedsList[indexPath.row])
    }
}

extension BreedsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = breedsList[indexPath.row]
        interactor.tappedOnListItem(breed: breed)
    }
}

extension BreedsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        
        searchTimer = .scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self else { return }
            
            interactor.searchBreedsList(with: searchText)
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tableView.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = 0.3
            self.tableView.transform = CGAffineTransform.identity.scaledBy(x: 0.99, y: 0.99)
        }
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = 1
            self.tableView.transform = .identity
        } completion: { _ in
            self.tableView.isUserInteractionEnabled = true
        }
        
        endSearchBarEditing()
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endSearchBarEditing()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endSearchBarEditing()
    }
    
    private func endSearchBarEditing() {
        searchBar.resignFirstResponder()
    }
    
    @objc override func dismissKeyboard() {
        searchBar.endEditing(true)
    }
}

extension BreedsListViewController: ErrorViewDelegate {
    func errorViewButtonTapped() {
        hideErrorView()
        interactor.fetchBreedsList()
    }
}
