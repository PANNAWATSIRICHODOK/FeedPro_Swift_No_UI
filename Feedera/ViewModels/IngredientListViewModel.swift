//
//  IngredientListViewModel.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

class IngredientListViewModel: ObservableObject {
    @Published var ingredients: [Ingredient] = []

    func load(_ context: ModelContext) {
        let descriptor = FetchDescriptor<Ingredient>(sortBy: [SortDescriptor(\.name)])
        do {
            ingredients = try context.fetch(descriptor)
        } catch {
            print("โหลดวัตถุดิบไม่สำเร็จ: \(error)")
        }
    }

    func addIngredient(context: ModelContext, name: String, cost: Double) {
        let newIngredient = Ingredient(idIngd: Int.random(in: 1000...9999), name: name)
        newIngredient.cost = cost
        context.insert(newIngredient)
        load(context)
    }
}
