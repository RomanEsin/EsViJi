//
//  Layer.swift
//  EsViJi
//
//  Created by Роман Есин on 28.10.2021.
//

import Foundation

class Layer: Identifiable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Layer, rhs: Layer) -> Bool {
        lhs.id == rhs.id
    }

    let id = UUID()
    var title: String
    var subitems: [Layer]? = nil

    init(title: String, subitems: [Layer]? = nil) {
        self.title = title
        self.subitems = subitems
    }
}
