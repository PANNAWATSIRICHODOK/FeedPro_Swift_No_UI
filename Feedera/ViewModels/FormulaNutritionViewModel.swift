//
//  FormulaNutritionViewModel.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

struct NutrientSummary: Identifiable {
    var id: Int { nutrient.idNt }
    let nutrient: Nutrient
    var totalValue: Double
}

class FormulaNutritionViewModel: ObservableObject {
    @Published var summaries: [NutrientSummary] = []

    let formula: Formula

    init(formula: Formula) {
        self.formula = formula
    }

    func calculate() {
        var result: [Int: NutrientSummary] = [:]

        for rel in formula.ingredients {
            guard let ingredient = rel.ingredient,
                  let amount = rel.solutionAmount else { continue }

            for inutr in ingredient.nutrients {
                guard let nutrient = inutr.nutrient,
                      let valuePerUnit = inutr.value else { continue }

                let contribution = valuePerUnit * amount

                if let existing = result[nutrient.idNt] {
                    result[nutrient.idNt] = NutrientSummary(nutrient: nutrient, totalValue: existing.totalValue + contribution)
                } else {
                    result[nutrient.idNt] = NutrientSummary(nutrient: nutrient, totalValue: contribution)
                }
            }
        }

        summaries = result.values.sorted { $0.nutrient.name ?? "" < $1.nutrient.name ?? "" }
    }
}
