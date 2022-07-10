//
//  UseCasesLocalRealmApp.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import SwiftUI
import Neumorphic

enum Route: Hashable
{
    // projects takes the user id string from user defaults
    case projects
    case project(Project)
    case useCase(UseCase)
}

@main
struct UseCasesLocalRealmApp: App {
    let userId: String = getUserId()
    
    var body: some Scene {
        WindowGroup
        {
            NavigationStack
            {
                ProjectsView()
            }.navigationDestination(for: Route.self)
            { route in
                switch route
                {
                    case .projects:
                        ProjectsView()
                    case .project(let project):
                        ProjectDetailsView(project: project)
                    case .useCase(let useCase):
                        Text("use case views")
                }
            }
        }
    }
}
