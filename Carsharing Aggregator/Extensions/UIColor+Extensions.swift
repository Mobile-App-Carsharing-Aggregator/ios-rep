//
//  UIColor+Extensions.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 11.12.2023.
//

import UIKit

extension UIColor {
    
    static let carsharing = CarsharingColors()
    static let background = BackgroundColors()
}

struct CarsharingColors {
    let lightGreen = UIColor(named: "lightGreenColor") ?? UIColor.green
    let lightBlue = UIColor(named: "lightBlueColor") ?? UIColor.blue
    let purple = UIColor(named: "pupleColor") ?? UIColor.purple
    let mediumGreen = UIColor(named: "mediumGreenColor") ?? UIColor.green
    let cluster = UIColor(named: "clusterColor") ?? UIColor.blue
}

struct BackgroundColors {
    let white = UIColor(named: "whiteBackgroundColor") ?? UIColor.white
}

