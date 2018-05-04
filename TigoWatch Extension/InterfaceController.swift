//
//  InterfaceController.swift
//  TigoWatch Extension
//
//  Created by Jordan Capa on 4/05/18.
//  Copyright © 2018 Jordan Capa. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    
    var lastMessage: CFAbsoluteTime = 0
    var count = 0
    let session = WCSession.default
    
    @IBOutlet var groupColor: WKInterfaceGroup!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func TapButtonPressed() {
        self.sendWatchMessage()
        
    }
    
    func sendWatchMessage() {
        if WCSession.isSupported() {
            let msg = ["Count" : "\(count)"]
            
            if session.isReachable {
                self.groupColor.setBackgroundColor(UIColor.red)
                session.sendMessage(msg, replyHandler: nil, errorHandler: { (error) -> Void in
                    print("Error handler: \(error)")
                })
                count += 1
            }
        }
    }
    
}

extension InterfaceController: WCSessionDelegate{
    
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("function:\(#function)")
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("function:\(#function)")
        print("Message: \(message)")
        self.groupColor.setBackgroundColor(UIColor.blue)
        WKInterfaceDevice().play(.click)
    }
    
    
}
