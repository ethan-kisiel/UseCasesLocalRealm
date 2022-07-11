//
//  ProjectListView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import RealmSwift
import SwiftUI

struct ProjectListView: View {
    
    let userId: String = getUserId()
    @ObservedResults(Project.self) var projectResults: Results<Project>
    var userProjects: [Project]
    {
        return projectResults.filter { $0.createdBy == userId }
    }
    // get only projects created by this user
    var body: some View {
        // Check if given Result<Project> is Empty. if not Empty, the view will
        // be presented with a List of each Project's cell view (ProjectCellView(<Project>))
        // each cell is capable of navigating to the Project detail view (ProjectDetailView(<Project>)).
        // each cell is also capable of
        
        if userProjects.isEmpty
        {
            Text("No projects to display.")
        }
        else
        {
            List
            {
                ForEach(userProjects, id: \._id)
                {
                    project in
                    ProjectCellView(project: project)
                }
                .onDelete {
                    indexSet in
                    indexSet.forEach
                    {
                        index in
                        // delete project at current index
                        ProjectManager.shared.deleteProject(userProjects[index])
                    }
                }
            }.listStyle(.plain)
                .padding()
        }
    }
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView()
    }
}
