import UIKit

final class BreedsListTableViewCell: UITableViewCell {
    static let identifier = String(describing: BreedsListTableViewCell.self)
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var breedNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subBreedsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        breedNameLabel.text = nil
        subBreedsLabel.text = nil
        subBreedsLabel.isHidden = true
    }
    
    func setupCell(with item: BreedsList.BreedListItem) -> Self {
        breedNameLabel.text = item.name
        subBreedsLabel.isHidden = item.subBreeds.isEmpty
        subBreedsLabel.text = item.subBreeds.joined(separator: ", ")
        return self
    }
}

private extension BreedsListTableViewCell {
    func buildViewHierarchy() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(breedNameLabel)
        containerStackView.addArrangedSubview(subBreedsLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}
