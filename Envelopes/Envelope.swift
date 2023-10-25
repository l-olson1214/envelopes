//
//  Envelope.swift
//  Envelopes
//
//  Created by Lindsey Olson on 8/30/23.
//

import Foundation

struct Envelope: Identifiable, Hashable {
    static var totalSavings: Double = 0.0
    
    var title: String
    var amount: Double
    var goal: Double
    var percentageComplete: Float {
        return Float(amount / goal)
    }
    var id = UUID()
    
    init(title: String, amount: Double, goal: Double, id: UUID = UUID()) {
        self.title = title
        self.amount = amount
        self.goal = goal
        self.id = id
        
        Envelope.totalSavings += self.amount
    }
    
    mutating func delete() {
        Envelope.totalSavings -= self.amount
    }
}
