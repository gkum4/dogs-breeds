import UIKit

protocol ErrorViewDelegate: AnyObject {
    func errorViewButtonTapped()
}

final class ErrorView: UIView {
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: ErrorViewDelegate?
    
    init() {
        super.init(frame: .zero)
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ viewModel: ErrorViewModel) {
        titleLabel.text = viewModel.title
        messageLabel.text = viewModel.message
        button.setTitle(viewModel.buttonTitle, for: .normal)
    }
}

private extension ErrorView {
    func buildViewHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(messageLabel)
        containerStackView.addArrangedSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

private extension ErrorView {
    @objc func buttonTapped() {
        delegate?.errorViewButtonTapped()
    }
}
