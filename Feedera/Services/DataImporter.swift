//
//  DataImporter.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SQLite3
import SwiftData

class DataImporter {
    private var db: OpaquePointer?
    private let dbPath: String

    init(path: String) {
        self.dbPath = path
    }

    func open() -> Bool {
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            return true
        }
        return false
    }

    func close() {
        sqlite3_close(db)
    }

    // MARK: - Import NutrientGroup

    func importNutrientGroups(context: ModelContext) {
        let query = "SELECT idNtGrp, groupName, lastUpdate, color, position FROM nutrient_group"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(stmt, 0))
                let name = String(cString: sqlite3_column_text(stmt, 1))
                let color = sqlite3_column_text(stmt, 3).flatMap { String(cString: $0) }
                let position = Int(sqlite3_column_int(stmt, 4))

                let group = NutrientGroup(idNtGrp: id, groupName: name)
                group.color = color
                group.position = position

                context.insert(group)
            }
            sqlite3_finalize(stmt)
            try? context.save()
        }
    }

    // MARK: - Import Nutrient

    func importNutrients(context: ModelContext) {
        let query = "SELECT idNt, idNtGrp, name, shortName, unit, factor, decimals, lastUpdate, rating, color, code FROM nutrient"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let idNt = Int(sqlite3_column_int(stmt, 0))
                let idGrp = Int(sqlite3_column_int(stmt, 1))
                let name = String(cString: sqlite3_column_text(stmt, 2))
                let unit = sqlite3_column_text(stmt, 4).flatMap { String(cString: $0) }
                let decimals = Int(sqlite3_column_int(stmt, 6))
                let rating = Int(sqlite3_column_int(stmt, 8))

                let nutrient = Nutrient(idNt: idNt, name: name)
                nutrient.unit = unit
                nutrient.decimals = decimals
                nutrient.rating = rating

                // Find group by ID
                let groupFetch = FetchDescriptor<NutrientGroup>(predicate: #Predicate { $0.idNtGrp == idGrp })
                if let group = try? context.fetch(groupFetch).first {
                    nutrient.group = group
                }

                context.insert(nutrient)
            }
            sqlite3_finalize(stmt)
            try? context.save()
        }
    }
    
    // MARK: - Import IngredientGroup

    func importIngredientGroups(context: ModelContext) {
        let query = "SELECT idIngdGrp, groupName, lastUpdate, color, position FROM ingredient_group"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(stmt, 0))
                let name = String(cString: sqlite3_column_text(stmt, 1))
                let color = sqlite3_column_text(stmt, 3).flatMap { String(cString: $0) }
                let position = sqlite3_column_text(stmt, 4).flatMap { String(cString: $0) }

                let group = IngredientGroup(idIngdGrp: id, groupName: name)
                group.color = color
                group.position = position

                context.insert(group)
            }
            sqlite3_finalize(stmt)
            try? context.save()
        }
    }

    // MARK: - Import Ingredient

    func importIngredients(context: ModelContext) {
        let query = "SELECT idIngd, idIngdGrp, name, cost, createDate, lastUpdate, rating, color, code, budgetPerUnit FROM ingredient"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(stmt, 0))
                let idGrp = Int(sqlite3_column_int(stmt, 1))
                let name = String(cString: sqlite3_column_text(stmt, 2))
                let cost = sqlite3_column_double(stmt, 3)
                let rating = Int(sqlite3_column_int(stmt, 6))

                let ingredient = Ingredient(idIngd: id, name: name)
                ingredient.cost = cost
                ingredient.rating = rating

                // เชื่อมกลุ่ม
                let groupFetch = FetchDescriptor<IngredientGroup>(predicate: #Predicate { $0.idIngdGrp == idGrp })
                if let group = try? context.fetch(groupFetch).first {
                    ingredient.group = group
                }

                context.insert(ingredient)
            }
            sqlite3_finalize(stmt)
            try? context.save()
        }
    }
    
    // MARK: - Import FormulaGroup

    func importFormulaGroups(context: ModelContext) {
        let query = "SELECT idFmGrp, groupName, lastUpdate, color, position FROM formula_group"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(stmt, 0))
                let name = sqlite3_column_text(stmt, 1).flatMap { String(cString: $0) }
                let color = sqlite3_column_text(stmt, 3).flatMap { String(cString: $0) }
                let position = sqlite3_column_int(stmt, 4)

                let group = FormulaGroup(idFmGrp: id, groupName: name)
                group.color = color
                group.position = Int(position)

                context.insert(group)
            }
            sqlite3_finalize(stmt)
            try? context.save()
        }
    }

    // MARK: - Import Formula

    func importFormulas(context: ModelContext) {
        let query = "SELECT idFm, name, batchSize, costPerUnit, createDate, lastUpdate, idFmGrp, rating, color, code, budgetPerUnit, packUom, packSize, packPrice FROM formula"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let idFm = Int(sqlite3_column_int(stmt, 0))
                let name = sqlite3_column_text(stmt, 1).flatMap { String(cString: $0) }
                let batchSize = Int(sqlite3_column_int(stmt, 2))
                let costPerUnit = sqlite3_column_double(stmt, 3)
                let idFmGrp = Int(sqlite3_column_int(stmt, 6))
                let rating = Int(sqlite3_column_int(stmt, 7))
                let color = sqlite3_column_text(stmt, 8).flatMap { String(cString: $0) }
                let code = sqlite3_column_text(stmt, 9).flatMap { String(cString: $0) }
                let budgetPerUnit = sqlite3_column_double(stmt, 10)
                let packUom = sqlite3_column_text(stmt, 11).flatMap { String(cString: $0) }
                let packSize = sqlite3_column_double(stmt, 12)
                let packPrice = sqlite3_column_double(stmt, 13)

                let formula = Formula(idFm: idFm, name: name, batchSize: batchSize)
                formula.costPerUnit = costPerUnit
                formula.rating = rating
                formula.color = color
                formula.code = code
                formula.budgetPerUnit = budgetPerUnit
                formula.packUom = packUom
                formula.packSize = packSize
                formula.packPrice = packPrice

                // เชื่อมกลุ่มสูตร
                let fetch = FetchDescriptor<FormulaGroup>(predicate: #Predicate { $0.idFmGrp == idFmGrp })
                if let group = try? context.fetch(fetch).first {
                    formula.group = group
                }

                context.insert(formula)
            }
            sqlite3_finalize(stmt)
            try? context.save()
        }
    }
    
    // MARK: - Import Formula-Ingredient Relationships

    func importFormulaIngredients(context: ModelContext) {
        let query = "SELECT idFm, idIngd, cost, minVal, maxVal, solutionAmount, position FROM formula_ingredient"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let idFm = Int(sqlite3_column_int(stmt, 0))
                let idIngd = Int(sqlite3_column_int(stmt, 1))
                let cost = sqlite3_column_double(stmt, 2)
                let minVal = sqlite3_column_double(stmt, 3)
                let maxVal = sqlite3_column_double(stmt, 4)
                let solutionAmount = sqlite3_column_double(stmt, 5)
                let position = Int(sqlite3_column_int(stmt, 6))

                // หา Formula และ Ingredient
                let formulaFetch = FetchDescriptor<Formula>(predicate: #Predicate { $0.idFm == idFm })
                let ingredientFetch = FetchDescriptor<Ingredient>(predicate: #Predicate { $0.idIngd == idIngd })

                guard let formula = try? context.fetch(formulaFetch).first,
                      let ingredient = try? context.fetch(ingredientFetch).first else {
                    continue
                }

                let rel = FormulaIngredient()
                rel.cost = cost
                rel.minVal = minVal
                rel.maxVal = maxVal
                rel.solutionAmount = solutionAmount
                rel.position = position
                rel.formula = formula
                rel.ingredient = ingredient

                context.insert(rel)
            }
            sqlite3_finalize(stmt)
            try? context.save()
        }
    }
    
    // MARK: - Import Ingredient-Nutrient Relationships

    func importIngredientNutrients(context: ModelContext) {
        let query = "SELECT idIngd, idNt, value FROM ingredient_nutrient"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let idIngd = Int(sqlite3_column_int(stmt, 0))
                let idNt = Int(sqlite3_column_int(stmt, 1))
                let value = sqlite3_column_double(stmt, 2)

                // หา Ingredient และ Nutrient
                let ingredientFetch = FetchDescriptor<Ingredient>(predicate: #Predicate { $0.idIngd == idIngd })
                let nutrientFetch = FetchDescriptor<Nutrient>(predicate: #Predicate { $0.idNt == idNt })

                guard let ingredient = try? context.fetch(ingredientFetch).first,
                      let nutrient = try? context.fetch(nutrientFetch).first else {
                    continue
                }

                let relation = IngredientNutrient(id: Int.random(in: 10000...99999), value: value)
                relation.ingredient = ingredient
                relation.nutrient = nutrient

                context.insert(relation)
            }
            sqlite3_finalize(stmt)
            try? context.save()
        }
    }
    
}
