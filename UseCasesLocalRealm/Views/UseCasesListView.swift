//
//  UseCasesListView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/10/22.
//

import RealmSwift
import SwiftUI
enum Sections: String, CaseIterable
{
    case complete = "complete"
    case incomplete = "incomplete"
}

struct UseCasesListView: View {
    // takes project for filter query purposes
    @State var project: Project
    @ObservedResults(UseCase.self) var useCases: Results<UseCase>
    var projectUseCases: [UseCase]
    {
        // filter observed results to get only project cases
        return useCases.filter { $0.underProject == project._id}
    }
    
    var completeUseCases: [UseCase]
    {
        return projectUseCases.filter { $0.isComplete == true }
    }
    var incompleteUseCases: [UseCase]
    {
        return projectUseCases.filter { $0.isComplete == false }
    }

    
    var body: some View {
        List
        {
            ForEach(Sections.allCases, id: \.self)
            {
                section in
                let filteredCases = section == .incomplete ? incompleteUseCases : completeUseCases
                
                Section
                {
                    if filteredCases.isEmpty
                    {
                        Text("No \(section.rawValue) use cases to show.")
                            .foregroundColor(.secondary)
                            .opacity(0.5)
                    }
                    else
                    {
                        ForEach(filteredCases, id: \._id)
                        {
                            useCase in
                            UseCaseCellView(useCase: useCase)
                        }
                    }
                }
            }
        }.listStyle(.plain)
    }
}

struct UseCasesListView_Previews: PreviewProvider {
    static var previews: some View {
        let project: Project = Project()
        UseCasesListView(project: project)
    }
}
