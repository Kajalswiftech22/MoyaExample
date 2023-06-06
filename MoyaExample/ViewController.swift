//
//  ViewController.swift
//  MoyaExample
//
//  Created by intern on 6/5/23.
//

import UIKit
import Moya


enum ViewState<T> {
    case loading
    case ready(T)
    case error
}

struct MarvelResponse<T: Codable>: Codable {
    let code: Int
    let status: String
    let data: T
}

struct Comic: Codable {
    let title: String
    let issueNumber: Int
    // Add more properties as per your comic structure
}

class ViewController: UIViewController {

    
    let provider = MoyaProvider<Marvel>()
    
        var state: ViewState<[Comic]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        state = .loading

        // 2
        provider.request(.comics) { [weak self] result in
          guard let self = self else { return }

          // 3
          switch result {
          case .success(let response):
            do {
              // 4
              print(try response.mapJSON())
            } catch {
                do {
                    let marvelResponse = try response.map(MarvelResponse<[Comic]>.self)
                    let comics = marvelResponse.data
                    self.state = .ready(comics)
            } catch {
                    self.state = .error
            }

            }
          case .failure:
            // 5
            self.state = .error
          }
        }
    }


}

