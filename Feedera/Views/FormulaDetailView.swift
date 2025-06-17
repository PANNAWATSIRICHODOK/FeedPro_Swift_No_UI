//
//  FormulaDetailView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

struct FormulaDetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel: FormulaDetailViewModel

    var body: some View {
        Form {
            // เพิ่มเข้าไปใน body ของ FormulaDetailView.swift
            Section(header: Text("จัดการสูตร")) {
                NavigationLink("จัดการวัตถุดิบในสูตร") {
                    FormulaIngredientView(viewModel: FormulaIngredientViewModel(formula: viewModel.formula))
                }

                NavigationLink("ดูสารอาหารรวมของสูตร") {
                    FormulaNutritionView(viewModel: FormulaNutritionViewModel(formula: viewModel.formula))
                }
            }

            Section {
                Button("บันทึกการแก้ไข") {
                    viewModel.update(context: context)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .center)

                Button("ลบสูตรนี้", role: .destructive) {
                    viewModel.delete(context: context)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("รายละเอียดสูตร")
    }
}
