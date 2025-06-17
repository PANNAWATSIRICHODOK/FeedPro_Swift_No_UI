//
//  IngredientListView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

struct IngredientListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = IngredientListViewModel()

    @State private var newIngredientName: String = ""
    @State private var newCost: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("เพิ่มวัตถุดิบใหม่")) {
                        TextField("ชื่อวัตถุดิบ", text: $newIngredientName)
                        TextField("ต้นทุน (บาท)", text: $newCost)
                            .keyboardType(.decimalPad)

                        Button("เพิ่มวัตถุดิบ") {
                            if let cost = Double(newCost) {
                                viewModel.addIngredient(context: context, name: newIngredientName, cost: cost)
                                newIngredientName = ""
                                newCost = ""
                            }
                        }
                    }
                }

                // แทน List เดิมใน IngredientListView.swift
                List(viewModel.ingredients, id: \.idIngd) { ingredient in
                    NavigationLink(destination: IngredientDetailView(viewModel: IngredientDetailViewModel(ingredient: ingredient))) {
                        VStack(alignment: .leading) {
                            Text(ingredient.name ?? "ไม่มีชื่อ")
                                .font(.headline)
                            if let cost = ingredient.cost {
                                Text(String(format: "ต้นทุน: ฿%.2f", cost))
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("รายการวัตถุดิบ")
            .onAppear {
                viewModel.load(context)
            }
        }
    }
}
