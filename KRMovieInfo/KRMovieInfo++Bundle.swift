//
//  KRMovieInfo++Bundle.swift
//  KRMovieInfo
//
//  Created by Jae-hoon Sim on 2022/05/01.
//

import Foundation

extension Bundle {
    var kofic_apiKey_main: String {
        guard let file = self.path(forResource: "Info", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["KOFIC_API_KEY1"] as? String else { fatalError() }
        return key
    }
    var kofic_apiKey_sub: String {
        guard let file = self.path(forResource: "Info", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["KOFIC_API_KEY2"] as? String else { fatalError() }
        return key
    }
}
