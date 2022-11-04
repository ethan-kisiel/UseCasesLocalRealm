//
//  Constants.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import Foundation

let EMPTY_STRING: String = ""
let USER_ID_STRING: String = "UserId"

let TRASH_ICON: String = "trash.circle.fill"
let UNCHECKED_ICON: String = "square"
let CHECKED_ICON: String = "square.inset.filled"
let MORE_ICON: String = "ellipsis.circle"
let LESS_ICON: String = "minus.circle"

// character amount to shorten display title to if display title > DT_SHORT
let DISP_SHORT: Int = 10
enum Priority: String, CaseIterable
{
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
