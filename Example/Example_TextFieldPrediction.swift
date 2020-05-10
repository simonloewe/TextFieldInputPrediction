//
//  ContentView.swift
//  StackOverflow
//
//  Created by Simon Löwe on 04.04.20.
//  Copyright © 2020 Simon Löwe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var textFieldText: String = ""
    @State var textFieldTitle: String = "Title"
    @State var predictableValues: Array<String> = ["First", "Second", "Third", "Fourth"]
    @State var predictedValue: Array<String> = []
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Predictable Values: ").bold()
            
            HStack{
                ForEach(self.predictableValues, id: \.self){ value in
                    Text(value)
                }
            }
            
            TextFieldPrediction(textFieldText: self.$textFieldText,
                            textFieldTitle: self.$textFieldTitle,
                            predictableValues: self.$predictableValues,
                            predictedValue: self.$predictedValue)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            ForEach(self.predictedValue, id: \.self){ value in
                Text("Predicted Value: \(value)")
            }
        }.padding()
    }
}

struct TextFieldPrediction: View {
    
    @Binding var textFieldText: String
    @Binding var textFieldTitle: String
    @Binding var predictableValues: Array<String>
    @Binding var predictedValue: Array<String>
    
    @State var isEditing: Bool = false
    
    var body: some View {
        TextField(self.textFieldTitle, text: self.$textFieldText, onEditingChanged: { status in self.realTimePrediction(status: status)}, onCommit: { self.makePrediction()})
    }
    
    func realTimePrediction(status: Bool) {
        self.isEditing = status
        if status == true {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.makePrediction()
                
                if self.isEditing == false {
                    timer.invalidate()
                }
            }
        }
    }
    
    func capitalizeFirstLetter(smallString: String) -> String {
        return smallString.prefix(1).capitalized + smallString.dropFirst()
    }
    
    func makePrediction() {
        self.predictedValue = []
        if !self.textFieldText.isEmpty{
            for item in self.predictableValues {
                if self.textFieldText.split(separator: " ").count > 1 {
                    self.makeMultiPrediction(item: item)
                }else {
                    if item.contains(self.textFieldText) || item.contains(self.capitalizeFirstLetter(smallString: self.textFieldText)){
                        if !self.predictedValue.contains(String(item)) {
                            self.predictedValue.append(String(item))
                        }
                    }
                }
            }
        }
    }
    
    func makeMultiPrediction(item: String) {
        for subString in self.textFieldText.split(separator: " ") {
            if item.contains(String(subString)) || item.contains(self.capitalizeFirstLetter(smallString: String(subString))){
                if !self.predictedValue.contains(item) {
                    self.predictedValue.append(item)
                }
            }
        }
    }
}
