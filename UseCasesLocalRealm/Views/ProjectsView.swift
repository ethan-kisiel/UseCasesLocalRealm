//
//  ProjectView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import RealmSwift
import SwiftUI
import Neumorphic

struct ProjectsView: View {
    @State var title: String = EMPTY_STRING
    @State var projectId: String = EMPTY_STRING
    @State var project: Project?
    @FocusState var isFocused: Bool
    
    @ObservedResults(Project.self) var projects: Results<Project>
    var body: some View {
        NavigationStack
        {
            VStack(spacing: 10)
            {
                withAnimation
                {
                    TextInputFieldWithFocus("Title", text: $title, isFocused: $isFocused).padding(8)
                }
                withAnimation
                {
                    TextInputFieldWithFocus("Project ID", text: $projectId, isFocused: $isFocused).padding(8)
                }
                Button(action:
                {
                    project = Project(title: title, createdBy: getUserId())
                    
                    project!.projectId = projectId
                    ProjectManager.shared.addProject(project: project!)
                    
                    title = EMPTY_STRING
                    projectId = EMPTY_STRING
                    isFocused = false
                })
                {
                    Text("Create Project").foregroundColor(title.isEmpty || projectId.isEmpty ? .secondary : .primary)
                        .fontWeight(.bold)
                        
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: CGFloat(15)))
                .disabled(title.isEmpty || projectId.isEmpty)
                .frame(maxWidth: .greatestFiniteMagnitude)
            }
            
            Spacer()
            ProjectListView()
            Spacer()
                .navigationTitle("Projects")
        }.padding(10)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
