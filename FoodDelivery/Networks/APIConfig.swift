//
//  APIConfig.swift
//  FattyCustomer
//
//  Created by Phyo Kyaw Swar on 23/11/2021.
//

import Foundation
struct ApiConfig {
#if DEBUG
    //http://128.199.241.129 production
    static private let BaseDomain = "http://188.166.226.161"
#else
    /* Production with testing server*/
    
    static private let BaseDomain = "http://188.166.226.161"
#endif
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    // MARK: - Filter key for response
    enum FilterKey : String{
        
        case data = "data"
        case success = "success"
        case message = "message"
        case isOld = "is_old"
        case orderStatus = "order_status"
        case customerAddress = "customer_address"
        case restaurant = "restaurant"
        case paymentMethod = "payment_method"
        case foods = "foods"
        case subItem = "sub_item"
        case option = "option"
        case customer = "customer"
        case activeOrder = "active_order"
        case pastOrder = "past_order"
        case url = "url"
        case order = "order"
        
        func getString() -> String {
            return self.rawValue
        }
    }
    
    // MARK: - Param keys
    enum ParamKeys : String {
        case categoryId = "category_id"
        case restaurantId = "restaurant_id"
        case foodMenuId = "food_menu_id"
        case searchType = "search_type"
        case searchName = "search_name"
        case categoryList = "category_list"
        case customerId = "customer_id"
        case customerPhone = "customer_phone"
        case image = "image"
        case fcmToken = "fcm_token"
        case orderDescription = "order_description"
        case foodList = "food_list"
        case customerAddressId = "customer_address_id"
        case deliveryFee = "delivery_fee"
        case itemTotalPrice = "item_total_price"
        case billTotalPrice = "bill_total_price"
        case customerAddressLat = "customer_address_latitude"
        case customerAddressLong = "customer_address_longitude"
        case paymentMethodId = "payment_method_id"
        case orderID = "order_id"
        case riderID = "rider_id"
        case fromSenderName = "from_sender_name"
        case fromSenderPhone = "from_sender_phone"
        case fromPickUpAddress = "from_pickup_address"
        case fromPickUpLat = "from_pickup_latitude"
        case fromPickUpLong = "from_pickup_longitude"
        case toRecipentName = "to_recipent_name"
        case toRecipentPhone = "to_recipent_phone"
        case toDropAddress = "to_drop_address"
        case toDropLat = "to_drop_latitude"
        case toDropLong = "to_drop_longitude"
        case parcelTypeId = "parcel_type_id"
        case totalEstimateWeight = "total_estimated_weight"
        case parcelOrderNote = "parcel_order_note"
        case parcelExtraCoverId = "parcel_extra_cover_id"
        case parcelImageList = "parcel_image_list"
        case customerName = "customer_name"
        case addressLatitude = "address_latitude"
        case addressLongitude = "address_longitude"
        case currentAddress = "current_address"
        case buildingSystem = "building_system"
        case addressType = "address_type"
        case orderType = "order_type"
        case rating = "rating"
        case description = "description"
        case stateName = "state_name"
        case latitude = "latitude"
        case longitude = "longitude"
        case stateID = "state_id"
        case zoneID = "zone_id"
        case osType = "os_type"
        case version = "version"
        case otp = "otp"
        case customerTypeId = "customer_type_id"
        case toDropNote = "to_drop_note"
        case fromPickupNote = "from_pickup_note"
        case fromParcelCityId = "from_parcel_city_id"
        case toParcelCityId = "to_parcel_city_id"
        case customerAddressPhone = "customer_address_phone"
        case fromBlockId = "from_block_id"
        case toBlockId = "to_block_id"
        case parcelBlockId = "parcel_block_id"
        case phone = "phone"
        case address = "address"
        case parcelDefaultAddressId = "parcel_default_address_id"
        case date = "date"
        case startDate = "start_date"
        case endDate = "end_date"
        case notiType = "noti_type"
        case page = "page"
        case deliveryFeeCurrency = "delivery_fee_currency"
        case extraCoverageCurrency = "extra_coverage_currency"
        case totalEstimatedCurrency = "total_estimated_currency"
        case exchangeRate = "exchange_rate"
        case extraCoverage = "extra_coverage"
        case itemQty = "item_qty"
        case deliveryFeeOrigin = "delivery_fee_origin"
        case merchantAdsID = "merchant_ads_id"
        case ratingType = "rating_type"
        case stars = "star"
        case options = "options"
        case comment = "comment"
        case abnormalFee = "abnormal_fee"
    }

    
}
