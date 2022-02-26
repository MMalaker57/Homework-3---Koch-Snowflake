//
//  Koch Snow Flake.swift
//  Homework 3 - Koch Snowflake
//
//  Created by Matthew Malaker on 2/11/22.
//

import Foundation
import SwiftUI

//In order to create a koch snowflake, we need to create the points for each vertex and connect them. The connection is going to be 
class KochSnowflake: NSObject, ObservableObject{
    
    @MainActor @Published var kochVerticesForPath = [(xPoint: Double, yPoint: Double)]()
    
    @Published var timeString = ""
    @Published var enablebutton = true
    @Published var integrationsFromParents: Int?
    @Published var angleFromParent: Int?
    
    var x: CGFloat = 75
    var y: CGFloat = 100
    let pi = CGFloat(Float.pi)
    var divisorForPi = 0.0
    var angle: CGFloat = 0.0
    
    @MainActor init(withData data: Bool){
        super.init()
        kochVerticesForPath = []
    }
    
    
    func calculatekoch(iterations: Int?, divisorForPi: Double?) async {
        
        var newIterations: Int? = 0
        var newDivisorforPi: Double? = 2.0 //The default value needs to make sense
        
        if(iterations != nil && divisorForPi != nil){
            newIterations = iterations
            newDivisorforPi = divisorForPi
        }
        //An else statement is useless here because we already have good default values
        //Check if the ! is a factorial
        
        await calculateKochSnowflakeVertices(iterations: newIterations!, divisorForPi: newDivisorforPi ?? 2)
    }
    
    func calculateKochSnowflakeVertices(iterations: Int, divisorForPi: Double) async {
        
        var fractalPoints: [(xPoint: Double, yPoint: Double)] = [] //Each point is a tuple, and we need a list of them
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        let fractalSize: Double = 450
        let width: CGFloat = 600.0
        let height: CGFloat = 600.0
        let centerPoint = CGPoint(x: width/2, y: height/2)
        let verticalOffset = fractalSize/3.5 //There is a better way to do this
        
        x = centerPoint.x - CGFloat(fractalSize/2.0) // setting start x as half of the fractal size away from the center
        y = height/2.0 - CGFloat(verticalOffset) //The vertical offset is needed because the fractal grows
        
        guard iterations >= 0 else { await updateData(pathData: fractalPoints)
            return }
        guard iterations <= 15 else { await updateData(pathData: fractalPoints)
            return }
        guard divisorForPi > 0 else {await updateData(pathData: fractalPoints)
            return }
        guard divisorForPi <= 50 else {await updateData(pathData: fractalPoints)
            return }
        
        fractalPoints = KochSnowflakeCalc(fractalOrder: iterations, x: x, y: y, size: fractalSize, angleDivisor: divisorForPi)
        await updateData(pathData: fractalPoints)
        return
    }
    
    //This function is simply an alias for adding the path data. It saves space, ideally, but is technically not needed 
    @MainActor func updateData(pathData:  [(xPoint: Double, yPoint: Double)]){
        kochVerticesForPath.append(contentsOf: pathData)
    }
    
    
    //In order to clear the drawing, we need to clear the path
    @MainActor func eraseData(){
        
        Task.init {
            await MainActor.run {
                self.kochVerticesForPath.removeAll()
            }
        }

        
    }
    
}
