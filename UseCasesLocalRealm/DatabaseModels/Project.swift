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
    @Persisted var title: String
    // Created by is the locally stored UserId
    @Persisted var createdBy: String
    @Persisted var dateCreated: Date = Date()
    @Persisted var lastUpdated: Date = Date()
    
    @Persisted var UseCases: List<UseCase> = List<UseCase>()
    
    convenience init(title: String, createdBy: String)
    {
        self.init()
        self.createdBy = createdBy
        self.title = title
    }
}
