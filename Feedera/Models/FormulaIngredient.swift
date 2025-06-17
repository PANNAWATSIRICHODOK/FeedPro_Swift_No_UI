//
//  FormulaIngredient.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

@Model
class FormulaIngredient {
    @Attribute(.unique) var id: UUID = UUID()
    var cost: Double?
    var minVal: Double?
    var maxVal: Double?
    var solutionAmount: Double?
    var position: Int?

    @Relationship var formula: Formula?
    @Relationship var ingredient: Ingredient?

    init(cost: Double? = nil) {
        self.cost = cost
    }
}
