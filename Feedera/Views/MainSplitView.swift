//
//  MainSplitView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

enum SidebarSection: String, CaseIterable, Identifiable {
    case formulas = "สูตร"
    case ingredients = "วัตถุดิบ"
    case nutrients = "สารอาหาร"
    case settings = "ตั้งค่า"

    var id: String { self.rawValue }
}

struct MainSplitView: View {
    @State private var selection: SidebarSection? = .formulas

    var body: some View {
        NavigationSplitView {
            List(SidebarSection.allCases, selection: $selection) { section in
                Label(section.rawValue, systemImage: icon(for: section))
                    .tag(section)
            }
            .navigationTitle("Feedera")
        } content: {
            Group {
                switch selection {
                case .formulas:
                    FormulaListView()
                case .ingredients:
                    IngredientListView()
                case .nutrients:
                    NutrientListView()
                case .settings:
                    SettingsView()
                case .none:
                    Text("กรุณาเลือกเมนูจากด้านซ้าย")
                }
            }
        } detail: {
            Text("เลือกสิ่งที่ต้องการจากรายการ") // ใช้ร่วมกับ NavigationLink ใน List
        }
    }

    private func icon(for section: SidebarSection) -> String {
        switch section {
        case .formulas: return "list.bullet.clipboard"
        case .ingredients: return "leaf"
        case .nutrients: return "bolt.heart"
        case .settings: return "gear"
        }
    }
}
