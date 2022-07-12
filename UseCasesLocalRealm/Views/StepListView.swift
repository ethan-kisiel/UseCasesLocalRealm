//
//  StepListView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/11/22.
//

import RealmSwift
import SwiftUI

struct StepListView: View
{
    @State var useCase: UseCase
    @ObservedResults(Step.self) var steps: Results<Step>

    var useCaseSteps: [Step]
    {
        steps.filter { $0.useCaseId == useCase._id }
    }

    var body: some View
    {
        if useCaseSteps.isEmpty
        {
            Text("No steps to display.")
        }
        else
        {
            List
            {
                ForEach(useCaseSteps, id: \._id)
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
            .padding()
        }
    }
}

struct StepListView_Previews: PreviewProvider
{
    static var previews: some View
    {
        let useCase = UseCase(title: "", projectId: ObjectId(), priority: .medium)
        StepListView(useCase: useCase)
    }
}
