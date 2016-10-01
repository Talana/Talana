//
//  Attribute.swift
//  Talana
//
//  Created by Fabian Buentello on 10/1/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import Foundation

enum AttributeType: String {
    /// AttributeType is `Width`
    case w
    
    /// AttributeType is `Height`
    case h
    
    /// AttributeType is `Left`
    case l
    
    /// AttributeType is `Top`
    case t
    
    /// AttributeType is `Right`
    case r
    
    /// AttributeType is `Bottom`
    case b
    
    /// AttributeType is `Column`
    case col
    
    /// Map `AttributeType` to `NSLayoutAttribute`
    func layoutAttr() -> NSLayoutAttribute {
        switch self {
        case .w, .col: return .width
        case .h: return .height
        case .l: return .left
        case .t: return .top
        case .r: return .right
        case .b: return .bottom
        }
    }
}

/// Individual Attributes for a `TalanaConstraint`
public struct Attribute {
    
    /// Key for attributes. Examples: `h`, `w`, `col`, `l`
    var type: AttributeType!
    
    /// The type of `NSLayoutAttribute` the attribute is. Examples: `.height`, `.width`, `.left`
    var layoutType: NSLayoutAttribute!
    
    /// What type of relation does the attribute have to it's item.
    var relation: NSLayoutRelation!
    var rawValue: CGFloat!
    
    var constant: CGFloat! {
        if type == .col {
            return 0.0
        }
        return rawValue
    }
    
    init?(key _key: String, value _value: Any) {
        
        guard let _type = AttributeType(rawValue: _key),
            let val = (_value as? NSNumber).map(CGFloat.init)
            else { return nil }
        type = _type
        rawValue = val
        
        /// TODO: determine if should be ==, >=, <=, >, etc.
        relation = .equal
    }
}
