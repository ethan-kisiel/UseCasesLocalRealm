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

    var useCaseSteps: Results<Step>
    {
        steps.where {$0.parentUseCase._id == useCase._id }
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
        let useCase = UseCase(title: "", priority: .medium)
        StepListView(useCase: useCase)
    }
}
