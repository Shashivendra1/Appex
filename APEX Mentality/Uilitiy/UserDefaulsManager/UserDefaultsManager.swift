//
//  UserDefaultsManager.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//
import Foundation
//struct UserDefaultsManager {
//    static func saveShippingObject(shipping: SelectedShipping){
//            do {
//            let data = try JSONEncoder().encode(shipping)
//            UserDefaults.standard.setValue(data, forKey: UserDefaultsKey.SELECTED_SHIPPING)
//            UserDefaults.standard.synchronize()
//        }catch let error{
//            print(error.localizedDescription)
//        }
//    }
//    static func saveSelectedAddress(address: AddressesData){
//        do{
//            let data = try JSONEncoder().encode(address)
//            UserDefaults.standard.setValue(data, forKey: UserDefaultsKey.SELECTED_ADDRESS)
//        }catch let error{
//            print(error.localizedDescription)
//        }
//    }
//    static func getSelectedAddress() -> AddressesData?{
//        var selectedAddress: AddressesData?
//        do {
//            let data = UserDefaults.standard.value(forKey: UserDefaultsKey.SELECTED_ADDRESS)
//            if data != nil{
//                let address = try JSONDecoder().decode(AddressesData.self, from: data as! Data)
//                selectedAddress = address
//            }
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        return selectedAddress
//    }
//      static func getShippingObject() -> SelectedShipping?{
//        var selectedShipping: SelectedShipping?
//        do{
//            let data = UserDefaults.standard.value(forKey: UserDefaultsKey.SELECTED_SHIPPING)
//            if data != nil{
//                let shipping = try JSONDecoder().decode(SelectedShipping.self, from: data as! Data)
//                selectedShipping = shipping
//            }
//        }catch let error{
//            print(error.localizedDescription)
//        }
//        return selectedShipping
//    }
//        static func deleteShippingObject(){
//        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.SELECTED_SHIPPING)
//            }
//    
//    static func deleteSelectedAddress(){
//        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.SELECTED_ADDRESS)
//    }
//}
