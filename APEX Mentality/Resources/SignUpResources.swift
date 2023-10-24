//
//  SignUpResources.swift
//  APEX Mentality
//
//  Created by CTS on 17/07/23.
//

import Foundation
struct SignUpResource{
        func signUp(request: SignUpRequest, onSuccess:@escaping (_ result: SignUpResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
            do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: APIs.USER_REGISTRATION, requestBody: requestBody, resultType: SignUpResponse.self) { (result) in
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
