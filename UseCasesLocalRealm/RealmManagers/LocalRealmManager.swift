//
//  ProjectViewModel.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
// Three singleton classes (each having a .shared static member),
// ProjectManager, UseCaseManager, and StepManager
// All singleton classes are used for realm local database changes

import Foundation
import RealmSwift

// MARK: PROJECT MANAGER
class ProjectManager
{
    static let shared = ProjectManager()

    let localRealm = try! Realm()

    func addProject(project: Project)
    {
        // attempt to locally save given project

        try? localRealm.write
        {
            localRealm.add(project)
        }
    }

    func deleteProject(_ project: Project)
    {
        // if the given project: project exists, delete all of the projects
        // use cases using UseCaseManager.shared.deleteUseCase() and looping
        // through project.useCases; it then attempts delete the given project

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
    
    func projectLastUpdated(project: Project)
    {
        if let projectToUpdate = localRealm.object(ofType: Project.self, forPrimaryKey: project._id)
        {
            try? localRealm.write
            {
                projectToUpdate.lastUpdated = Date()
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
// MARK: USE CASE MANAGER
class UseCaseManager
{
    static let shared = UseCaseManager()

    let localRealm = try! Realm()

    func addUseCase(project: Project, useCase: UseCase)
    {
        // finds the target project from the given project._id and
        // appends the given useCase to the given project
        // in the local realm database
        
        if let targetProject = localRealm.object(ofType: Project.self, forPrimaryKey: project._id)
        {
            try? localRealm.write
            {
                targetProject.useCases.append(useCase)
                targetProject.lastUpdated = Date()
            }
        }
    }

    func deleteUseCase(useCase: UseCase)
    {
        // Same implimentation as ProjectManager.deleteProject()
        
        if let caseToDelete = localRealm.object(ofType: UseCase.self, forPrimaryKey: useCase._id)
        {
            // caseToDelete.underProject.lastUpdated = Date()
            // ^ use after fixing  parent - child relationship
            
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

    func useCaseLastUpdated(useCase: UseCase)
    {
        if let useCaseToUpdate = localRealm.object(ofType: UseCase.self, forPrimaryKey: useCase._id)
        {
            //ProjectManager.shared.projectLastUpdated(project: useCas.parentProject)
            try? localRealm.write
            {
                useCaseToUpdate.lastUpdated = Date()
                if let project = useCaseToUpdate.parentProject[0]
                {
                    ProjectManager.shared.projectLastUpdated(project: project)
                }
            }
        }
    }
    
    func toggleUseCaseCompleteness(useCase: UseCase)
    {
        // this function simply toggles the useCase.isComplete boolean within
        // the local realm db
        
        if let useCaseToUpdate = localRealm.object(ofType: UseCase.self, forPrimaryKey: useCase._id)
        {
            try? localRealm.write
            {
                useCaseToUpdate.isComplete.toggle()
                useCase.lastUpdated = Date()
            }
        }
    }
}
// MARK: STEP MANAGER
class StepManager
{
    static let shared = StepManager()

    let localRealm = try! Realm()

    func addStep(useCase: UseCase, step: Step)
    {
        // Same implimentation as ProjectManager.addUseCase
        if let targetUseCase = localRealm.object(ofType: UseCase.self, forPrimaryKey: useCase._id)
        {
            try? localRealm.write
            {
                targetUseCase.steps.append(step)
                targetUseCase.lastUpdated = Date()
            }
        }
    }
    
    func deleteStep(step: Step)
    {
        // Same implimentation as ProjectManager.deleteProject()
        
        if let stepToDelete = localRealm.object(ofType: Step.self, forPrimaryKey: step._id)
        {
            try? localRealm.write
            {
                localRealm.delete(stepToDelete)
            }
        }
    }
    
    func stepLastUpdated(step: Step)
    {
        // update given step's lastUpdated property to the current date
        // then make call to UseCaseManager.shared to update the
        // given step's parentUseCase's lastUpdated property
        if let stepToUpdate = localRealm.object(ofType: Step.self, forPrimaryKey: step._id)
        {
            try? localRealm.write
            {
                stepToUpdate.lastUpdated = Date()
                if let useCase = stepToUpdate.parentUseCase[0]
                {
                    UseCaseManager.shared.useCaseLastUpdated(useCase: useCase)
                }
            }
        }
    }
}
