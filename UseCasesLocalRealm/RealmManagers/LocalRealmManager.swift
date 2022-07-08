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
    
    @ObservedResults(Project.self) var projects
    
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
        if let objectToDelete = localRealm.object(ofType: Project.self, forPrimaryKey: project._id)
        {
            try? localRealm.write
            {
                localRealm.delete(objectToDelete)
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
    
    // get use case via searchbar
}
