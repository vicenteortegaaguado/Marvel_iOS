//
//  main.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 01/07/2021.
//

import UIKit

// UnitTestAppDelegate to avoid executing code in AppDelegate when run test
let appDelegateClass: AnyClass = NSClassFromString("UnitTestAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
