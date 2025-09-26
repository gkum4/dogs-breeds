import UIKit

final class LoadingView: UIView {
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    let identifier: String
    
    init(identifier: String) {
        self.identifier = identifier
        super.init(frame: .zero)
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoadingView {
    func buildViewHierarchy() {
        addSubview(activityIndicatorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
