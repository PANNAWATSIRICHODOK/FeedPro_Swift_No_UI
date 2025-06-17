//
//  IngredientDetailViewModel.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

class IngredientDetailViewModel: ObservableObject {
    @Published var name: String
    @Published var cost: Double

    private(set) var ingredient: Ingredient

    init(ingredient: Ingredient) {
        self.ingredient = ingredient
        self.name = ingredient.name ?? ""
        self.cost = ingredient.cost ?? 0
    }

    func update(context: ModelContext) {
        ingredient.name = name
        ingredient.cost = cost
        try? context.save()
    }

    func delete(context: ModelContext) {
        context.delete(ingredient)
        try? context.save()
    }
}
