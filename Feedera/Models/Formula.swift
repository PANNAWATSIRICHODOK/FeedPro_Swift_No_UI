//
//  Formula.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

@Model
class Formula {
    @Attribute(.unique) var idFm: Int
    var name: String?
    var batchSize: Int?
    var costPerUnit: Double?
    var createDate: Date?
    var lastUpdate: Date?
    var rating: Int
    var color: String?
    var code: String?
    var budgetPerUnit: Double?
    var packUom: String?
    var packSize: Double?
    var packPrice: Double?

    @Relationship var group: FormulaGroup?
    @Relationship var ingredients: [FormulaIngredient] = []

    init(idFm: Int, name: String? = nil, batchSize: Int? = nil) {
        self.idFm = idFm
        self.name = name
        self.batchSize = batchSize
        self.rating = 0
    }
}
