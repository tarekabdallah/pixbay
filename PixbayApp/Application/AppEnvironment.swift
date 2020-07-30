//
//  AppEnvironment.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

struct AppEnvironment {
    /// The Sheme currently running
    enum RunningTarget {
        case develop
        case production
    }

    private static var runningTarget: RunningTarget {
        var target: RunningTarget
        #if DEBUG
        target = .develop
        #else
        target = .production
        #endif
        return target
    }

    static var isDevelopTarget: Bool {
        return runningTarget == .develop
    }

    static var isProductionTarget: Bool {
        return runningTarget == .production
    }

    static var shouldUseDebugConfig: Bool {
        return !isProductionTarget
    }
}
