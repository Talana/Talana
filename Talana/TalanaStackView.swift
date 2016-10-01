//
//  TalanaStackView.swift
//  Talana
//
//  Created by Fabian Buentello on 8/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

public class TalanaStackView: UIStackView {

    var gutter: CGFloat! = 0.02

    var stackWidth: CGFloat! {

        let margin: CGFloat = layoutMargins.left + layoutMargins.right
        let width = ez.screenWidth - margin

        return width
    }

    var lanaCol: CGFloat! {

        let totalGutters:CGFloat = gutter * 11
        let colWidth = (stackWidth - totalGutters)/12

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
        let isColumn = lana.type == .Columns
        axis = isColumn ? .horizontal : .vertical
        gutter = lana.spacing * ez.screenWidth
        distribution = isColumn ? .equalSpacing : .fillEqually
        alignment = lana.alignment ?? .fill
    }

    public func empty() {
        self.removeAllArrangedSubviews()
    }
    
    public func layout(_ lana: Lana, useLanaSpacing: Bool = false) {

        setOptions(from: lana)
        spacing = useLanaSpacing ? lana.spacing * ez.screenWidth : 0

        var temp = self
        if let children = lana.children {
            Talana.layout(children, into: &temp)
        }
    }
}
