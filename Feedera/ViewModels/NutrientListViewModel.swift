//
//  NutrientListViewModel.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

class NutrientListViewModel: ObservableObject {
    @Published var nutrients: [Nutrient] = []

    func load(context: ModelContext) {
        let descriptor = FetchDescriptor<Nutrient>(sortBy: [SortDescriptor(\Nutrient.name)])
        do {
            nutrients = try context.fetch(descriptor)
        } catch {
            print("โหลดสารอาหารไม่สำเร็จ: \(error)")
        }
    }

    func addNutrient(context: ModelContext, name: String, unit: String) {
        let new = Nutrient(idNt: Int.random(in: 10000...99999), name: name)
        new.unit = unit
        context.insert(new)  // ✅ ใช้แบบไม่มี label
        try? context.save()
        load(context: context)
    }

    func delete(_ nutrient: Nutrient, context: ModelContext) {
        context.delete(nutrient)  // ✅ ใช้แบบไม่มี label
        nutrients.removeAll { $0.idNt == nutrient.idNt }
        try? context.save()
    }
}
