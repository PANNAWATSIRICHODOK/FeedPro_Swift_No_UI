//
//  FormulaNutritionView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

struct FormulaNutritionView: View {
    @StateObject var viewModel: FormulaNutritionViewModel

    var body: some View {
        List(viewModel.summaries) { summary in
            HStack {
                VStack(alignment: .leading) {
                    Text(summary.nutrient.name ?? "ไม่ระบุชื่อ")
                        .font(.headline)
                    if let unit = summary.nutrient.unit {
                        Text("หน่วย: \(unit)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                Text(String(format: "%.2f", summary.totalValue))
            }
        }
        .navigationTitle("สารอาหารรวม")
        .onAppear {
            viewModel.calculate()
        }
    }
}
