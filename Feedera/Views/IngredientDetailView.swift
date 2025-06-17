//
//  IngredientDetailView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

struct IngredientDetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel: IngredientDetailViewModel

    var body: some View {
        Form {
            // เพิ่มเข้าไปใน body ของ IngredientDetailView.swift
            Section(header: Text("โภชนาการ")) {
                NavigationLink("จัดการสารอาหาร") {
                    IngredientNutritionView(viewModel: IngredientNutritionViewModel(ingredient: viewModel.ingredient))
                }
            }

            Section {
                Button("บันทึก") {
                    viewModel.update(context: context)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .center)

                Button("ลบวัตถุดิบ", role: .destructive) {
                    viewModel.delete(context: context)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("รายละเอียดวัตถุดิบ")
    }
}
