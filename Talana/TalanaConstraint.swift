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
}

public struct Constraint {

    /// What type of Constraint it is. Can be `.Size`, `.Margin`, or `.Center`
    var type: ConstraintType

    /// Contains the all the raw json for `Constraint` object
    var constraintJson: JSON!

    /// The attributes for the Constraint. Example: `"h": 100`
    var attributes: [Attribute]?

    
    init?(json: JSON) {

        guard let constraintType = ConstraintType(rawValue: json["type"].stringValue) else { return nil }

        type = constraintType
        constraintJson = json
        
        attributes = constraintJson.dictionaryObject!.flatMap(Attribute.init)
    }

    
    /// Add constraint to a parent(`TalanaStackView`) object from a child(`Component` or `TalanaStackView`)
    ///
    /// - parameter attr:   Attribute object that we're apply to the parent/child views
    /// - parameter parent: TalanaStackView object
    /// - parameter child:  Generic object that must be a subclass of `Component`
    static func addConstraint<T: Component>(using attr: Attribute, toParent parent: inout TalanaStackView, fromChild child: inout T) {

        var item: TalanaStackView? = parent;
        var multiplier: CGFloat = 1.0
        
        if attr.type.layoutAttr() == .height {
            item = nil
        }
        if attr.type == .col {
            multiplier = attr.rawValue.columns(in: parent)
        }
        
        let constraint = NSLayoutConstraint(item: child,
                                            attribute: attr.type.layoutAttr(),
                                            relatedBy: attr.relation,
                                            toItem: item,
                                            attribute: attr.type.layoutAttr(),
                                            multiplier: multiplier,
                                            constant: attr.constant)

        parent.addConstraint(constraint)
    }

    
    /// Add array of `Constraint` to a parent(`TalanaStackView`) object from a child(`Component` or `TalanaStackView`)
    ///
    /// - parameter constraints: Array of `Constraint`
    /// - parameter parent:      TalanaStackView Object
    /// - parameter child:       Generic object that must be a subclass of `Component`
    static func add<T: Component>(_ constraints: [Constraint], toParent parent: inout TalanaStackView, fromChild child: inout T) {
        child.translatesAutoresizingMaskIntoConstraints = false
        parent.addArrangedSubview(child)

        constraints.forEach { c in
            c.attributes?.forEach() { addConstraint(using: $0, toParent: &parent, fromChild: &child) }
        }
    }
}
