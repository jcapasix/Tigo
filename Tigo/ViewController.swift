//
//  ViewController.swift
//  Tigo
//
//  Created by Jordan Capa on 4/05/18.
//  Copyright © 2018 Jordan Capa. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController{
    
    var lastMessage: CFAbsoluteTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func tapButtonPressed(_ sender: Any) {
        sendWatchMessage()
    }
    
    func sendWatchMessage() {
        let currentTime = CFAbsoluteTimeGetCurrent()
        
        // if less than half a second has passed, bail out
        if lastMessage + 0.5 > currentTime {
            return
        }
        
        // send a message to the watch if it's reachable
        if (WCSession.default.isReachable) {
            // this is a meaningless message, but it's enough for our purposes
            self.view.backgroundColor = UIColor.blue
            let message = ["Message": "Tap from Phone"]
            WCSession.default.sendMessage(message, replyHandler: nil)
        }
        
        // update our rate limiting property
        lastMessage = CFAbsoluteTimeGetCurrent()
    }
}

extension ViewController: WCSessionDelegate{
    
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("function:\(#function)")
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("function:\(#function)")
        self.view.backgroundColor = UIColor.red
    }
    
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("function:\(#function)")
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("function:\(#function)")
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            print("message: XXX: \(message)")
            self.view.backgroundColor = UIColor.red
        }
    }
    
}

