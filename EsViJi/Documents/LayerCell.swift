//
//  LayerCell.swift
//  EsViJi
//
//  Created by Роман Есин on 28.10.2021.
//

import UIKit

class LayerCell: UITableViewCell {
    static let identifier = "LayerCell"

    var data: Layer?

    lazy var layerImageView = UIImageView()
    lazy var titleLabel = UILabel()

    var imageLeadingAnchor: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layerImageView.translatesAutoresizingMaskIntoConstraints = false
        layerImageView.layer.cornerRadius = 8
        layerImageView.clipsToBounds = true
        layerImageView.contentMode = .scaleAspectFill
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(layerImageView)
        self.addSubview(titleLabel)

        imageLeadingAnchor = layerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)

        NSLayoutConstraint.activate([
            imageLeadingAnchor!,
            layerImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.bottomAnchor.constraint(equalTo: layerImageView.bottomAnchor, constant: 8),
            layerImageView.widthAnchor.constraint(equalToConstant: 48),
            layerImageView.heightAnchor.constraint(equalToConstant: 48),

            titleLabel.leadingAnchor.constraint(equalTo: layerImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: layerImageView.centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(_ layer: Layer) {
        self.data = layer

        if layer.subitems == nil {
            layerImageView.image = .init(named: "Document")
        } else {
            layerImageView.image = .init(systemName: "folder.fill")
        }
        titleLabel.text = layer.title
    }
}
