//
//  Routine.swift
//  WorkoutPlannerApp
//
//  Created by Studio on 4/23/25.
//

import Foundation

struct Routine: Codable {
    let name: String
    let notes: String?
    let lastUsed: Date?
    let exercises: [Exercise]
}
