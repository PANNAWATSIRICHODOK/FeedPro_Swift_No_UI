//
//  FormulaListView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

struct FormulaListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = FormulaListViewModel()

    @State private var newFormulaName: String = ""
    @State private var newBatchSize: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("เพิ่มสูตรใหม่")) {
                        TextField("ชื่อสูตร", text: $newFormulaName)
                        TextField("ขนาด Batch", text: $newBatchSize)
                            .keyboardType(.numberPad)
                        Button("เพิ่มสูตร") {
                            if let size = Int(newBatchSize) {
                                viewModel.addFormula(context: context, name: newFormulaName, batchSize: size)
                                newFormulaName = ""
                                newBatchSize = ""
                            }
                        }
                    }
                }

                // แทน List เดิมใน FormulaListView.swift
                List(viewModel.formulas, id: \.idFm) { formula in
                    NavigationLink(destination: FormulaDetailView(viewModel: FormulaDetailViewModel(formula: formula))) {
                        VStack(alignment: .leading) {
                            Text(formula.name ?? "สูตรไม่มีชื่อ")
                                .font(.headline)
                            if let batchSize = formula.batchSize {
                                Text("Batch Size: \(batchSize)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("รายการสูตร")
            .onAppear {
                viewModel.load(context)
            }
        }
    }
}
