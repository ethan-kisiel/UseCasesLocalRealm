//
//  ProjectViewModel.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import Foundation
import RealmSwift


class ProjectManager
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
            if !projectToDelete.useCases.isEmpty
            {
                for useCase in projectToDelete.useCases
                {
                    UseCaseManager.shared.deleteUseCase(useCase: useCase)
                }
            }
            try? localRealm.write
            {
                localRealm.delete(projectToDelete)
            }
        }
    }
    
    func getProjectsByUID(userId: String) -> Results<Project>
    {
        // retrieve locally stored project by given userId
        @ObservedResults(Project.self) var projects: Results<Project>
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
        // gets ObservedResult projects and appends current use case to the first item where item._id == project._id
        
        @ObservedResults(Project.self) var projects: Results<Project>
        let targetProject = projects.first { $0._id == project._id }
        try? localRealm.write
        {
            targetProject?.useCases.append(useCase)
        }
    }
    
    func deleteUseCase(useCase: UseCase) -> Void
    {
        if let caseToDelete = localRealm.object(ofType: UseCase.self, forPrimaryKey: useCase._id)
        {
            if !caseToDelete.steps.isEmpty
            {
                for step in caseToDelete.steps
                {
                    StepManager.shared.deleteStep(step: step)
                }
            }
            try? localRealm.write
            {
                localRealm.delete(caseToDelete)
            }
            
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
}

class StepManager
{
    static let shared = StepManager()
    
    let localRealm = try! Realm()
    
    func addStep(useCase: UseCase, step: Step) -> Void
    {
        //
       
        @ObservedResults(UseCase.self) var useCases: Results<UseCase>
        let targetUseCase = useCases.first { $0._id == useCase._id }
        try? localRealm.write
        {
            targetUseCase?.steps.append(step)
        }
    }
    
    func deleteStep(step: Step) -> Void
    {
        if let stepToDelete = localRealm.object(ofType: Step.self, forPrimaryKey: step._id)
        {
            try? localRealm.write
            {
                localRealm.delete(stepToDelete)
            }
        }
    }
}
