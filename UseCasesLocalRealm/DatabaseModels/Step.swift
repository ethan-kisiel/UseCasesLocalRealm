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
    @Persisted var stepId: String = EMPTY_STRING
    @Persisted var text: String = EMPTY_STRING
    @Persisted var dateCreated: Date = Date()
    @Persisted var lastUpdated: Date = Date()
    
    @Persisted(originProperty: "steps") var parentUseCase: LinkingObjects<UseCase>
    
    convenience init(text: String)
    {
        self.init()
        self.text = text
    }
}
