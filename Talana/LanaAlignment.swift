//
//  LanaAlignment.swift
//  Talana
//
//  Created by Fabian Buentello on 8/14/16.
//  Copyright © 2016 Fabian Buentello. All rights reserved.
//

import UIKit

enum LanaAlignment: String {
    /* Align the leading and trailing edges of vertically stacked items
     or the top and bottom edges of horizontally stacked items tightly to the container.
     */
    case Fill

    /* Align the leading edges of vertically stacked items
     or the top edges of horizontally stacked items tightly to the relevant edge
     of the container
     */
    case Top
    case Leading
    case FirstBaseline // Valid for horizontal axis only

    /* Center the items in a vertical stack horizontally
     or the items in a horizontal stack vertically
     */
    case Center

    /* Align the trailing edges of vertically stacked items
     or the bottom edges of horizontally stacked items tightly to the relevant
     edge of the container
     */
    case Trailing
    case Bottom
    case LastBaseline // Valid for horizontal axis only

    func value() -> UIStackViewAlignment? {
        let dict: [LanaAlignment : UIStackViewAlignment] = [
            .Fill: .fill,
            .Top: .leading,
            .Leading: .leading,
            .FirstBaseline: .firstBaseline,
            .Center: .center,
            .Bottom: .trailing,
            .Trailing: .trailing,
            .LastBaseline: .lastBaseline
        ]
        return dict[self]
    }
}
