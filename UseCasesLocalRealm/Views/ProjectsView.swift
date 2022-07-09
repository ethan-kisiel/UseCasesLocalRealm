//
//  ProjectView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import RealmSwift
import SwiftUI

struct ProjectsView: View {
    @State var title: String = EMPTY_STRING
    @State var projectId: String = EMPTY_STRING
    @State var project: Project?
    
    @ObservedResults(Project.self) var projects: Results<Project>
    var body: some View {
        NavigationStack
        {
            VStack(spacing: 10)
            {
                withAnimation
                {
                    TextInputField("Title", text: $title)
                }
                withAnimation
                {
                    TextInputField("Project ID", text: $projectId)
                }
                
                Button(action: {
                    project = Project(title: title, createdBy: getUserId())
                    
                    project!.projectId = projectId
                    ProjectManager.shared.addProject(project: project!)
                    
                    title = EMPTY_STRING
                    projectId = EMPTY_STRING
                })
                {
                    Text("Create Project").foregroundColor(title.isEmpty || projectId.isEmpty ? .white : .gray)
                }
                .disabled(title.isEmpty || projectId.isEmpty)
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity)
                
                ProjectListView()
                Spacer()
                    .navigationTitle("Projects")
                
            }
        }.padding(10)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
