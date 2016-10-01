//
//  Lana.swift
//  Talana
//
//  Created by Fabian Buentello on 8/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

enum LanaType: String {
    case Columns = "columns"
    case Rows = "rows"
    case View = "view"
}

public struct Lana {

    var viewJson: JSON
    var type: LanaType?
    var spacing: CGFloat = 0
    var backgroundColor: UIColor?
    var constraints: [Constraint]
    var children: [Lana]?
    var alignment: UIStackViewAlignment?

    public init(json: JSON) {
        viewJson = json
        type = LanaType(rawValue: json["type"].stringValue)

        spacing = CGFloat(json["spacing"].floatValue)
        constraints = json["constraints"].arrayValue.flatMap({Constraint(json: $0)})
        alignment = LanaAlignment(rawValue: json["alignment"].stringValue)?.value()
        if let color = json["color"].string {
            backgroundColor = UIColor(hexString: color)
        }

        if let childrenViews = json["children"].array {
            children = childrenViews.map({Lana(json: $0)})
        }
    }
    
    public func layout(into parent: inout TalanaStackView) {
        
        if type != .View {
            var childStack = TalanaStackView()
            childStack.layout(self, useLanaSpacing: true)
            Constraint.add(constraints, toParent: &parent, fromChild: &childStack)
            return
        }
        var lView = UIView()
        lView.backgroundColor = backgroundColor
        Constraint.add(constraints, toParent: &parent, fromChild: &lView)
    }

    public func layoutChildren(into parent: inout TalanaStackView) {
        children?.forEach({ cTalana in
            cTalana.layout(into: &parent)
        })
    }
}
