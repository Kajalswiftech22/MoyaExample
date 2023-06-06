//
//  Marvel.swift
//  MoyaExample
//
//  Created by intern on 6/5/23.
//

import Foundation
import Moya
import CryptoKit

public enum Marvel {
  // 1
  static private let publicKey = "YOUR PUBLIC KEY"
  static private let privateKey = "YOUR PRIVATE KEY"

  // 2
  case comics
}

extension Marvel: TargetType {
  // 1
  public var baseURL: URL {
    return URL(string: "https://gateway.marvel.com/v1/public")!
  }

  // 2
  public var path: String {
    switch self {
    case .comics: return "/comics"
    }
  }

  // 3
  public var method: Moya.Method {
    switch self {
    case .comics: return .get
    }
  }

  // 4
  public var sampleData: Data {
    return Data()
  }

  // 5
    public var task: Task {
        
      let ts = "\(Date().timeIntervalSince1970)"
      // 1
        
      let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5
      
      // 2
      let authParams = ["apikey": Marvel.publicKey, "ts": ts, "hash": hash]
      
      switch self {
      case .comics:
        // 3
        return .requestParameters(
          parameters: [
            "format": "comic",
            "formatType": "comic",
            "orderBy": "-onsaleDate",
            "dateDescriptor": "lastWeek",
            "limit": 50],
          encoding: URLEncoding.default)
      }
    }


  // 6
  public var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }

  // 7
  public var validationType: ValidationType {
    return .successCodes
  }
}

extension String {
    var md5: String {
        let inputData = Data(self.utf8)
        let hashedData = Insecure.MD5.hash(data: inputData)
        let hashString = hashedData.map { String(format: "%02hhx", $0) }.joined()
        return hashString
    }
}
