//
//  FormulaGroup.swift
//  Feedera
//
//  Created by bic-pannawat on 17/6/2568 BE.
//

import Foundation
import SwiftData

@Model
class FormulaGroup {
    @Attribute(.unique) var idFmGrp: Int
    var groupName: String?
    var lastUpdate: Date?
    var color: String?
    var position: Int?

    @Relationship var formulas: [Formula] = []

    init(idFmGrp: Int, groupName: String? = nil) {
        self.idFmGrp = idFmGrp
        self.groupName = groupName
    }
}
