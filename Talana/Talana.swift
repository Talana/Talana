//
//  Talana.swift
//  Talana
//
//  Created by Fabian Buentello on 8/10/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

public class Talana {

    class func layout(_ views: [Lana], into parent: inout TalanaStackView) {

        views.forEach { lanaView in
            guard lanaView.type != .View else {
                lanaView.layout(into: &parent)
                return
            }

            var subTalana = TalanaStackView(lana: lanaView)
            lanaView.layoutChildren(into: &subTalana)
            parent.addArrangedSubview(subTalana)
        }
    }
}
