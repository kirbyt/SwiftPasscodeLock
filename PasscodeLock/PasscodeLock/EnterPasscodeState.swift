//
//  EnterPasscodeState.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public let PasscodeLockIncorrectPasscodeNotification = "passcode.lock.incorrect.passcode.notification"

struct EnterPasscodeState: PasscodeLockStateType {
    
    let title: String
    let description: String
    let isCancellableAction: Bool
    var isTouchIDAllowed = true
    
    private var inccorectPasscodeAttempts = 0
    private var isNotificationSent = false
    
    init(allowCancellation: Bool = false) {
        
        isCancellableAction = allowCancellation
        title = localizedStringFor("PasscodeLockEnterTitle", comment: "Enter passcode title")
        description = localizedStringFor("PasscodeLockEnterDescription", comment: "Enter passcode description")
    }
    
    mutating func acceptPasscode(passcode: [String], fromLock lock: PasscodeLockType) {
      
        if lock.configuration.usePasscodeAsync {
          lock.repository.passcodeAsync { (currentPasscode) in
            if let currentPasscode = currentPasscode {
              self.performAcceptPasscode(passcode, currentPasscode: currentPasscode, fromLock: lock)
            }
          }
        } else {
          guard let currentPasscode = lock.repository.passcode else {
            return
          }
          performAcceptPasscode(passcode, currentPasscode: currentPasscode, fromLock: lock)
      }
    }
  
    private mutating func performAcceptPasscode(passcode: [String], currentPasscode: [String], fromLock lock: PasscodeLockType) {
      
      if passcode == currentPasscode {
        
        lock.delegate?.passcodeLockDidSucceed(lock)
        
      } else {
        
        inccorectPasscodeAttempts += 1
        
        if inccorectPasscodeAttempts >= lock.configuration.maximumInccorectPasscodeAttempts {
          
          postNotification()
        }
        
        lock.delegate?.passcodeLockDidFail(lock)
      }
    }
  
    private mutating func postNotification() {
      
        guard !isNotificationSent else { return }
            
        let center = NSNotificationCenter.defaultCenter()
        
        center.postNotificationName(PasscodeLockIncorrectPasscodeNotification, object: nil)
        
        isNotificationSent = true
    }
}
