//
//  ContentViewModel.swift
//  Envelopes
//
//  Created by Lindsey Olson on 8/30/23.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var totalSavings: String
    @Published var envelopes: [Envelope]
    
    var timeOfDay: String {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
        let hourInt = Int(currentHour.description)!
        
        switch hourInt {
        case 0...12:
            return "morning"
        case 12...16:
            return "afternoon"
        case 16...20:
            return "evening"
        default:
            return "night"
        }
    }
    
    var greeting: String {
        return "Good \(timeOfDay)!"
    }
    
    init() {
        self.envelopes = [
            Envelope(title: "New Car", amount: 527.2, goal: 1500),
            Envelope(title: "Vacation", amount: 727.16, goal: 1250)
        ]
        
        self.totalSavings = "$0"
        updateTotalSavings()
    }
    
    func updateTotalSavings() {
        totalSavings = "$\(String(format: "%.2f", Envelope.totalSavings))"
    }
    
    func removeEnvelope(at index: Int) {
        if index >= 0 && index < envelopes.count {
            var deletedEnvelope = envelopes.remove(at: index)
            deletedEnvelope.delete()
            updateTotalSavings()
        }
    }
    
    func createNewEnvelope(name: String?, current: String?, goal: String?) {
        guard let name = name,
              let current = current,
              let goal = goal else {
            print("error")
            return
        }
        guard let doubleCurrent = Double(current) else { return }
        guard let doubleGoal = Double(goal) else { return }
        
        let newEnvelope = Envelope(title: name, amount: doubleCurrent, goal: doubleGoal)
        envelopes.append(newEnvelope)
        
        updateTotalSavings()
    }
    
}
