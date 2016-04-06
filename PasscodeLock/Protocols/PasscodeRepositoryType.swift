//
//  PasscodeRepositoryType.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public protocol PasscodeRepositoryType {
    
    var hasPasscode: Bool {get}
    var passcode: [String]? {get}
    
    func savePasscode(passcode: [String])
    func deletePasscode()
    func passcodeAsync(completion: (currentPasscode: [String]?) -> Void)
}

public extension PasscodeRepositoryType {
  // Provide a default implementation. 
  func passcodeAsync(completion: (currentPasscode: [String]?) -> Void) {
    completion(currentPasscode: passcode)
  }
}
