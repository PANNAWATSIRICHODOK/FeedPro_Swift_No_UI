//
//  NutrientSpec.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

@Model
class NutrientSpec {
    @Attribute(.unique) var id: UUID = UUID()
    var minVal: Double?
    var maxVal: Double?
    var solutionAmount: Double?
    var position: Int?

    @Relationship var formula: Formula?
    @Relationship var nutrient: Nutrient?

    init(minVal: Double? = nil, maxVal: Double? = nil) {
        self.minVal = minVal
        self.maxVal = maxVal
    }
}
