//
//  AuthPayload.swift
//  Practice
//
//  Created by Влад Живаев on 27.06.2024.
//

import Foundation

struct AuthPayload: Encodable {
    let login: String
    let password: String
}
