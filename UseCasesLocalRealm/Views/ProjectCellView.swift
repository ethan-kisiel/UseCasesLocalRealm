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
            NavigationLink("\(project.title)", value: Route.project(project))
            Spacer()
            Image(systemName: "trash.circle.fill").foregroundColor(trashIsEnabled ? .red: .gray)
                .disabled(trashIsEnabled)
                .onLongPressGesture(minimumDuration: 1)
                {
                    trashIsEnabled.toggle()
                }.onTapGesture {
                    if trashIsEnabled
                    {
                        ProjectManager.shared.deleteProject(project)
                    }
                }
        }
    }
}

struct ProjectCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCellView(project: Project())
    }
}
