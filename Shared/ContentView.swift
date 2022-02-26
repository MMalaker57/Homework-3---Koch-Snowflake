//
//  ContentView.swift
//  Shared
//
//  Created by Matthew Malaker on 2/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var guess = ""
    @State private var totalIterations: Int? = 10
    @State private var fractalAngle: Int? = 3
    @State var editeFractalangle: Int? = 3
    @State var editedTotalIterations: Int? = 10
    @State var viewArray :[AnyView] = []
    
    private var intFormatter: NumberFormatter = {
            let f = NumberFormatter()
            f.numberStyle = .decimal
            return f
        }()
    @ObservedObject var kochSnowflakeObject = KochSnowflake(withData: true)
    @State var orderString = ""
    @State var orderInt: Int = 0
    @State var divisorString = ""
    @State var divisorDouble: Double = 1.0
    
    
    
    var body: some View {
        
        //We will have two horizontal elements. One will be a VStack for user input, and the other will be the fractal
        HStack{
            
            //User Input
            VStack{
                HStack{
                    Text("Input Fractal Iterations")
                        .padding()
                    TextField("",text: $orderString, onCommit: {orderInt = Int(orderString) ?? 1})
                        .padding()
                }
                HStack{
                    Text("Input Angle Divisor (pi/D) (Double)")
                        .padding()
                    TextField("D",text: $divisorString, onCommit: {divisorDouble = Double(divisorString) ?? 2})
                }
                Button("Calculate", action: {Task.init{await self.calculateFractal()}})
                Button("Clear", action: {self.clear()})
            }
            
            //Fractal
            FractalView(fractalVertices: $kochSnowflakeObject.kochVerticesForPath)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            Spacer()
            
            
            
        }
        
    }
    func calculateFractal() async{
        let _ = await withTaskGroup(of: Void.self) {taskGroup in
            taskGroup.addTask{
                await kochSnowflakeObject.calculatekoch(iterations: orderInt, divisorForPi: divisorDouble)
            }
            
        }
        
    }
    
    
    //Clears kochSnowflakeObject. No arguments or returns
    func clear() {
        kochSnowflakeObject.eraseData()
        kochSnowflakeObject.kochVerticesForPath.removeAll()
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
