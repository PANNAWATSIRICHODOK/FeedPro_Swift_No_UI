//
//  FormulaListViewModel.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

class FormulaListViewModel: ObservableObject {
    @Published var formulas: [Formula] = []

    func load(_ context: ModelContext) {
        let descriptor = FetchDescriptor<Formula>(sortBy: [SortDescriptor(\.name)])
        do {
            formulas = try context.fetch(descriptor)
        } catch {
            print("โหลดสูตรไม่สำเร็จ: \(error)")
        }
    }

    func addFormula(context: ModelContext, name: String, batchSize: Int) {
        let newFormula = Formula(idFm: Int.random(in: 1000...9999), name: name, batchSize: batchSize)
        context.insert(newFormula)
        load(context)
    }
}
