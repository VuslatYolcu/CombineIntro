//
//  APICaller.swift
//  CombineIntro
//
//  Created by Vuslat Yolcu on 8.10.2023.
//

import Foundation
import Combine

class APICaller {
    static let shared = APICaller()
    
    func fetchCompanies() -> Future<[String], Error> {
        
        return Future { promixe in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                promixe(.success(["Apple", "Google", "Microsoft", "Facebook"]))
            }
        }
    }
}
