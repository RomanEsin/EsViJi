//
//  DocumentsCollectionViewController.swift
//  EsViJi
//
//  Created by Роман Есин on 25.10.2021.
//

import UIKit

class DocumentCell: UICollectionViewCell {
    static let identifier = "DocumentCell"

    lazy var previewImageView = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var dateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 16
        clipsToBounds = true

        previewImageView.translatesAutoresizingMaskIntoConstraints = false
//        previewImageView.contentMode = .scaleAspectFill
        previewImageView.layer.cornerRadius = 16
        previewImageView.clipsToBounds = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .center
        dateLabel.font = .preferredFont(forTextStyle: .caption1)
        dateLabel.textColor = .secondaryLabel

        contentView.addSubview(previewImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            previewImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 120),

            titleLabel.topAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            contentView.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor)
        ])

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(animateLongPress(_:)))
        longPress.minimumPressDuration = 0.3

        addGestureRecognizer(longPress)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config() {
        previewImageView.image = .init(named: "Document")
        titleLabel.text = "Document title fits on two lines"
        dateLabel.text = "Yesterday 11:22"
    }

    func animate(fadeOut: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.backgroundColor = fadeOut ? .clear : .secondarySystemFill
        }
    }

    @objc func animateLongPress(_ recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animate(fadeOut: false)
        default:
            animate(fadeOut: true)
        }
    }
}

class DocumentCollectionDataSource: UICollectionViewDiffableDataSource<Int, Int> {}

class DocumentsCollectionViewController: UICollectionViewController {

    let docs = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    lazy var dataSource = DocumentCollectionDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: DocumentCell.identifier, for: indexPath) as? DocumentCell
        else { return UICollectionViewCell() }

        cell.config()

        return cell
    }

    init() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 8, bottom: 16, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(200))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)

        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(DocumentCell.self, forCellWithReuseIdentifier: DocumentCell.identifier)
        self.collectionView.dataSource = dataSource

        var snapshot = dataSource.snapshot()
        snapshot.appendSections([1])
        snapshot.appendItems(docs, toSection: 1)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = EditorViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
