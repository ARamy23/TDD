//
//  AccessToken.swift
//  TDD
//
//  Created by Ahmed Ramy on 05/01/2022.
//  Copyright © 2022 Ahmed Ramy. All rights reserved.
//

import Foundation

public final class AccessToken: Codable {
  let accessToken: String
  let refreshToken: String
  
  init(accessToken: String = "", refreshToken: String = "") {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}
