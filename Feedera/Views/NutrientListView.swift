//
//  NutrientListView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

struct NutrientListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = NutrientListViewModel()

    @State private var name: String = ""
    @State private var unit: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("เพิ่มสารอาหาร")) {
                        TextField("ชื่อสารอาหาร", text: $name)
                        TextField("หน่วย (เช่น กรัม)", text: $unit)

                        Button("เพิ่ม") {
                            guard !name.isEmpty, !unit.isEmpty else { return }
                            viewModel.addNutrient(context: context, name: name, unit: unit)
                            name = ""
                            unit = ""
                        }
                    }
                }

                List {
                    ForEach(viewModel.nutrients, id: \.idNt) { nutrient in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(nutrient.name ?? "ไม่ระบุชื่อ")
                                if let unit = nutrient.unit {
                                    Text("หน่วย: \(unit)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            Spacer()
                            Button(role: .destructive) {
                                viewModel.delete(nutrient, context: context)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
            }
            .navigationTitle("รายการสารอาหาร")
            .onAppear {
                viewModel.load(context: context)
            }
        }
    }
}
