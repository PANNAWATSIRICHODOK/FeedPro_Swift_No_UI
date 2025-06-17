//
//  Ingredient.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

@Model
class Ingredient {
    @Attribute(.unique) var idIngd: Int
    var name: String?
    var cost: Double?
    var createDate: Date?
    var lastUpdate: Date?
    var rating: Int
    var color: String?
    var code: String?
    var budgetPerUnit: Double?

    @Relationship var group: IngredientGroup?
    @Relationship var nutrients: [IngredientNutrient] = []

    init(idIngd: Int, name: String? = nil) {
        self.idIngd = idIngd
        self.name = name
        self.rating = 0
    }
}
