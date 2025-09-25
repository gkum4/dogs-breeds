import UIKit

protocol BreedDetailsDisplaying: AnyObject {}

final class BreedDetailsViewController: UIViewController {
    private let interactor: BreedDetailsInteracting
    
    init(interactor: BreedDetailsInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "BreedDetailsViewController"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension BreedDetailsViewController: BreedDetailsDisplaying {}
