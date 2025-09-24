import UIKit

protocol BreedsListDisplaying: AnyObject {}

final class BreedsListViewController: UIViewController {
    private let interactor: BreedsListInteracting
    
    init(interactor: BreedsListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "BreedsListViewController"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension BreedsListViewController: BreedsListDisplaying {}
