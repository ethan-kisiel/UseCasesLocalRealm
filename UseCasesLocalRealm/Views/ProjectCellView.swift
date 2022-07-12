//
//  ProjectCellView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import RealmSwift
import SwiftUI

struct ProjectCellView: View
{
    @ObservedResults(Project.self) var projects: Results<Project>
    @State var trashIsEnabled: Bool = false

    let project: Project
    var body: some View
    {
        NavigationLink(value: Route.project(project))
        {
            HStack(alignment: .center)
            {
                // Constants.TRASH_ICON: String
                // Tap-hold gesture enables trashIsEnabled boolean
                // when trashIsEnabled is true, a tap gesture on the Image
                // will cause project to be deleted from the localRealm DB

                Image(systemName: TRASH_ICON).foregroundColor(trashIsEnabled ? .red : .gray)
                    .disabled(trashIsEnabled)
                    .onLongPressGesture(minimumDuration: 0.8)
                    {
                        trashIsEnabled.toggle()
                    }
                    .onTapGesture
                    {
                        if trashIsEnabled
                        {
                            ProjectManager.shared.deleteProject(project)
                        }
                    }

                Text(project.title)
                Spacer()
                let projectId = project.projectId
                Text(projectId.shorten(by: 3))
            }
        }
    }
}

struct ProjectCellView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ProjectCellView(project: Project())
    }
}
