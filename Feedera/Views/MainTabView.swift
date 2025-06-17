//
//  MainTabView.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    var body: some View {
        TabView {
            FormulaListView()
                .tabItem {
                    Label("สูตร", systemImage: "list.bullet.clipboard")
                }

            IngredientListView()
                .tabItem {
                    Label("วัตถุดิบ", systemImage: "leaf")
                }
            
            NutrientListView()
                .tabItem {
                    Label("สารอาหาร", systemImage: "bolt.heart")
                }
            
            SettingsView()
                .tabItem {
                    Label("ตั้งค่า", systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: [Formula.self, Ingredient.self], inMemory: true)
}
