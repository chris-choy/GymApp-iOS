//
//  SportVC+CoreData.swift
//  GymApp
//
//  Created by Chris on 2020/4/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData

extension SportViewController{
    
    func setupContext(){
        if(managedObjectContext == nil){
            let container = NSPersistentContainer(name: "GymApp")
            container.loadPersistentStores { (desc, err) in
                if let err = err {
                    fatalError("core data error: \(err)")
                }
            }
            managedObjectContext = container.viewContext
        }
    }
    
// MARK: - Fetch
    
    func fetchSportData() {
//        let store = NSPersistentContainer(name: "GymApp")
//        store.loadPersistentStores { (desc, err) in
//            if let err = err {
//                fatalError("core data error: \(err)")
//            }
//        }
//        let context = store.viewContext
        
        let request : NSFetchRequest<Sport> = Sport.fetchRequest()

        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        sportFC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try sportFC?.performFetch()
            if let object = sportFC?.fetchedObjects {
                testList = object
            }
        } catch  {
            print(error)
        }
        
        
        //translate to PinYin
        for s in testList! {
            let mutableString = NSMutableString(string: s.name!)
            CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
            var string = String(mutableString)
            string = string.replacingOccurrences(of: " ", with: "")
            //print(s.name!,"=",string)
            sortedName.append(string)
        }
        
        
        
        sortedName.append("ab")
        sortedName.append("aa")
        sortedName.sort()
//        print(sortedName)
        
    }
    
    func ddmFetchTagData(){
        let store = NSPersistentContainer(name: "GymApp")
        store.loadPersistentStores { (desc, err) in
            if let err = err {
                fatalError("core data error: \(err)")
            }
        }
        let context = store.viewContext
        let request : NSFetchRequest<SportTag> = SportTag.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        tagFC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try tagFC?.performFetch()
            if let object = tagFC?.fetchedObjects {
                tagList = object
            }
        } catch  {
            print(error)
        }
    }
    
    func ddmFetchUnitData(){
        let store = NSPersistentContainer(name: "GymApp")
        store.loadPersistentStores { (desc, err) in
            if let err = err {
                fatalError("core data error: \(err)")
            }
        }
        let context = store.viewContext
        let request : NSFetchRequest<SportUnit> = SportUnit.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        unitFC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try unitFC?.performFetch()
            if let object = unitFC?.fetchedObjects {
                unitList = object
            }
        } catch  {
            print(error)
        }
    }
// MARK: - Add
//    func addSport(name: String,tag: SportTag?,unit: SportUnit){
////        let store = NSPersistentContainer(name: "GymApp")
////        store.loadPersistentStores { (desc, err) in
////            if let err = err {
////                fatalError("core data error: \(err)")
////            }
////        }
////        let context = store.viewContext
//        
//        let sport = NSEntityDescription.insertNewObject(forEntityName: "Sport", into: managedObjectContext!) as! Sport
//        sport.name = name
//        sport.tag = tag
//        sport.unit = unit
//        
//        
//        try! managedObjectContext!.save()
//        
//        fetchSportData()
//        tableView.reloadData()
//        removeSportAddingWin()
//    }
    
    func addTag(name: String) -> Bool{
        if(selectTag(name: name).count != 0){
            return false
        }
        let tag = NSEntityDescription.insertNewObject(forEntityName: "SportTag", into: managedObjectContext!) as! SportTag
        tag.name = name
        
        do {
            try managedObjectContext?.save()
            return true
        } catch {
            print(error)
        }
        
        return false
    }
    
    func addUnit(name: String) -> Bool{
        if(selectUnit(name: name).count != 0){
            return false
        }
        
        let unit = NSEntityDescription.insertNewObject(forEntityName: "SportUnit", into: managedObjectContext!) as! SportUnit
        unit.name = name
        
        do {
            try managedObjectContext?.save()
            return true
        } catch {
            print(error)
        }
        
        return false
    }
    
// MARK: - Delete
    func deleteTag(name: String){
//        let container = NSPersistentContainer(name: "GymApp")
//        container.loadPersistentStores{ (desc, err) in
//            if let err = err {
//                fatalError("core data error: \(err)")
//            }
//        }
//
//        let context = container.viewContext
        let fetchRequest = NSFetchRequest<SportTag>(entityName: "SportTag")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try managedObjectContext?.fetch(fetchRequest)
            if(result?.count != 0){
                managedObjectContext?.delete(result![0])
            }
        } catch {
            print(error)
        }
        
        try! managedObjectContext?.save()
        ddmFetchTagData()
        ddmTableView?.reloadData()
    }
    
    func deleteUnit(name: String){
        let fetchRequest = NSFetchRequest<SportUnit>(entityName: "SportUnit")
        
        //set filter
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try managedObjectContext?.fetch(fetchRequest)
            if(result?.count != 0){
                managedObjectContext?.delete(result![0])
            }
        } catch {
            print(error)
        }
        
        try! managedObjectContext?.save()
        ddmFetchUnitData()
        ddmTableView?.reloadData()
    }
    
    func selectTag(name: String) -> [SportTag]{
        let request = NSFetchRequest<SportTag>(entityName: "SportTag")
        request.predicate = NSPredicate(format: "name = %@", name)
        var result : [SportTag] = []
        
        do {
            result = try managedObjectContext!.fetch(request)
            return result
        } catch {
            print(error)
        }
        
        return result
    }
    
    func selectUnit(name: String) -> [SportUnit]{
        let request = NSFetchRequest<SportUnit>(entityName: "SportUnit")
        request.predicate = NSPredicate(format: "name = %@", name)
        var result : [SportUnit] = []
        
        do {
            result = try managedObjectContext!.fetch(request)
            return result
        } catch {
            print(error)
        }
        
        return result
    }
    
}
