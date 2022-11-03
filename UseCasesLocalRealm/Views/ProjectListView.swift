//
//  ProjectListView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import RealmSwift
import SwiftUI

struct ProjectListView: View
{
    let userId: String = getUserId()
    @ObservedResults(Project.self) var projectResults: Results<Project>
    var userProjects: [Project]
    {
        
        return projectResults.filter { $0.createdBy == userId }
    }

    // get only projects created by this user
    var body: some View
    {
        // if there are projects saved to the localDB with a createdBy
        // value equal to the current userId, those projects will be
        // looped through and presented as a ProjectCellView in the loop.
        // sliding to delete will cause the element at the current index to
        // be deleted using the ProjectManager.
        
        if userProjects.isEmpty
        {
            Text("No projects to display.")
        }
        else
        {
            List
            {
                // sort by category
                ForEach(userProjects, id: \._id)
                {
                    project in
                    ProjectCellView(project: project)
                }
                .onDelete
                {
                    indexSet in
                    indexSet.forEach
                    {
                        index in
                        // delete project at current index
                        $projectResults.remove(userProjects[index])
                    }
                }
            }.listStyle(.plain)
            .padding()
        }
    }
}

struct ProjectListView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ProjectListView()
    }
}
