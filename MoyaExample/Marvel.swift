//
//  Marvel.swift
//  MoyaExample
//
//  Created by intern on 6/5/23.
//

import Foundation
import Moya

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
    return URL(string: "https://api.themoviedb.org/3/")!
  }

  // 2
  public var path: String {
    switch self {
    case .comics: return "search/movie"
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
      
      switch self {
      case .comics:
        // 3
        return .requestParameters(
          parameters: [
            "api_key": "4f593a1326880ff31e844e8adafefeb8",
            "query": "all"],
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
