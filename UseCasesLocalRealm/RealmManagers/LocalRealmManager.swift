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

    func addUseCase(project: Project, useCase: UseCase)
    {
        // finds the target project from the given project._id and
        // appends the given useCase to the given project
        // in the local realm database
        
        let targetProject = localRealm.object(ofType: Project.self, forPrimaryKey: project._id)
        try? localRealm.write
        {
            targetProject?.useCases.append(useCase)
        }
    }

    func deleteUseCase(useCase: UseCase)
    {
        // Same implimentation as ProjectManager.deleteProject()
        
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
        // this function simply toggles the useCase.isComplete boolean within
        // the local realm db
        
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

    func addStep(useCase: UseCase, step: Step)
    {
        // Same implimentation as ProjectManager.addUseCase
        let targetUseCase = localRealm.object(ofType: UseCase.self, forPrimaryKey: useCase._id)
        try? localRealm.write
        {
            targetUseCase?.steps.append(step)
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
}
