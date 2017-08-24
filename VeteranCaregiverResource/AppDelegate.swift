 //
//  AppDelegate.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 8/21/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        
        // Managed Object Context for viewcontrollers
        let tabBarController = window!.rootViewController as! UITabBarController
        
        // Basic table text viewcontroller
        if let tabBarViewControllers = tabBarController.viewControllers {
            let navigationController = tabBarViewControllers[0] as! UINavigationController
            let filterViewController = navigationController.viewControllers[0] as! FilterViewController
            filterViewController.managedObjectContext = managedObjectContext
            print("Assigned managed object context")
        }
        
        checkForData()
        print(applicationDocumentsDirectory)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: CORE DATA!!
    
    // Persistant Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VeteranCaregiverResource")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Could load data store: \(error)")
            }
        })
        return container
    }()
    
    // Managed Object Context
    lazy var managedObjectContext: NSManagedObjectContext = self.persistentContainer.viewContext
    

    // MARK: JSON IMPORT/ CORE DATA CHECK
    
    var resources = [Resource]()
    func checkForData() {
        
        let fetchRequest = NSFetchRequest<Resource>()
        // 2
        let entity = Resource.entity()
        fetchRequest.entity = entity
        // 3
        
        do {
            // 4
            resources = try managedObjectContext.fetch(fetchRequest)
        } catch {
            fatalCoreDataError(error)
        }
        print(resources.count)
        
        
        if resources.count == 0 {
            VAClient.sharedInstance().getVAResources(completionHandlerForGetVAResources: { ( arrayOfResources, error) in
                
                if let error = error {
                    print("Something is wrong with download: \(error.description)")
                } else {
                    self.saveInCoreDataWith(array: arrayOfResources!)
                    
                }
                
            })
            
            
        } else {
            print("it didnt work")
        }
    }
    
    // Save in core data method
    private func saveInCoreDataWith(array: [[String: AnyObject]]) {
        _ = array.map{self.createPhotoEntityFrom(dictionary: $0)}
        
        do {
            try managedObjectContext.save()
        } catch let error {
            print(error)
        }
    }
    
    // Create Intity from Array Dict
    private func createPhotoEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        if let resourceEntity = NSEntityDescription.insertNewObject(forEntityName: "Resource", into: managedObjectContext) as? Resource {
            resourceEntity.title = dictionary["title"] as! String
            resourceEntity.content = dictionary["content"] as? String
            resourceEntity.subjects = dictionary["subjects"] as? [String]
            resourceEntity.linkName = dictionary["linkName"] as? String
            resourceEntity.phoneNumber = dictionary["phoneNumber"] as? String
            resourceEntity.geographicServiceLocations = dictionary["geographicServiceLocation"] as? [[String: AnyObject]]
            resourceEntity.saved = false
            
            return resourceEntity
        }
        return nil
    }
    
    
    
}









