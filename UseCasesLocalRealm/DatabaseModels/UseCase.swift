//
//  UseCase.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import Foundation
import RealmSwift


class UseCase: Object, Identifiable
{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var underProject: ObjectId
    @Persisted var caseId: String = EMPTY_STRING
    @Persisted var title: String
    @Persisted var dateCreated: Date = Date()
    @Persisted var lastUpdated: Date = Date()
    @Persisted var priority: Priority = .medium
    @Persisted var isComplete: Bool = false
    @Persisted var steps: List<Step> = List<Step>()
    
    convenience init(title: String, projectId: ObjectId, priority: Priority)
    {
        // underProject takes a project's _id: ObjectId as projectId
        self.init()
        self.underProject = projectId
        self.title = title
        self.priority = priority
    }
}
