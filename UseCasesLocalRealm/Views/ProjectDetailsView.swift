//
//  ProjectDetailsView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/8/22.
//

import SwiftUI

struct ProjectDetailsView: View {
    @State var project: Project
    var body: some View {
        Text("\(project.title)")
    }
}

struct ProjectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let project = Project()
        ProjectDetailsView(project: project)
    }
}
