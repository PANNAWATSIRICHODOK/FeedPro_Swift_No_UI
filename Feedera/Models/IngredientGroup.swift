//
//  IngredientGroup.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

@Model
class IngredientGroup {
    @Attribute(.unique) var idIngdGrp: Int
    var groupName: String?
    var lastUpdate: Date?
    var color: String?
    var position: String?

    @Relationship var ingredients: [Ingredient] = []

    init(idIngdGrp: Int, groupName: String? = nil) {
        self.idIngdGrp = idIngdGrp
        self.groupName = groupName
    }
}
