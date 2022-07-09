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
    // projectId is a link to the parent use case _id value for data query purposes
    @Persisted var projectId: ObjectId
    @Persisted var stepId: String = EMPTY_STRING
    @Persisted var text: String = EMPTY_STRING
    @Persisted var dateCreated: Date = Date()
    @Persisted var lastUpdated: Date = Date()
    
    
    convenience init(text: String, projectId: ObjectId)
    {
        self.init()
        self.text = text
        self.projectId = projectId
    }
}
