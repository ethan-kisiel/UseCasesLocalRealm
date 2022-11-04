//
//  BaseModel.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 9/19/22.
//

import Foundation
import RealmSwift

protocol BaseModel where Self: Object
{
    func save()
    func delete()
    static func byId<T: Object>(id: ObjectId) -> T?
    static func all<T: Object>() -> [T]
}

extension BaseModel
{
    func save(_ realm: Realm) throws
    {
        do
        {
            //Log.info("Saving \(Self.className())...")
            
            try realm.write
            {
                realm.add(self, update: .modified)
                
                //Log.info("\(Self.className()) has successfully been saved to the database!!")
            }
        }
        catch
        {
            //Log.error("Error saving \(Self.className()): \(error.localizedDescription)")
            
            //throw DatabaseErrorEnum.saveToDatabase
        }
    }
    
    //  Deletes the existing object
    func delete(_ realm: Realm, id: ObjectId) throws
    {
        if let objectToDelete = realm.object(ofType: Self.self, forPrimaryKey: id)
        {
            do
            {
                try realm.write
                {
                    Self.delete(objectToDelete)
                }
            }
            catch
            {
                //Log.error("Error deleting \(Self.className()): \(error.localizedDescription)")
                
                //throw DatabaseErrorEnum.deleteFromDatabase
            }
        }
    }
    
    //  Retrieve all objects without sorting
    static func all<T: Object>(_ realm: Realm) -> Results<T>?
    {
        do
        {
            try realm.write
            {
                return realm.objects(Self.self)
            }
        }
        catch
        {
            //Log.error("Error retrieving all \(Self.className()) objects: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    //  Retrieve all objects using a filter string.  An example is "projectId == 12345"
    static func allWithSort<T: Object>(_ realm: Realm, filterString: String) -> Results<T>?
    {
        do
        {
            try realm.write
            {
                return realm.objects(Self.self).filter(filterString)
            }
        }
        catch
        {
            //Log.error("Error retrieving all \(Self.className()) objects: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    //  Retrieve an object by the objectId
    static func byId<T>(_ realm: Realm, id: ObjectId) -> T? where T: BaseModel
    {
        do
        {
            try realm.write
            {
                return T.byId(id: id)
            }
        }
        catch
        {
            //Log.error("Error retrieving \(T.self.description()) by id): \(error.localizedDescription)")
            
            return nil
        }
        
        return T()
    }
    
    //  Converts a Realm Results<R> object into an array of Realm objects of that type
    private func convertToArray<R>(results: Results<R>) -> [R] where R: Object
    {
        var arrayOfResults: [R] = []
        
        for result in results
        {
            arrayOfResults.append(result)
        }
        
        return arrayOfResults
    }
}
