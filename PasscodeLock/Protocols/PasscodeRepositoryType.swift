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
    
    func savePasscode(_ passcode: [String])
    func deletePasscode()
    func isPasscodeValidAsync(_ passcode: [String], completion: (_ valid: Bool) -> Void)
}

public extension PasscodeRepositoryType {
  // Provide a default implementation. 
  func isPasscodeValidAsync(_ passcode: [String], completion: (_ valid: Bool) -> Void) {
    guard let currentPasscode = self.passcode else {
      completion(false)
      return
    }
    completion((passcode == currentPasscode))
  }
}
