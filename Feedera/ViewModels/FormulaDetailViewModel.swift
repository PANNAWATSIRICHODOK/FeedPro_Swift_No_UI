//
//  FormulaDetailViewModel.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

class FormulaDetailViewModel: ObservableObject {
    @Published var name: String
    @Published var batchSize: Int

    private(set) var formula: Formula

    init(formula: Formula) {
        self.formula = formula
        self.name = formula.name ?? ""
        self.batchSize = formula.batchSize ?? 0
    }

    func update(context: ModelContext) {
        formula.name = name
        formula.batchSize = batchSize
        try? context.save()
    }

    func delete(context: ModelContext) {
        context.delete(formula)
        try? context.save()
    }
}
