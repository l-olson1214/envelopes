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
        VStack {
            title
            envelopeList
        }
        .frame(maxWidth: .infinity)
    }
    
    var title: some View {
        VStack {
            Text("envelopes")
                .font(.largeTitle)
            Text(viewModel.greeting)
            Text(viewModel.totalSavings)
                .font(.title2)
                .fontWeight(.bold)
                .padding()
        }
    }
    
    var envelopeList: some View {
        List {
            ForEach(viewModel.envelopes) { envelope in
                HStack {
                    Text(envelope.title)
                        .frame(maxWidth: .infinity)
                    Text("$\(String(format: "%.2f", envelope.amount))")
                        .frame(maxWidth: .infinity)
                    ProgressBar(value: envelope.percentageComplete).frame(height: 15)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
