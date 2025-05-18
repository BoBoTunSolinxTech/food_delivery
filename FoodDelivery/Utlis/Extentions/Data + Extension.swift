
import Foundation
import SwiftyJSON
import CommonCrypto
extension Data {
    
    func decode<T>(modelType: T.Type) -> T? where T : Decodable{
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(modelType, from: self)
            return result
        } catch let jsonError{
            print("an error occur while decoding . . . \(jsonError.localizedDescription) >>>>> \(modelType)")
            return nil
        }
    }
    
    func singleDecode<T>(key : ApiConfig.FilterKey, type : T.Type) -> T? {
        let json = JSON(self)
        return json[key.getString()].rawValue as? T
    }
    
    func toJsonString() -> String? {
        let json = JSON(self)
        let jsonString = json.rawString()
        return jsonString
    }
    
    func filterByKey(keys : ApiConfig.FilterKey...) -> Data {
        
        var json = JSON(self)
        
        keys.forEach { (key) in
            json = json[key.getString()]
        }
        
        let jsonString = json.rawString()
        let data = Data(jsonString!.utf8)
        return data
    }
    
    
    
    public func sha256() -> String{
        return hexStringFromData(input: digest(input: self as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
    
}
