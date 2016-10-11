//
//  AsyncValidationLockConfiguration.swift
//  PasscodeLock
//
//  Created by Kirby Turner on 10/10/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import Foundation
import PasscodeLock

struct AsyncValidationLockConfiguration: PasscodeLockConfigurationType {
  
  let repository: PasscodeRepositoryType
  let passcodeLength = 4
  var isTouchIDAllowed = true
  let shouldRequestTouchIDImmediately = true
  let maximumInccorectPasscodeAttempts = -1
  let useAsyncValidation = true
  
  init(repository: PasscodeRepositoryType) {
    
    self.repository = repository
  }
  
  init() {
    
    self.repository = AsyncValidationRepositoryType()
  }
}
