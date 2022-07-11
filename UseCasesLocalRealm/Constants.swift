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

enum Priority: String, CaseIterable, PersistableEnum
{
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
