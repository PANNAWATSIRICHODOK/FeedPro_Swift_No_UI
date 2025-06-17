//
//  NutrientGroup.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

@Model
class NutrientGroup {
    @Attribute(.unique) var idNtGrp: Int
    var groupName: String?
    var lastUpdate: Date?
    var color: String?
    var position: Int?

    @Relationship var nutrients: [Nutrient] = []

    init(idNtGrp: Int, groupName: String? = nil) {
        self.idNtGrp = idNtGrp
        self.groupName = groupName
    }
}
