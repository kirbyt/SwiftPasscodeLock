//
//  PasscodeLockConfigurationType.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public protocol PasscodeLockConfigurationType {
    
    var repository: PasscodeRepositoryType {get}
    var passcodeLength: Int {get}
    var isTouchIDAllowed: Bool {get set}
    var maximumFailedAttempts: Int {get}
}
