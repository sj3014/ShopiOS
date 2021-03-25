//
//  AppConfigure.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/15.
//

import UIKit

enum BuildPhase: String {
    case Debug = "Debug"
    case Release = "Release"
}

class AppConfigure {
    static let shared = AppConfigure()
    
    lazy private(set) var bundleName = { [weak self] in
        return self?.infoForKey("Bundle name") ?? ""
    }()
    
    lazy private(set) var buildPhase = { [weak self] in
        return BuildPhase(rawValue: self?.infoForKey("BUILD_PHASE") ?? "")
    }()
    
    lazy private(set) var baseURL = { [weak self] in
        return self?.infoForKey("BASE_URL") ?? ""
    }()
    
    private init() {}
    
    private func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "")
    }
}
