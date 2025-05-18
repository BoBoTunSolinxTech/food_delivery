
import Foundation
import Combine

///API Error mapping
enum APIError: String, Error {
    case invalidURL             = "Invalid url"
    case invalidResponse        = "Invalid response"
    case decodeError            = "Decode error"
    case pageNotFound           = "Requested page not found!"
    case noData                 = "Oops! No words found."
    case noNetwork              = "Internet connection not available!"
    case unknownError           = "Unknown error"
    case serverError            = "Server not found, operation could't not be completed!"

    static func checkErrorCode(_ errorCode: Int = 0) -> APIError {
        switch errorCode {
        case 400:
            return .invalidURL
        case 500:
            return .serverError
        case 404:
            return .pageNotFound
        default:
            return .unknownError
        }
    }

    static func parseDecodingError(_ error: DecodingError) -> String {
        var errorToReport = error.localizedDescription
        switch error {
        case .dataCorrupted(let context):
            let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }
                .joined(separator: ".")
            errorToReport = "\(context.debugDescription) - (\(details))"
        case .keyNotFound(let key, let context):
            let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }
                .joined(separator: ".")
            errorToReport = "\(context.debugDescription) (key: \(key), \(details))"
        case .typeMismatch(let type, let context), .valueNotFound(let type, let context):
            let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }
                .joined(separator: ".")
            errorToReport = "\(context.debugDescription) (type: \(type), \(details))"
        @unknown default:
            break
        }
        return errorToReport
    }
}
