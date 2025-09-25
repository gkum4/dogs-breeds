import UIKit

protocol BreedsListDisplaying: AnyObject {
    func displayLoading()
    func hideLoading()
    func displayBreedsList(_ breedsList: [BreedsList.BreedListItem])
    func displayError(title: String, message: String)
}

final class BreedsListViewController: UIViewController {
    private let interactor: BreedsListInteracting
    
    private var breedsList: [BreedsList.BreedListItem] = []
    
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
}

extension BreedsListViewController: BreedsListDisplaying {
    func displayLoading() {}
    
    func hideLoading() {}
    
    func displayBreedsList(_ breedsList: [BreedsList.BreedListItem]) {
        self.breedsList = breedsList
        tableView.reloadData()
    }
    
    func displayError(title: String, message: String) {}
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
        print("selected \(breedsList[indexPath.row].name)")
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        50
//    }
}
