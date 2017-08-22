//
//  VAClient.swift
//  VeteranCaregiverResource
//
//  Created by Erik Uecke on 8/22/17.
//  Copyright © 2017 Erik Uecke. All rights reserved.
//

import Foundation

class VAClient: NSObject {
    
    // MARK: Properties
    
    // shared session
    var session = URLSession.shared
    
    // MARK: Shared Instance
    class func sharedInstance() -> VAClient {
        struct Singleton {
            static var sharedInstance = VAClient()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: GET
    
    func taskForGETMethod(completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        // Get Json
        let request = NSMutableURLRequest(url: URL(string: "https://raw.githubusercontent.com/va-data/va-resources/master/family-caregiver-support.json")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    
    
    //MARK: given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: [[String:AnyObject]]! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:AnyObject]]
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult as AnyObject, nil)
    }
    
    func getVAResources(completionHandlerForGetVAResources: @escaping (_ results: [[String: AnyObject]]?, _ error: NSError?) -> Void) {
        
        let _ = taskForGETMethod { (result, error) in
            
            
            if let errorMessage = error {
                completionHandlerForGetVAResources(nil,errorMessage)
                
            }else{
                func sendError(error: String) {
                    let userInfo = [NSLocalizedDescriptionKey : error]
                    completionHandlerForGetVAResources(nil,NSError(domain: "getVAResource", code: 1, userInfo: userInfo))
                }
                
                guard let resourceArrayOfDict = result as? [[String: AnyObject]] else {
                    sendError(error: "Cannot Parse Dictionary")
                    return
                }
                print("Printing resourceArrayOfDict form client: \(resourceArrayOfDict)")
                completionHandlerForGetVAResources(resourceArrayOfDict,nil)
                
            }

        }
    }
}
