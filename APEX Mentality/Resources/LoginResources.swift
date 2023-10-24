//
//  LoginResources.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//

import Foundation
struct LoginResource{
    func login(request: LoginRequest, onSuccess:@escaping (_ result: LoginResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: APIs.CLIENT_LOGIN, requestBody: requestBody, resultType: LoginResponse.self) { (result) in
                switch result{
                case .success(let response):
                    onSuccess(response)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error)
        }
    }
}
