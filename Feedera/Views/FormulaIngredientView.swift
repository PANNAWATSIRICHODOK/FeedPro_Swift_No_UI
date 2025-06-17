//
//  FormulaIngredientView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

struct FormulaIngredientView: View {
    @Environment(\.modelContext) private var context
    @StateObject var viewModel: FormulaIngredientViewModel

    @State private var selectedIngredient: Ingredient?
    @State private var amountText: String = ""

    var body: some View {
        Form {
            Section(header: Text("เพิ่มวัตถุดิบในสูตร")) {
                Picker("เลือกวัตถุดิบ", selection: $selectedIngredient) {
                    Text("เลือก...").tag(Ingredient?.none)
                    ForEach(viewModel.allIngredients, id: \.idIngd) { ing in
                        Text(ing.name ?? "ไม่มีชื่อ").tag(ing as Ingredient?)
                    }
                }

                TextField("ปริมาณที่ใช้", text: $amountText)
                    .keyboardType(.decimalPad)

                Button("เพิ่ม") {
                    if let ing = selectedIngredient, let amt = Double(amountText) {
                        viewModel.addIngredient(context: context, ingredient: ing, amount: amt)
                        selectedIngredient = nil
                        amountText = ""
                    }
                }
            }

            Section(header: Text("วัตถุดิบในสูตร")) {
                ForEach(viewModel.ingredientsInFormula, id: \.id) { rel in
                    HStack {
                        Text(rel.ingredient?.name ?? "ไม่มีชื่อ")
                        Spacer()
                        Text(String(format: "%.2f หน่วย", rel.solutionAmount ?? 0))
                        Button(role: .destructive) {
                            viewModel.remove(rel, context: context)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(.borderless)
                    }
                }
            }
        }
        .navigationTitle("วัตถุดิบในสูตร")
        .onAppear {
            viewModel.loadIngredients(context: context)
        }
    }
}
