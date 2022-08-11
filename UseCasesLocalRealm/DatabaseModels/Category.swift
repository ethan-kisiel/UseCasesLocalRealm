//
//  Category.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/27/22.
//

import Foundation
import RealmSwift

class Category: Object, Identifiable
{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var dateCreated: Date = Date()
    @Persisted var lastUpdated: Date = Date()
    
    @Persisted var useCases: List<UseCase> = List<UseCase>()
    
    @Persisted(originProperty: "categories") var parentProject: LinkingObjects<Project>
    
    convenience init(title: String)
    {
        self.init()
        self.title = title
    }
}

