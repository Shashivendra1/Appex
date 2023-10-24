//
//  CheckSubscriptionPlanResources.swift
//  APEX Mentality
//
//  Created by CTS on 18/10/23.
//

import Foundation
struct CheckPlanResources{
    func plan(request: CheckSubscriptionPlanRequest, onSuccess:@escaping (_ result: CheckSubscriptionPlanResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: APIs.PAYMENT_SUBSCRIPTION, requestBody: requestBody, resultType: CheckSubscriptionPlanResponse.self) { (result) in
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
