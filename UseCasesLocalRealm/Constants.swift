//
//  Constants.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import Foundation
import RealmSwift

let EMPTY_STRING: String = ""
let USER_ID_STRING: String = "UserId"

let TRASH_ICON: String = "trash.circle.fill"
let UNCHECKED_ICON: String = "square"
let CHECKED_ICON: String = "square.inset.filled"
let MORE_ICON: String = "ellipsis.circle"
let LESS_ICON: String = "minus.circle"


enum Priority: String, CaseIterable, PersistableEnum
{
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
