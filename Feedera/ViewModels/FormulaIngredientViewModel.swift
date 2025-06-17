//
//  FormulaIngredientViewModel.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

class FormulaIngredientViewModel: ObservableObject {
    @Published var ingredientsInFormula: [FormulaIngredient] = []
    @Published var allIngredients: [Ingredient] = []

    let formula: Formula

    init(formula: Formula) {
        self.formula = formula
        self.ingredientsInFormula = formula.ingredients
    }

    func loadIngredients(context: ModelContext) {
        let descriptor = FetchDescriptor<Ingredient>(sortBy: [SortDescriptor(\.name)])
        do {
            allIngredients = try context.fetch(descriptor)
        } catch {
            print("โหลดวัตถุดิบทั้งหมดไม่สำเร็จ: \(error)")
        }
    }

    func addIngredient(context: ModelContext, ingredient: Ingredient, amount: Double) {
        // ห้ามซ้ำ
        guard !formula.ingredients.contains(where: { $0.ingredient?.idIngd == ingredient.idIngd }) else { return }

        let relation = FormulaIngredient(cost: ingredient.cost ?? 0)
        relation.ingredient = ingredient
        relation.formula = formula
        relation.solutionAmount = amount

        context.insert(relation)
        formula.ingredients.append(relation)
        ingredientsInFormula = formula.ingredients
        try? context.save()
    }

    func remove(_ rel: FormulaIngredient, context: ModelContext) {
        context.delete(rel)
        formula.ingredients.removeAll { $0.id == rel.id }
        ingredientsInFormula = formula.ingredients
        try? context.save()
    }
}
