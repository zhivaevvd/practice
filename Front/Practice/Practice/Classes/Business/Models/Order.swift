//
// Practice
// Copyright © 2024 Vladislav Zhivaev. All rights reserved.
//

import Foundation

struct Order: Decodable, Hashable, Equatable, Encodable {
    let id: Int
    let authId: Int
    let number: Int
    let productId: String
    let productPrevieew: String
    let productQuantity: Int
    let productSize: String
    let createdAt: String
    let etd: String
    let deliveryAddress: String
    let status: String
}
