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
    @Persisted var title: String
    @Persisted var dateCreated: Date = Date()
    @Persisted var lastUpdated: Date = Date()
    @Persisted var priority: Priority = .medium
    @Persisted var isComplete: Bool = false
    @Persisted var steps: List<Step> = List<Step>()
    
    @Persisted(originProperty: "useCases") var parentCategory: LinkingObjects<Category>
    
    convenience init(title: String, priority: Priority)
    {
        self.init()
        self.title = title
        self.priority = priority
    }
}
