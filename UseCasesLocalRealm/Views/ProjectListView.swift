//
//  ProjectListView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import RealmSwift
import SwiftUI

struct ProjectListView: View {
    @ObservedResults(Project.self) var projects
    var body: some View {
        if projects.isEmpty
        {
            Text("No projects to display")
        }
        else
        {
            List
            {
                ForEach(projects, id: \._id)
                {
                    project in
                    
                    ProjectCellView(project: project)
                        .navigationDestination(for: Route.self)
                    { route in
                        switch route
                        {
                            case .projects:
                                ProjectsView()
                            case .project(let project):
                                ProjectDetailsView(project: project)
                            case .useCase(let useCase):
                                Text("\(useCase.title)")
                        }
                    }
                }
                .onDelete {
                    indexSet in
                    indexSet.forEach
                    {
                        index in
                        let projToDel = projects[index]
                        ProjectManager.shared.deleteProject(projToDel)
                    }
                }
            }.listStyle(.plain)
        }
    }
}

struct ProjectListView_Previews: PreviewProvider {

    static var previews: some View {
        Text("no preview")
        ProjectListView()
    }
}
