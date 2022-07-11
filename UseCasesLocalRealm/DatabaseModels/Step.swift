//
//  Step.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/8/22.
//

import Foundation
import RealmSwift

class Step: Object, Identifiable
{
    @Persisted(primaryKey: true) var _id: ObjectId
    // useCaseId is a link to the parent use case _id value for data query purposes
    @Persisted var useCaseId: ObjectId
    @Persisted var stepId: String = EMPTY_STRING
    @Persisted var text: String = EMPTY_STRING
    @Persisted var dateCreated: Date = Date()
    @Persisted var lastUpdated: Date = Date()
    
    
    convenience init(text: String, useCaseId: ObjectId)
    {
        self.init()
        self.text = text
        self.useCaseId = useCaseId
    }
}
