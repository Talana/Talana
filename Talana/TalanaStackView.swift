//
//  TalanaStackView.swift
//  Talana
//
//  Created by Fabian Buentello on 8/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

public class TalanaStackView: UIStackView {

    /// Gutter for TalanaStackView.
    var gutter: CGFloat!

    /// Width for TalanaStackView
    var width: CGFloat! {

        let margin: CGFloat = layoutMargins.left + layoutMargins.right
        let width = ez.screenWidth - margin

        return width
    }
    
    /// Width of a single column
    var columnWidth: CGFloat! {

        let totalGutters:CGFloat = gutter * 11
        let colWidth = (width - totalGutters)/12

        return colWidth
    }

    override init (frame : CGRect) {
        super.init(frame : frame)
    }

    convenience init(lana: Lana) {
        self.init(frame:CGRect.zero)
        setOptions(from: lana)
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setOptions(from lana: Lana) {
        accessibilityIdentifier = lana.id
        let isColumn = lana.type == .Columns
        axis = isColumn ? .horizontal : .vertical
        gutter = lana.gutter * ez.screenWidth
        spacing = lana.getSpacing()
        
        // Need to figure this part out better
        distribution = isColumn ? .equalSpacing : .fillEqually
        alignment = lana.alignment ?? .fill
    }

    public func empty() {
        self.removeAllArrangedSubviews()
    }
    
    public func layout(_ lana: Lana) {
        setOptions(from: lana)
        
        var temp = self
        lana.children?.forEach { childLana in
            var child = Component()
            
            if childLana.type == .View {
                child = childLana.layout()
            } else {
                var subTalana = TalanaStackView()
                subTalana.layout(childLana)
                
                child = subTalana
            }

            Constraint.add(childLana.constraints, toParent: &temp, fromChild: &child)
        }
    }
}
