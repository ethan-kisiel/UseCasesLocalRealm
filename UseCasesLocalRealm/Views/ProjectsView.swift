//
//  ProjectView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import Neumorphic
import RealmSwift
import SwiftUI

struct ProjectsView: View
{
    @ObservedResults(Project.self) var projects: Results<Project>
    let userId: String = getUserId()
    @State var title: String = EMPTY_STRING
    @State var projectId: String = EMPTY_STRING
    @State var project: Project?

    @State var showAddFields: Bool = false
    @FocusState var isFocused: Bool

    var body: some View
    {
        VStack
        {
            HStack(alignment: .top)
            {
                Spacer()
                Image(systemName: showAddFields ? LESS_ICON : MORE_ICON)
                    .onTapGesture
                    {
                        showAddFields.toggle()
                    }
            }.padding()

            if showAddFields
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
                            project = Project(title: title, projectId: projectId)

                            ProjectManager.shared.addProject(project: project!)

                            title = EMPTY_STRING
                            projectId = EMPTY_STRING
                            isFocused = false
                        })
                    {
                        Text("Create Project").foregroundColor(title.isEmpty || projectId.isEmpty ? .secondary : .primary)
                            .fontWeight(.bold).frame(maxWidth: .infinity)
                    }
                    .softButtonStyle(RoundedRectangle(cornerRadius: CGFloat(15)))
                    .disabled(title.isEmpty || projectId.isEmpty)
                }.padding()
            }

            Spacer()
            ProjectListView()
            Spacer()
                .navigationTitle("Projects")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProjectsView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ProjectsView()
    }
}
