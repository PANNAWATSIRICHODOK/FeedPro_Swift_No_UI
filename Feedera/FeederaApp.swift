//
//  FeederaApp.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import SwiftUI

@main
struct FeederaApp: App {
    var body: some Scene {
        WindowGroup {
            if UIDevice.current.userInterfaceIdiom == .pad {
                MainSplitView()
                    .modelContainer(for: [Formula.self, Ingredient.self])
            } else {
                MainTabView()
                    .modelContainer(for: [Formula.self, Ingredient.self])
            }
        }
    }
}
