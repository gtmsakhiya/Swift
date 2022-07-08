//
//  ViewController.swift
//  internetCheckDemo
//
//  Created by Gautam Sakhiya on 25/06/22.
//

import UIKit
import Reachability

class ViewController: UIViewController {
    
    @IBOutlet weak var lblCheckInternetText:UILabel!
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startMonitoring()
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            lblCheckInternetText.text = "Reachable via WiFi"
        case .cellular:
            print("Reachable via Cellular")
            lblCheckInternetText.text = "Reachable via Cellular"
        case .unavailable:
            print("Network not unavailable")
            lblCheckInternetText.text = "Network not unavailable"
        case .none:
            print("Network not reachable")
        }
    }
    
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    func stopMonitoring() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}

