
import Foundation
import Alamofire
import RxRelay
import RxSwift
import RxCocoa
import SwiftyJSON
import SystemConfiguration
import Reachability
import SwiftUI

class ApiClient {
    //MARK:- NETWORK CALLS
    static let shared = ApiClient()
    
    private let APIManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        let delegate = Session.default.delegate
        let manager = Session.init(configuration: configuration,
                                   delegate: delegate)
        return manager
    }()
    
    public func request(url : String,
                        method : HTTPMethod = .get,
                        parameters : Parameters = [:],
                        headers : HTTPHeaders = [:] ,
                        isOpenAPI : Bool = false) -> Observable<Any>{
        
        if !ApiClient.checkReachable() {
            return Observable.create { observer in
                observer.onError(ErrorType.NoInterntError)
                return Disposables.create()
            }
        }
        
        var zoneId = 1
        
//        if let zone = UserDefaultManager.getSelectedZone(), UserDefaultManager.retrieveUserLogin(key: UserDefaultManager.Keys.isUserLogin.rawValue) {
//            zoneId = zone.zoneId ?? 1
//        } else {
//            zoneId = UserDefaultManager.getZoneId()
//        }
//        
//        
//        var currencyId = 1
//        if let currency = UserDefaultManager.getSelectedCurrency() {
//            currencyId = currency.currencyID ?? 1
//        }
        
        var headers = headers
        headers["Content-Type"] = "application/json"
        headers["device-id"] = UIDevice.current.identifierForVendor!.uuidString
        debugPrint("divice-id", UIDevice.current.identifierForVendor!.uuidString)
        //headers["customer-id"] = "\(UserDefaultManager.getUserProfile()?.customerID ?? 0)"
        headers["language"] = "\(LocalizationManager.sharedInstance.getLocale()?.getContentLanguage() ?? "en")"
        headers["zone-id"] = "\(zoneId)"
        //headers["currency-id"] = "\(currencyId)"
        /*
         device-id
         customer-id
         language
         */
        
        let encoding : ParameterEncoding = (method == .get ? URLEncoding.default : JSONEncoding.default)
        
        return Observable.create { observer in
            self.APIManager.request(url, method: method, parameters: parameters,encoding: encoding, headers: headers).validate().responseJSON { (response) in
                
                //                print(response.data?.toJsonString())
                
                switch response.result {
                case .success:
                    if let data = response.data, let responseJSON = data.decode(modelType: BaseResponse.self),
                       let message = responseJSON.message,
                       let isSuccess = responseJSON.success{
                        //                        let successRange = 200...300
                        debugPrint(isSuccess, message)
                        //                        if isSuccess {
                        observer.onNext(data)
                        observer.onCompleted()
                        //                        }else{
                        //                            let error = ErrorType.KnownError(message)
                        //                            observer.onError(error)
                        //                        }
                        
                    }
                case .failure:
                    
                    if let statusCode = response.response?.statusCode , statusCode == 406 {
                        let responseJson = JSON(response.data as Any)
                        if let message = responseJson["message"].string {
                            let error = ErrorType.TokenExpireError(message)
                            observer.onError(error)
                            
                        }
                    }
                    else if let statusCode = response.response?.statusCode ,
                            statusCode == 403 {
                        let error = ErrorType.unAvailabelError
                        observer.onError(error)
                    }
                    else{
                        
                        if let data = response.data, let responseJSON = data.decode(modelType: BaseResponse.self), let message: String = responseJSON.message {
                            
                            let error = ErrorType.KnownError(message)
                            observer.onError(error)
                        }else{
                            let error = ErrorType.UnKnownError
                            observer.onError(error)
                        }
                    }
                    
                }
            }
            return Disposables.create()
        }
    }
    

}

//MARK:- CHECK NETWORK
extension ApiClient {
    
    static func isOnline(callback: @escaping (Bool) -> Void){
        //declare this property where it won't go out of scope relative to your listener
        
        let reachability = try! Reachability()
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                callback(true)
            } else {
                print("Reachable via Cellular")
                callback(true)
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            callback(false)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
            callback(false)
        }
    }
    
    static func checkReachable() -> Bool{
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.raywenderlich.com")
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        if (isNetworkReachable(with: flags))
        {
            if flags.contains(.isWWAN) {
                return true
            }
            
            return true
        }
        else if (!isNetworkReachable(with: flags)) {
            return false
        }
        
        return false
    }
    
    static func checkReachable(success : @escaping () -> Void,
                               failure : @escaping () -> Void){
        
        if checkReachable() {
            success()
        }else{
            failure()
        }
        
    }
    
    static func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
}
