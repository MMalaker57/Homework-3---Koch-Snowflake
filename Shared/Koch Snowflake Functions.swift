//
//  Koch Snowflake Functions.swift
//  Homework 3 - Koch Snowflake
//
//  Created by Matthew Malaker on 2/11/22.
//

import Foundation
import SwiftUI

//This is a bank of functions needed to make and draw a koch snowflake
//We need the ability to make a line and turn the line as well as actually  calculate the sides

//We'll start with a line
//We need to have a point and angle and will return an array of points as tuples
func makeLine(length: Double, angle: CGFloat, x: CGFloat, y: CGFloat)->[(xPoint: Double, yPoint: Double)]{
    let pi = CGFloat(Float.pi)
    let endx: CGFloat = x + CGFloat(length) * cos(angle * pi / 180.0)
    let endy: CGFloat = y + CGFloat(length) * sin(angle * pi / 180.0)
    return([(xPoint: Double(endx), yPoint: Double(endy))])
}

///Parameters:
/// - angle: the initial angle
/// - angleChange: the amount hte angle will change
/// Returns:
///  - angle+angleChange
func turn(angle: CGFloat, angleChange: Double)->CGFloat{
    return angle + CGFloat(angleChange)
}

func KochSnowflakeCalc(fractalOrder: Int, x: CGFloat, y: CGFloat, size: Double, angleDivisor: Double)->[(xPoint: Double, yPoint: Double)]{
    
    var pointsList: [(xPoint: Double, yPoint: Double)] = []
    var currentX = x
    var currentY = y
    var angle: CGFloat = 0.0
    var angleChange: CGFloat = 0.0
    
    //Each side needs to be calculated. This can be coded in different ways, but we only need a three sided figure, so we will hard-code three
    
    //Side 1
    angleChange = 60.0
    pointsList += calculateSnowflakeSide(angle: &angle, angleChange: &angleChange, fractalOrder: fractalOrder, currentX: &currentX, currentY: &currentY, size: size, angledivisor: angleDivisor)
    
    //Side 2
    angleChange = -120.0
    pointsList += calculateSnowflakeSide(angle: &angle, angleChange: &angleChange, fractalOrder: fractalOrder, currentX: &currentX, currentY: &currentY, size: size, angledivisor: angleDivisor)
    
    //Side 3
    angleChange = -120.0
    pointsList += calculateSnowflakeSide(angle: &angle, angleChange: &angleChange, fractalOrder: fractalOrder, currentX: &currentX, currentY: &currentY, size: size, angledivisor: angleDivisor)
    
    return pointsList
}
func calculateSnowflakeSide(angle: inout CGFloat, angleChange: inout CGFloat, fractalOrder: Int, currentX: inout CGFloat, currentY: inout CGFloat, size: Double, angledivisor: Double) -> [(xPoint: Double, yPoint: Double)]{
    
    var currentPoint: [(xPoint: Double, yPoint: Double)] = []
    
    angle = turn(angle: angle, angleChange: angleChange)
    currentPoint += kochSide(fractalOrder: fractalOrder, x: currentX, y: currentY, angle: angle, size: size, divisorForAngle: angledivisor)
    currentX = CGFloat(currentPoint[currentPoint.endIndex-1].xPoint)
    currentY = CGFloat(currentPoint[currentPoint.endIndex-1].yPoint)
    return (currentPoint)
    
}

func kochSide(fractalOrder: Int, x: CGFloat, y: CGFloat, angle: CGFloat, size: Double, divisorForAngle: Double) -> [(xPoint: Double, yPoint: Double)] {
    var currentAngle = angle
    var currentX = x
    var currentY = y
    let divisorForPi = divisorForAngle
    var currentPoint: [(xPoint: Double, yPoint: Double)] = []
    
    if(fractalOrder == 0){
        currentPoint += makeLine(length: size, angle: angle, x: currentX, y: currentY)
        return(currentPoint)
    }
    else{
        let theta = Double.pi/Double(divisorForPi)
        let thetaInDegrees = theta * 180.0 / Double.pi
        let newSideLength = size/(2.0*(1.0+sin(((theta))/2.0)))
        
        currentPoint += kochSide(fractalOrder: fractalOrder-1, x: currentX, y: currentY, angle: currentAngle, size: newSideLength, divisorForAngle: divisorForPi)
        currentX = CGFloat(currentPoint[currentPoint.endIndex-1].xPoint)
        currentY = CGFloat(currentPoint[currentPoint.endIndex-1].yPoint)
        currentAngle = turn(angle: currentAngle, angleChange: (90.0-thetaInDegrees/2.0))
        
        currentPoint += kochSide(fractalOrder: fractalOrder-1, x: currentX, y: currentY, angle: currentAngle, size: newSideLength, divisorForAngle: divisorForPi)
        currentX = CGFloat(currentPoint[currentPoint.endIndex-1].xPoint)
        currentY = CGFloat(currentPoint[currentPoint.endIndex-1].yPoint)
        currentAngle = turn(angle: currentAngle, angleChange: -(180.0-thetaInDegrees))
        
        currentPoint += kochSide(fractalOrder: fractalOrder-1, x: currentX, y: currentY, angle: currentAngle, size: newSideLength, divisorForAngle: divisorForPi)
        currentX = CGFloat(currentPoint[currentPoint.endIndex-1].xPoint)
        currentY = CGFloat(currentPoint[currentPoint.endIndex-1].yPoint)
        currentAngle = turn(angle: currentAngle, angleChange: (90.0-thetaInDegrees/2.0))
        
        currentPoint += kochSide(fractalOrder: fractalOrder-1, x: currentX, y: currentY, angle: currentAngle, size: newSideLength, divisorForAngle: divisorForPi)
    }
    return(currentPoint)
}












