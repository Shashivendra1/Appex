//
//  ProfileResources.swift
//  APEX Mentality
//
//  Created by CTS on 20/07/23.
//

import Foundation
struct ProfileResource {
    func getProfile(request: ProfileRequest, onSuccess:@escaping (_ result: ProfileResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
            do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: APIs.GET_PROFILE, requestBody: requestBody, resultType: ProfileResponse.self) { (result) in
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
    
    func changePassword(request: ChangePasswordRequest, onSuccess:@escaping (_ result: ChangePasswordResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
        HttpUtility.shared.postRequest(urlString: APIs.CHANGE_PASSWORD, requestBody: requestBody, resultType: ChangePasswordResponse.self) { (result) in
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
    
    
    func editProfile(request: EditProfileRequest, onSuccess:@escaping (_ result: ProfileResponse) -> Void, onError:@escaping(_ error: Error) -> Void){

        do {
            let requestBody = try JSONEncoder().encode(request)

            HttpUtility.shared.postRequest(urlString: APIs.EDIT_PROFILE, requestBody: requestBody, resultType: ProfileResponse.self) { (result) in
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
    
    
    
    func resetPassword(request: ResetPasswordRequest, onSuccess:@escaping (_ result: ResetPasswordResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            
            HttpUtility.shared.postRequest(urlString: APIs.FORGOT_PASSWORD, requestBody: requestBody, resultType: ResetPasswordResponse.self) { (result) in
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
