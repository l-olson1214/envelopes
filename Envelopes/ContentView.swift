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
            
            Button("New Envelopea") {
                print("Add")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 0.5, green: 1.9, blue: 0.9))
            .clipShape(Capsule())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
