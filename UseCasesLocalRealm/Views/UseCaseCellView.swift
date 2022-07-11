//
//  UseCaseCellView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/10/22.
//

import RealmSwift
import SwiftUI

struct UseCaseCellView: View {
    @State var useCase: UseCase
    var body: some View {
        Text(useCase.title)
    }
}

struct UseCaseCellView_Previews: PreviewProvider {
    static var previews: some View {
        let objectId = ObjectId()
        let useCase = UseCase(title:"preview", projectId: objectId, priority: .medium)
        UseCaseCellView(useCase: useCase)
    }
}
