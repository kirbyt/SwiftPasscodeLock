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
    
    fileprivate var inccorectPasscodeAttempts = 0
    fileprivate var isNotificationSent = false
    
    init(allowCancellation: Bool = false) {
        
        isCancellableAction = allowCancellation
        title = localizedStringFor("PasscodeLockEnterTitle", comment: "Enter passcode title")
        description = localizedStringFor("PasscodeLockEnterDescription", comment: "Enter passcode description")
    }
    
    mutating func acceptPasscode(_ passcode: [String], fromLock lock: PasscodeLockType) {
      
        if lock.configuration.useIsPasscodeValidAsync {
          lock.repository.isPasscodeValidAsync(passcode) { (valid) in
            if valid {
              self.performAcceptPasscode(passcode, currentPasscode: passcode, fromLock: lock)
              
            } else {
              self.performAcceptPasscode(passcode, currentPasscode: [], fromLock: lock)
            }
          }
        } else {
          guard let currentPasscode = lock.repository.passcode else {
            return
          }
          performAcceptPasscode(passcode, currentPasscode: currentPasscode, fromLock: lock)
      }
    }
  
    fileprivate mutating func performAcceptPasscode(_ passcode: [String], currentPasscode: [String], fromLock lock: PasscodeLockType) {
      
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
  
    fileprivate mutating func postNotification() {
      
        guard !isNotificationSent else { return }
            
        let center = NotificationCenter.default
        
        center.post(name: Notification.Name(rawValue: PasscodeLockIncorrectPasscodeNotification), object: nil)
        
        isNotificationSent = true
    }
}
