//
//  HttpUtilities.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//

import Foundation


struct HttpUtility {
    
    public static let shared: HttpUtility = HttpUtility()
    
    private init() {
    }
    
    func getRequest<T: Decodable>(urlString: String, resultType: T.Type, completion:@escaping(Result<T, Error>) -> Void){
        
        var urlRequest = URLRequest(url: URL(string: urlString)!)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil && data != nil && data?.count != 0{
                print(String(data: data!, encoding: .utf8)!)
                let jsonDecoder = JSONDecoder()
                let response = response as! HTTPURLResponse
                print(response.statusCode)
                let statusCode = response.statusCode
                
                switch statusCode {
                case 200:
                    do {
                        let result = try jsonDecoder.decode(T.self, from: data!)
                        completion(.success(result))
                    } catch let error {
                        completion(.failure(error))
                    }
                case 500:
                    completion(.failure(HTTPError.incorrectData))
                default:
                    completion(.failure(HTTPError.badRequest))
                }
            }else{
                let error = error as NSError?
                let errorCode = error?.code
                switch errorCode {
                case -1009:
                    completion(.failure(HTTPError.internetConnection))
                default:
                    completion(.failure(error ?? HTTPError.badRequest))
                }
            }
        }.resume()
        
    }
    
    func postRequest<T: Decodable>(urlString: String, requestBody: Data?, resultType: T.Type, completion:@escaping (Result<T, Error>) -> Void ){
        
        var urlRequest = URLRequest(url: URL(string: urlString)!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error == nil && data != nil && data?.count != 0{
                print(String(data: data!, encoding: .utf8)!)
                let jsonDecoder = JSONDecoder()
                let response = response as! HTTPURLResponse
                print(response.statusCode)
                let statusCode = response.statusCode
                
                switch statusCode {
                case 200:
                    do {
                        let result = try jsonDecoder.decode(T.self, from: data!)
                        completion(.success(result))
                    } catch let error {
                        completion(.failure(error))
                    }
                case 500:
                    completion(.failure(HTTPError.incorrectData))
                default:
                    completion(.failure(HTTPError.badRequest))
                }
            }else{
                let error = error as NSError?
                let errorCode = error?.code
                switch errorCode {
                case -1009:
                    completion(.failure(HTTPError.internetConnection))
                default:
                    completion(.failure(error ?? HTTPError.badRequest))
                }
            }
            
        }.resume()
        
    }
    
    func postRequestDelete<T: Decodable>(urlString: String, requestBody: Data?, completion:@escaping (Result<T, Error>) -> Void ){
        
        var urlRequest = URLRequest(url: URL(string: urlString)!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error == nil && data != nil && data?.count != 0{
                print(String(data: data!, encoding: .utf8)!)
                let jsonDecoder = JSONDecoder()
                let response = response as! HTTPURLResponse
                print(response.statusCode)
                let statusCode = response.statusCode
                
                switch statusCode {
                case 200:
                    do {
                        let result = try jsonDecoder.decode(T.self, from: data!)
                        completion(.success(result))
                    } catch let error {
                        completion(.failure(error))
                    }
                case 500:
                    completion(.failure(HTTPError.incorrectData))
                default:
                    completion(.failure(HTTPError.badRequest))
                }
            }else{
                let error = error as NSError?
                let errorCode = error?.code
                switch errorCode {
                case -1009:
                    completion(.failure(HTTPError.internetConnection))
                default:
                    completion(.failure(error ?? HTTPError.badRequest))
                }
            }
            
        }.resume()
        
    }
    
    func getApiData<T:Decodable>(urlRequest: URLRequest, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if(error == nil && data != nil && data?.count != 0)
            {
                //parse the responseData here
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data!)
                    _ = completionHandler(result)
                }
                catch let error{
                    DispatchQueue.main.async {
                        debugPrint("error occured while decoding = \(error.localizedDescription)")
                    }
                    
                }
            }else{
                DispatchQueue.main.async {
                }
            }
        }.resume()
        
    }
    
//    func multipartRequest<T:Decodable>(requestUrl: URL, imageData: Data, request: EditProfileRequest, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void){
//        
//        var urlRequest = URLRequest(url: requestUrl)
//        let lineBreak = "\r\n"
//        
//        urlRequest.httpMethod = "post"
//        let boundary = "---------------------------------\(UUID().uuidString)"
//        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
//        
//        let fname = "test.png"
//        let mimetype = "image/png"
//        
//        var requestData = Data()
//        
//        requestData.append("--\(boundary)\r\n" .data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"user_id\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        requestData.append(request.userID! .data(using: .utf8)!)
//        
//        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"name\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        requestData.append("\(request.name! + lineBreak)" .data(using: .utf8)!)
//        
//        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"email\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        requestData.append("\(request.email! + lineBreak)" .data(using: .utf8)!)
//        
//        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"phone\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        requestData.append("\(request.phone! + lineBreak)" .data(using: .utf8)!)
//        
//        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"location\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        requestData.append("\(request.location! + lineBreak)" .data(using: .utf8)!)
//        
//        //        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
//        //        requestData.append("content-disposition: form-data; name=\"user_id\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        //        requestData.append("\(request.userID! + lineBreak)" .data(using: .utf8)!)
//        
//        requestData.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
//        requestData.append("Content-Disposition:form-data; name=\"image\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
//        requestData.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
//        requestData.append(imageData)
//        requestData.append("\r\n".data(using: String.Encoding.utf8)!)
//        
//        requestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
//        
//        urlRequest.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
//        urlRequest.httpBody = requestData
//        
//        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
//            if(error == nil && data != nil && data?.count != 0)
//            {
//                let dataStr = String(decoding: requestData, as: UTF8.self) //to view the data you receive from the API
//                print(dataStr)
//                do {
//                    let response = try JSONDecoder().decode(T.self, from: data!)
//                    _=completionHandler(response)
//                }
//                catch let decodingError {
//                    debugPrint(decodingError)
//                }
//            }
//            
//        }.resume()
//        
//    }
    
}

