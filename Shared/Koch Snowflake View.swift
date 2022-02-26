//
//  Koch Snowflake View.swift
//  Homework 3 - Koch Snowflake
//
//  Created by Matthew Malaker on 2/11/22.
//

import Foundation
import SwiftUI

struct FractalView: View{
    @Binding var fractalVertices: [(xPoint: Double, yPoint: Double)]
    var body: some View{
        
        fractalShape(fractalPoints: fractalVertices)
            .stroke(Color.orange, lineWidth: 1) //Describe the line
            .frame(width: 600, height: 600) //describe a bounding box
            .background(Color.white) //describing a background
        
    }
    
    struct fractalShape: Shape {
        var fractalPoints: [(xPoint: Double, yPoint: Double)] = []
        
        func path(in rect: CGRect) -> Path{
            var path = Path()//initialize path as path
            if fractalPoints.isEmpty{
                return path
            }
            
            path.move(to: CGPoint(x: fractalPoints[0].xPoint, y: fractalPoints[0].yPoint))
            
            for iterator in 1..<(fractalPoints.endIndex){
                path.addLine(to: CGPoint(x: fractalPoints[iterator].xPoint, y: fractalPoints[iterator].yPoint))
            }
            
            return (path)
        }
    }
    
    
    
}
