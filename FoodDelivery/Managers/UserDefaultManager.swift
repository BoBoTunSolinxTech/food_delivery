//
//  UserDefaultManager.swift
//  FattyCustomer
//
//  Created by Phyo Kyaw Swar on 02/12/2021.
//

import Foundation
import CoreLocation

struct UserDefaultManager {
    
    enum Keys : String {
        
        case selectedLanguage = "SelectedLanguage"
        case authVerificationID = "authVerificationID"
        case userData = "UserData"
        case fcmToken = "FCMToken"
        case isUserLogin = "isUserLogin"
        case currentAddress = "currentAddress"
        case defaultAddress = "defautlAddress"
        case previosTimeStamp = "previosTimeStamp"
        case pushyToken = "pushyToken"
        case selectedZone = "selectedZone"
        case selectedCurrency = "selectedCurrency"
        case zoneId = "zoneId"
        case phoneNumber = "phoneNumber"
        case onboardingAds = "onboardingAds"
        case recentSearch = "recentSearch"
        
        func getString() -> String {
            return self.rawValue
        }
        
    }
    
    static func saveSelectedLanaguage(language : String , key : String) {
        UserDefaults.standard.set(language, forKey: key)
    }
    
    static func retrieveSelectedLanguage(key : String) -> LanguageType? {
        if let language = UserDefaults.standard.value(forKey: key) as? String {
            let languageType = LanguageType.init(rawValue: language)
            return languageType
        }
        
        return LanguageType.burmese
    }
    
    static func setZoneId(zoneId: Int) {
        UserDefaultManager.saveIntValue(value: zoneId, key: UserDefaultManager.Keys.zoneId.rawValue )
    }
    
    static func getZoneId() -> Int {
        UserDefaultManager.retrieveIntValue(key: UserDefaultManager.Keys.zoneId.rawValue )
    }
    
    static func setPhoneNumber(phoneNumber: String) {
        UserDefaultManager.saveStringValue(value: phoneNumber, key: UserDefaultManager.Keys.phoneNumber.rawValue )
    }
    
    static func getPhoneNumber() -> String {
        UserDefaultManager.retrieveStringValue(key: UserDefaultManager.Keys.phoneNumber.rawValue) ?? ""
    }
    
    static func saveUserLogin(value : Bool , key : String) {
        UserDefaultManager.saveBoolValue(value: value, key: key)
    }
    
    static func retrieveUserLogin(key : String) -> Bool {
        return UserDefaultManager.retrieveBoolValue(key: key) ?? false
    }
    
    static func saveRecentSearch(value: [String]){
        UserDefaultManager.saveStringArrayValue(value: value, key: UserDefaultManager.Keys.recentSearch.rawValue)
    }
    
    static func retrieveRecentSearch() -> [String]? {
        return UserDefaultManager.retrieveStringArrayValue(key: UserDefaultManager.Keys.recentSearch.rawValue)
    }
    
    
    static func deleteDefaultAddress(){
        UserDefaults.standard.removeObject(forKey: UserDefaultManager.Keys.defaultAddress.rawValue)
    }

    
    static func setPreviousTimeStamp(timeStamp : UInt64){
        UserDefaultManager.saveUInt64Value(value: timeStamp, key: UserDefaultManager.Keys.previosTimeStamp.rawValue)
    }
    
    static func getPreviousTimeStamp() -> UInt64{
        if let timeStamp = UserDefaultManager.retrieveUInt64Value(key: UserDefaultManager.Keys.previosTimeStamp.rawValue){
            return timeStamp
        } else {
            return 0
        }
    }
}

extension UserDefaultManager {
    // MARK:- Setting and getting Object as Data in NSUserDefault
    static func saveObjectToNSUserDefault(value: Data, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func retrieveObjectFromNSUserDefault(key:String) -> Data? {
        return UserDefaults.standard.object(forKey: key) as? Data
    }
    
    static func saveStringValue(value : String , key : String ){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func retrieveStringValue(key : String) -> String? {
        return UserDefaults.standard.value(forKey: key) as? String
    }
    
    static func saveStringArrayValue(value : [String] , key : String ){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func retrieveStringArrayValue(key : String) -> [String]? {
        return UserDefaults.standard.value(forKey: key) as? [String]
    }
    
    static func saveBoolValue(value : Bool , key : String ){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func retrieveBoolValue(key : String) -> Bool? {
        return UserDefaults.standard.value(forKey: key) as? Bool
    }
    
    static func saveUInt64Value(value : UInt64, key : String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func retrieveUInt64Value(key : String) -> UInt64? {
        return UserDefaults.standard.value(forKey: key) as? UInt64
    }
    
    static func saveIntValue(value: Int, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func retrieveIntValue(key: String) -> Int {
        return UserDefaults.standard.value(forKey: key) as? Int ?? 1
    }
    
    static func clearSession(key : String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
