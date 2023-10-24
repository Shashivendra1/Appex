//
//  JsonApi.swift
//  APEX Mentality
//
//  Created by CTS on 29/09/23.
//


import Foundation
class JsonApi: NSObject {

    //MARK:- server call method definition
    func callUrlSession(urlValue:String,para:(AnyObject),isSuccess:Bool, withCompletionHandler:@escaping (_ result:(AnyObject)) -> Void)
        
        {
        let session = URLSession.shared
        let request = NSMutableURLRequest(url:NSURL(string:urlValue)! as URL)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: para, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
            
            
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
      
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print(dataString as Any)
            do {
              
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    print("api-",json)

                    if(isSuccess){
                        withCompletionHandler(json as (AnyObject))
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
                
            }
            
        })
        
        task.resume()
        
}
}
