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
        
        // Custom Bar appearance
        customizeAppearance()
       
        
        // Managed Object Context for viewcontrollers
        let tabBarController = window!.rootViewController as! UITabBarController
        
        // Basic table text viewcontroller
        if let tabBarViewControllers = tabBarController.viewControllers {
            
            let navigationController = tabBarViewControllers[0] as! UINavigationController
            let filterViewController = navigationController.viewControllers[0] as! FilterViewController
            filterViewController.managedObjectContext = managedObjectContext
            
            let savedNavigationController = tabBarViewControllers[1] as! UINavigationController
            let savedViewController = savedNavigationController.viewControllers[0] as! SavedListViewController
            savedViewController.managedObjectContext = managedObjectContext
            
        }
        
        // Search Bar colors
        UISearchBar.appearance().barTintColor = UIColor(red: 11/255.0, green: 70/255.0, blue: 123/255.0, alpha: 1.0)
        UISearchBar.appearance().tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(red: 11/255.0, green: 70/255.0, blue: 123/255.0, alpha: 1.0)
        
        checkForData()
        listenForFatalCoreDataNotifications()
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
        
        
        
        if resources.count == 0 {
            VAClient.sharedInstance().getVAResources(completionHandlerForGetVAResources: { ( arrayOfResources, error) in
                
                if let error = error {
                    print("Something is wrong with download: \(error.description)")
                } else {
                
                    
                    self.saveInCoreDataWith(array: arrayOfResources!)
                    
                }
                
            })
            
            
        } else {
            print("Core Data Full")
        }
    }
    
    // Save in core data method
    private func saveInCoreDataWith(array: [[String: AnyObject]]) {
        _ = array.map{self.createResourceEntityFrom(dictionary: $0)}
        
        do {
            try managedObjectContext.save()
        } catch let error {
            print(error)
        }
    }
    
    // Create Intity from Array Dict
    private func createResourceEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        if let resourceEntity = NSEntityDescription.insertNewObject(forEntityName: "Resource", into: managedObjectContext) as? Resource {
            resourceEntity.title = dictionary["title"] as! String
            resourceEntity.content = dictionary["content"] as? String
            // Subjects array into string to sort
            let subjectsString = { () -> String in
                var stringFromArray = ""
                for subject in dictionary["subjects"] as! [String] {
                    stringFromArray = stringFromArray + "\(subject) "
                }
                return stringFromArray
            }
            resourceEntity.subjectsString = subjectsString()
            resourceEntity.subjectsArray = dictionary["subjects"] as? [String]
            resourceEntity.linkName = dictionary["linkName"] as? String
            resourceEntity.saved = false
            
            return resourceEntity
        }
        return nil
    }
    
    func listenForFatalCoreDataNotifications() {
        NotificationCenter.default.addObserver( forName: MyManagedObjectContextSaveDidFailNotification, object: nil, queue: OperationQueue.main, using: { notification in
            
            let alert = UIAlertController( title: "Internal Error", message: "There was a fatal error in the app and it cannot continue.\n\n" + "Press OK to terminate the app. Sorry for the inconvenience.", preferredStyle: .alert)
            
             let action = UIAlertAction(title: "OK", style: .default) { _ in
                
                let exception = NSException( name: NSExceptionName.internalInconsistencyException, reason: "Fatal Core Data error", userInfo: nil)
                exception.raise()
            }
            
            alert.addAction(action)
            
            self.viewControllerForShowingAlert().present(alert, animated: true, completion: nil)
        })
    }
    
    func viewControllerForShowingAlert() -> UIViewController {
        let rootViewController = self.window!.rootViewController!
        if let presentedViewController = rootViewController.presentedViewController {
            return presentedViewController
        } else {
            return rootViewController
        }
    }
        
        
    
    func customizeAppearance() {
        
        let backGroundColor = UIColor(red: 11/255.0, green: 70/255.0, blue: 123/255.0, alpha: 1.0)

        UINavigationBar.appearance().barTintColor = backGroundColor
        UINavigationBar.appearance().titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white ]
        UITabBar.appearance().barTintColor = backGroundColor
        
        UITabBar.appearance().tintColor = UIColor.white
    }
    
    
}









