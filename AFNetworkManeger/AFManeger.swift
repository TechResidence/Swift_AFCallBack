//
//  AFManeger.swift
//  JRHttpSample
//
//  Created by [MMasahito] on 10/16/15.
//  Copyright © 2015 [MMasahito](https://github.com/MMasahito). All rights reserved.
//

import UIKit

class AFManeger: NSObject {
    
    class func sharedClient() -> AFManeger {
        var _sharedClient: AFManeger? = nil
        var onceToken: dispatch_once_t = dispatch_once_t()
        dispatch_once(&onceToken, {
            _sharedClient = AFManeger()
        })
        return _sharedClient!
    }
    
    func postSetParameter(parameters:AnyObject, apiURL api:String, callback:(NSDictionary?, NSError?)-> Void) -> Void {
        
                let manager: AFHTTPSessionManager = AFHTTPSessionManager()
                manager.POST(api, parameters: parameters,
                    success: {(task: NSURLSessionDataTask!, responseObject: AnyObject!) in
                        
                        let responseDict = responseObject as! NSDictionary
                        callback(responseDict, nil)
                        
                    }, failure: {(task: NSURLSessionDataTask!, error: NSError!) in
                     
                       callback(nil,error)
                })
    }
    
    func getSetParameter(parameters:AnyObject, apiURL api:String, callback:(NSDictionary?, NSError?) -> Void) -> Void {
        
        let manager: AFHTTPSessionManager = AFHTTPSessionManager()
        manager.GET(api, parameters: parameters,
            success: {(task: NSURLSessionDataTask!, responseObject: AnyObject!) in
                
                let responseDict = responseObject as! NSDictionary
                callback(responseDict, nil)
                
            }, failure: {(task: NSURLSessionDataTask!, error: NSError!) in
                
                callback(nil,error)
        })
    }
    
    func dataUploadSetParameter(parameters:AnyObject, apiURL api:String, uploadDatas images:NSDictionary, callback:(NSDictionary?, NSError?) -> Void) -> Void {
        
        /** manager */
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let serializer:AFJSONRequestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer = serializer
        
        /** Basic authentication */
        let user = "user"
        let pass = "pass"
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(user, password: pass)
        manager.POST(api, parameters: parameters, constructingBodyWithBlock: { (data) in
            
            for (key, value) in images {
                let name = key
                let imageData = NSData(data: UIImageJPEGRepresentation(value as! UIImage, 1)!)
                data.appendPartWithFileData(imageData, name:name as! String, fileName:name as! String, mimeType:"image/jpeg")
            }
            
            }, success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let respoce = responseObject as! NSDictionary
                callback(respoce,nil)
                
            }, failure: { (operation, error) in
                callback(nil,error)
        })
    }
}


