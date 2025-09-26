import UIKit

final class BreedsListTableViewCell: UITableViewCell {
    static let identifier = String(describing: BreedsListTableViewCell.self)
    
    private lazy var breedNameLabel: UILabel = {
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
        super.prepareForReuse()
        breedNameLabel.text = nil
    }
    
    func setupCell(with item: BreedsList.BreedListItem) -> Self {
        breedNameLabel.text = item.name
        return self
    }
}

private extension BreedsListTableViewCell {
    func buildViewHierarchy() {
        contentView.addSubview(breedNameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            breedNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            breedNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            breedNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            breedNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}
