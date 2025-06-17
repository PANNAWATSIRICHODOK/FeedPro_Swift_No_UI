//
//  SettingsView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var context
    @State private var importMessage: String = ""
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("นำเข้าข้อมูล")) {
                    Button("Import จาก plain.sqlite") {
                        importFromSQLite()
                    }
                }

                if !importMessage.isEmpty {
                    Section {
                        Text(importMessage)
                            .foregroundColor(.green)
                    }
                }
            }
            .navigationTitle("ตั้งค่า")
            .alert("Import สำเร็จ", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    private func importFromSQLite() {
        guard let path = Bundle.main.path(forResource: "plain", ofType: "sqlite") else {
            importMessage = "ไม่พบไฟล์ plain.sqlite"
            return
        }

        let importer = DataImporter(path: path)
        if importer.open() {
            importer.importNutrientGroups(context: context)
            importer.importNutrients(context: context)
            importer.importIngredientGroups(context: context)
            importer.importIngredients(context: context)
            importer.importIngredientNutrients(context: context)
            importer.importFormulaGroups(context: context)
            importer.importFormulas(context: context)
            importer.importFormulaIngredients(context: context)
            importer.close()

            importMessage = "นำเข้าข้อมูลสำเร็จ"
            showAlert = true
        } else {
            importMessage = "ไม่สามารถเปิดฐานข้อมูล"
        }
    }
}
