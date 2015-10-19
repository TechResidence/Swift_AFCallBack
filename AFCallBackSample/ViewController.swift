//
//  ViewController.swift
//  JRHttpSample
//
//  Created by [MMasahito] on 10/16/15.
//  Copyright © 2015 [MMasahito](https://github.com/MMasahito). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - delgate method -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** Request header, response header also log output */
        AFNetworkActivityLogger.sharedLogger().startLogging()
        AFNetworkActivityLogger.sharedLogger().level = .AFLoggerLevelDebug
        
        self.postHttpTask()
        self.getHttpTask()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - prvate method -
    
    private func postHttpTask() {
        
        let param = ["format":"json"]
        let api:String! = "http://www.raywenderlich.com/demos/weather_sample/weather.php"
        AFManeger.sharedClient().postSetParameter(param, apiURL: api){ (result:NSDictionary?, error:NSError?) in
            
            if ((error) != nil) {
                print("Error")
            } else {
                print("self.postHttpTask() successful")
                print(result)
            }
        }
    }
    
    private func getHttpTask() {
        
        let param = ["format":"json"]
        let jsonUrl:String! = "http://www.raywenderlich.com/demos/weather_sample/weather.php"
        AFManeger.sharedClient().getSetParameter(param, apiURL: jsonUrl){ (result:NSDictionary?, error:NSError?) in
            
            if ((error) != nil) {
                print("Error")
            } else {
                print("self.getHttpTask() successful")
                print(result)
            }
        }
    }
    
    private func uploadDataTask() {
        
        /** afnetworking upload images */
        let parameters: Dictionary<String,AnyObject> = ["key1": "value1", "key2": "value2"] // Param
        let images: Dictionary<String,UIImage> = ["image1":UIImage(named:"my_image")!, "image2":UIImage(named:"my_image")!] // imageData
        let api:String! = ""
        AFManeger.sharedClient().dataUploadSetParameter(parameters, apiURL:api, uploadDatas:images){ (result:NSDictionary?, error:NSError?) in
            
            if ((error) != nil) {
                print("Error")
            } else {
                print("self.uploadDataTask() successful")
                print(result)
            }
        }
    }
}

