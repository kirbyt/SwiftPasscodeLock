//
//  AsyncValidationRepositoryType.swift
//  PasscodeLock
//
//  Created by Kirby Turner on 10/10/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import Foundation
import PasscodeLock

class AsyncValidationRepositoryType: PasscodeRepositoryType {
  
  fileprivate let passcodeKey = "passcode.lock.passcode"
  
  fileprivate lazy var defaults: UserDefaults = {
    return UserDefaults.standard
  }()

  var hasPasscode: Bool {
    return (self.passcode != nil)
  }
  
  var passcode: [String]? {
    return defaults.value(forKey: passcodeKey) as? [String] ?? nil
  }
  
  func savePasscode(_ passcode: [String]) {
    
    defaults.set(passcode, forKey: passcodeKey)
    defaults.synchronize()
  }
  
  func deletePasscode() {
    
    defaults.removeObject(forKey: passcodeKey)
    defaults.synchronize()
  }
  
  func validate(_ passcode: [String], completion: @escaping (Bool) -> Void) {

    // Make an asynchronous call, then call completion handler.
    
    guard let savedPasscode = self.passcode else {
      completion(false)
      return
    }
    
    completion(passcode == savedPasscode)
  }
  
}
