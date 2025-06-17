//
//  Nutrient.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

@Model
class Nutrient {
    @Attribute(.unique) var idNt: Int
    var name: String?
    var shortName: String?
    var unit: String?
    var factor: String?
    var decimals: Int?
    var lastUpdate: Date?
    var rating: Int
    var color: String?
    var code: String?

    @Relationship var group: NutrientGroup?
    @Relationship var specs: [NutrientSpec] = []

    init(idNt: Int, name: String? = nil) {
        self.idNt = idNt
        self.name = name
        self.rating = 0
    }
}
