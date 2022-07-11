//
//  ProjectViewModel.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import Foundation
import RealmSwift


class ProjectManager: ObservableObject
{
    
    static let shared = ProjectManager()
    
    let localRealm = try! Realm()
    
    func addProject(project: Project) -> Void
    {
        // attempt to locally save given project
        
        try? localRealm.write
        {
            localRealm.add(project)
        }
    }
    
    func deleteProject(_ project: Project) -> Void
    {
        if let projectToDelete = localRealm.object(ofType: Project.self, forPrimaryKey: project._id)
        {
            try? localRealm.write
            {
                for useCase in projectToDelete.useCases
                {
                    UseCaseManager.shared.deleteUseCase(useCase: useCase)
                }
                localRealm.delete(projectToDelete)
            }
            
            //self.projects = ProjectManager.shared.getProjectsByUID(userId: getUserId())
        }
    }
    
    func getProjectsByUID(userId: String) -> Results<Project>
    {
        // retrieve locally stored project by given userId
        let projects = localRealm.objects(Project.self)
        let userProjects = projects.where
        {
            $0.createdBy == userId
        }
        
        return userProjects
    }
    

}

class UseCaseManager
{
    static let shared = UseCaseManager()
    
    let localRealm = try! Realm()
    
    func addUseCase(project: Project, useCase: UseCase) -> Void
    {
        // attempt to locally save given project
       
        @ObservedResults(Project.self) var projects: Results<Project>
        var targetProject = projects.first { $0._id == project._id }
        try? localRealm.write
        {
            targetProject?.useCases.append(useCase)
        }
    }
    
    func deleteUseCase(useCase: UseCase) -> Void
    {
        if let objectToDelete = localRealm.object(ofType: UseCase.self, forPrimaryKey: useCase._id)
        {
            try? localRealm.write
            {
                localRealm.delete(objectToDelete)
            }
            
            //self.projects = ProjectManager.shared.getProjectsByUID(userId: getUserId())
        }
    }
    
    func toggleUseCaseCompleteness(useCase: UseCase)
    {

        if let useCaseToUpdate = localRealm.object(ofType: UseCase.self, forPrimaryKey: useCase._id)
        {
            try? localRealm.write
            {
                useCaseToUpdate.isComplete.toggle()
            }
        }
    }
    // get use case via searchbar
}
