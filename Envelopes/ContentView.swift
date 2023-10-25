//
//  ContentView.swift
//  Envelopes
//
//  Created by Lindsey Olson on 8/30/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State var progressValue: Float = 25.0
    @State private var isShowingSheet = false
    
    @State private var envelopeName: String = ""
    @State private var currentAmount: String = ""
    @State private var goalAmount: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                title
                envelopeList
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGreen).opacity(0.5))
        }
    }
    
    var title: some View {
        VStack {
            Text("envelopes")
                .font(.largeTitle)
            Text(viewModel.greeting)
        }
    }
    
    var envelopeList: some View {
        List {
            Text(viewModel.totalSavings)
                .font(.title2)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
            
            ForEach(viewModel.envelopes) { envelope in
                HStack {
                    Text(envelope.title)
                        .frame(maxWidth: .infinity)
                    Text("$\(String(format: "%.2f", envelope.amount))")
                        .frame(maxWidth: .infinity)
                    ProgressBar(value: envelope.percentageComplete).frame(height: 15)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    viewModel.removeEnvelope(at: index)
                }
          }
            
            Button("New Envelope") {
                isShowingSheet.toggle()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 0.5, green: 1.9, blue: 0.9))
            .clipShape(Capsule())
        }
        .sheet(isPresented: $isShowingSheet) {
            sheet
        }
    }
    
    private var sheet: some View {
        VStack {
            Text("Add a new envelope")
                .font(.title2)
            
            TextField(
                "Envelope Name",
                text: $envelopeName
            )
            
            TextField (
                "Current Amount (0.00)",
                text: $currentAmount
            )
            
            TextField (
                "Goal Amount (0.00",
                text: $goalAmount
            )
            
            HStack {
                Button("Cancel", action:
                {
                    isShowingSheet.toggle()
                    clearEnvelope()
                })
                .bottomButton()
                
                Button("Save", action:
                {
                    viewModel.createNewEnvelope(name: envelopeName, current: currentAmount, goal: goalAmount)
                    isShowingSheet.toggle()
                    clearEnvelope()
                })
                .bottomButton()
            }
            
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    func clearEnvelope() {
        envelopeName = ""
        currentAmount = ""
        goalAmount = ""
    }
}

extension View {
    func bottomButton() -> some View {
        modifier(BottomButtons())
    }
}

struct BottomButtons: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 0.5, green: 1.9, blue: 0.9))
            .clipShape(Capsule())
            .foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
