//
//  ProjectCellView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import SwiftUI

struct ProjectCellView: View
{
    @State var trashIsEnabled: Bool = false
    
    let project: Project
    var body: some View
    {
        HStack(alignment: .center)
        {
            // Constants.TRASH_ICON: String
            Image(systemName: TRASH_ICON).foregroundColor(trashIsEnabled ? .red: .gray)
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
            
                    Spacer()
            NavigationLink("\(project.title)", value: Route.project(project))
            
            
            let projectId = project.projectId
            
            if let range = projectId.startIndex..<(projectId.index( projectId.startIndex, offsetBy: 3, limitedBy: projectId.endIndex) ?? projectId.endIndex)
            {
            
                let subProjectId = projectId[range] + "..."
                Text(subProjectId)
            }
        }
    }
}

struct ProjectCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCellView(project: Project())
    }
}
