# Live TextField Input Prediction

## Simple Swift TextField Live Input Prediction
This is an approach to get live input predictions of a SwiftUI TextField

### How to use:
Copy the file ```TextFieldPrediction.swift``` into your Project and use it by calling a
TextFieldPrediction(...). The following parameters will be needed
for it to work: 
1) ```textFieldText``` -> This is the text that is currently in the TextField (This is a parameter that is also used in the Swift implementation of TextField() )
2) ```textFieldTitle``` -> This is the grayed out text in the empty TextField 
(This is a parameter that is also used in the Swift implementation of TextField() )
3) ```predictableValues``` -> Needs to be an Array of Strings as we compare the input of the TextField which also is a String to these Strings. It can be only one Item in the Array.
4) ```predictedValue``` -> This also needs to be an Array of Strings. Should be empty when initialized. In here will be the prediction/ -s of the input of the TextField based on the *predictableValues*. 

Note: If the TextField gets multiple inputs at once. E.g. in form of a String separated by *spaces* it will make predictions on every SubString of that input and append these predictions to the *predictedValues* Array. **Altough every prediction will only occure once in the ```predictedValues```**.

### E.g. of use
![Example of TextFieldPrediction](Assets/Example.gif)

