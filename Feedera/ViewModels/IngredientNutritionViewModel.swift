//
//  IngredientNutritionViewModel.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

class IngredientNutritionViewModel: ObservableObject {
    @Published var nutrients: [Nutrient] = []
    @Published var ingredientNutrients: [IngredientNutrient] = []

    let ingredient: Ingredient

    init(ingredient: Ingredient) {
        self.ingredient = ingredient
        self.ingredientNutrients = ingredient.nutrients
    }

    func loadNutrients(context: ModelContext) {
        let descriptor = FetchDescriptor<Nutrient>(sortBy: [SortDescriptor(\.name)])
        do {
            nutrients = try context.fetch(descriptor)
        } catch {
            print("โหลดรายการสารอาหารไม่สำเร็จ: \(error)")
        }
    }

    func addNutrient(context: ModelContext, nutrient: Nutrient, value: Double) {
        // ป้องกันซ้ำ
        guard !ingredient.nutrients.contains(where: { $0.nutrient?.idNt == nutrient.idNt }) else { return }

        let newRelation = IngredientNutrient(id: Int.random(in: 10000...99999), value: value)
        newRelation.ingredient = ingredient
        newRelation.nutrient = nutrient

        context.insert(newRelation)
        ingredient.nutrients.append(newRelation)
        ingredientNutrients = ingredient.nutrients

        try? context.save()
    }

    func remove(_ relation: IngredientNutrient, context: ModelContext) {
        context.delete(relation)
        ingredient.nutrients.removeAll { $0.id == relation.id }
        ingredientNutrients = ingredient.nutrients
        try? context.save()
    }
}
