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
    @Persisted var caseId: String = EMPTY_STRING
    @Persisted var underProject: String
    @Persisted var title: String
    @Persisted var dateCreated: Date = Date()
    @Persisted var lastUpdated: Date = Date()
    @Persisted var isComplete: Bool = false
    @Persisted var UseCases: List<Step> = List<Step>()
    
    convenience init(title: String, projectId: String)
    {
        // underProject takes a project's id as a String: underProject
        self.init()
        self.underProject = projectId
        self.title = title
    }
}
