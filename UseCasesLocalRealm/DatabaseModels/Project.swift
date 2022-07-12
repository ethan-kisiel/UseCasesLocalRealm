//
//  Project.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import Foundation
import RealmSwift

class Project: Object, Identifiable
{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var projectId: String = EMPTY_STRING
    @Persisted var title: String = EMPTY_STRING
    // Created by is the locally stored UserId (in UserDefaults)
    @Persisted var createdBy: String = getUserId()
    @Persisted var dateCreated: Date = Date()
    @Persisted var lastUpdated: Date = Date()
    
    @Persisted var useCases: List<UseCase> = List<UseCase>()
    
    convenience init(title: String, projectId: String)
    {
        self.init()
        self.title = title
        self.projectId = projectId
    }
}
