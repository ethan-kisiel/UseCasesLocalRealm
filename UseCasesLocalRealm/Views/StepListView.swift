//
//  StepListView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/11/22.
//

import SwiftUI
import RealmSwift

struct StepListView: View {
    @State var useCase: UseCase
    @ObservedResults(Step.self) var steps: Results<Step>

    var useCaseSteps: [Step]
    {
        steps.filter { $0.useCaseId == useCase._id }
    }
    
    var body: some View {
        List
        {
            ForEach(useCaseSteps, id:\._id)
            {
                step in
                StepCellView(step: step)
            }.onDelete
            {
                indexSet in
                indexSet.forEach
                {
                    index in
                    StepManager.shared.deleteStep(step: useCaseSteps[index])
                }
            }
        }
        .listStyle(.plain)
    }
}

struct StepListView_Previews: PreviewProvider {
    static var previews: some View {
        let useCase = UseCase(title:"", projectId: ObjectId(), priority: .medium)
        StepListView(useCase: useCase)
    }
}
