//
//  Envelope.swift
//  Envelopes
//
//  Created by Lindsey Olson on 8/30/23.
//

import Foundation

struct Envelope: Identifiable, Hashable {
    var title: String
    var amount: Double
    var goal: Double
    var percentageComplete: Float {
        return Float(amount / goal)
    }
    var id = UUID()
}
