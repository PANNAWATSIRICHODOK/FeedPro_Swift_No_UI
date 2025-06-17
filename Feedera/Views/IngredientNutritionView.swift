//
//  IngredientNutritionView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

struct IngredientNutritionView: View {
    @Environment(\.modelContext) private var context
    @StateObject var viewModel: IngredientNutritionViewModel

    @State private var selectedNutrient: Nutrient?
    @State private var valueText: String = ""

    var body: some View {
        Form {
            Section(header: Text("เพิ่มสารอาหาร")) {
                Picker("เลือกสารอาหาร", selection: $selectedNutrient) {
                    Text("เลือก...").tag(Nutrient?.none)
                    ForEach(viewModel.nutrients, id: \.idNt) { nutrient in
                        Text(nutrient.name ?? "ไม่มีชื่อ").tag(nutrient as Nutrient?)
                    }
                }

                TextField("ค่า (เช่น 10.5)", text: $valueText)
                    .keyboardType(.decimalPad)

                Button("เพิ่ม") {
                    if let nutrient = selectedNutrient, let val = Double(valueText) {
                        viewModel.addNutrient(context: context, nutrient: nutrient, value: val)
                        selectedNutrient = nil
                        valueText = ""
                    }
                }
            }

            Section(header: Text("รายการสารอาหาร")) {
                ForEach(viewModel.ingredientNutrients, id: \.id) { rel in
                    HStack {
                        Text(rel.nutrient?.name ?? "ไม่รู้จัก")
                        Spacer()
                        Text(String(format: "%.2f", rel.value ?? 0))
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
        .navigationTitle("สารอาหารในวัตถุดิบ")
        .onAppear {
            viewModel.loadNutrients(context: context)
        }
    }
}
