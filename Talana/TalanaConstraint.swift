//
//  TalanaConstraint.swift
//  Talana
//
//  Created by Fabian Buentello on 8/13/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

enum ConstraintType: String {
    case Size = "size"
    case Margin = "margin"
    case Center = "center"
}

public struct Constraint {

    var type: ConstraintType
    var constraintJson: JSON
    typealias AttributeTuple = (value: NSNumber, attribute: NSLayoutAttribute, isColumn: Bool)
    var attributes: [AttributeTuple]

    init?(json: JSON) {

        guard let constraintType = ConstraintType(rawValue: json["type"].stringValue) else {
            return nil
        }

        let constraintDict: [String : NSLayoutAttribute] = [
            "w" : .width, "h" : .height, "l" : .left,
            "t" : .top, "r" : .right, "b" : .bottom,
            "x" : .centerX, "y" : .centerY,
            "col": .width
        ]

        constraintJson = json
        type = constraintType

        attributes = json.dictionaryObject!.flatMap({ (key, value) in
            guard let attribute = constraintDict[key] else { return nil }
            return AttributeTuple(value as! NSNumber, attribute, key == "col")
        })
    }

    static func add<T: UIView>(_ constraint: AttributeTuple, toParent parent: inout TalanaStackView, fromChild child: inout T) {

        let isSize = [.height].contains(constraint.attribute)
        var value = CGFloat(constraint.value)
        var multi:CGFloat = 1.0
        if constraint.isColumn {
            multi = value.columns(in: parent)
            value = 0
        }
        
        parent.addConstraint(NSLayoutConstraint(item: child,
                    attribute: constraint.attribute,
                    relatedBy: .equal,
                    toItem: !isSize ? parent: nil,
                    attribute: constraint.attribute,
                    multiplier: multi,
                    constant: value))
    }
    
    static func add<T: UIView>(_ constraints: [Constraint], toParent parent: inout TalanaStackView, fromChild child: inout T) {
        child.translatesAutoresizingMaskIntoConstraints = false
        parent.addArrangedSubview(child)
        
        constraints.forEach { c in
            c.attributes.forEach() { add($0, toParent: &parent, fromChild: &child) }
        }
    }
}
