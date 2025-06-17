//
//  IngredientNutrient.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

@Model
class IngredientNutrient {
    @Attribute(.unique) var id: Int
    var value: Double?

    @Relationship var ingredient: Ingredient?
    @Relationship var nutrient: Nutrient?

    init(id: Int, value: Double? = nil) {
        self.id = id
        self.value = value
    }
}
