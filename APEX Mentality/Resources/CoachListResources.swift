//
//  CoachListResources.swift
//  APEX Mentality
//
//  Created by CTS on 28/07/23.
//

import Foundation
struct coachListResources{
    func getCoachList(request: coachListRequest, onSuccess:@escaping (_ result: coachListResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: APIs.GET_COACHE_LIST, requestBody: requestBody, resultType: coachListResponse.self) { (result) in
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
