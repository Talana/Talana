//
//  Lana.swift
//  Talana
//
//  Created by Fabian Buentello on 8/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

enum LanaType: String {
    
    /// Component that will contain other components in columns
    case Columns = "column"
    
    /// Component that will contain other components in rows
    case Rows = "row"
    
    /// Component that will be displayed on the view
    case View = "view"
}


/// Lana object that contains all the component information for itself and children
public struct Lana {

    /// Identifier for `Lana`. Useful if Lana has breaking constraints
    var id: String?
    
    /// Raw Json for object
    var viewJson: JSON
    
    /// `LanaType` object that determines if `Lana` is a `.Column`, `.Row`, `.View`
    var type: LanaType?
    
    /// Spacing inbetween it's children components. Does not get used if it's `type` is `.View`
    var gutter: CGFloat = 0.02
    
    /// background color for Component
    var backgroundColor: UIColor?
    
    /// Constraints that belong to `Lana` object
    var constraints: [Constraint]
    
    /// Children of `Lana` Object.
    var children: [Lana]?
    
    /// Alignment for `Lana` Object. Does not get used if it's `type` is `.View`
    var alignment: UIStackViewAlignment?

    public init(json: JSON) {
        viewJson = json
        id = json["id"].string
        type = LanaType(rawValue: json["type"].stringValue)

        if let _gutter = json["gutter"].float {
            gutter = CGFloat(_gutter)
        }
        alignment = LanaAlignment(rawValue: json["alignment"].stringValue)?.value()
        constraints = json["constraints"].arrayValue.flatMap(Constraint.init)
        backgroundColor = json["background-color"].string.flatMap { UIColor(hexString: $0) }
        children = json["children"].array?.flatMap(Lana.init)
    }
    
    
    /// Get spacing inbetween `Components`
    ///
    /// - returns: Value inbetween child `Components`
    public func getSpacing() -> CGFloat {
        if type == .Columns {
            return 0
        }
        
        return gutter * ez.screenWidth
    }
    
    /// Receive the `Component` for a `Lana`
    ///
    /// - returns: `Component`
    public func layout() -> Component {
        
        var child = Component()
        child.accessibilityIdentifier = id
        child.backgroundColor = backgroundColor
        
        if type != .View {
            var childStack = TalanaStackView()
            childStack.layout(self)
            
            child = childStack
        }
        
        return child
    }
}
