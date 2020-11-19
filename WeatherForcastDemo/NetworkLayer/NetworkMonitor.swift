//
//  NetworkMonitor.swift
//  WeatherForcastDemo
//
//  Created by Usman Ansari on 18/11/20.
//  Copyright © 2020 Usman Ansari. All rights reserved.
//
import Foundation
import Network
class NetworkMonitor {
    static let shared = NetworkMonitor()

    var monitor: NWPathMonitor?
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true

    func startMonitoring() {
        self.monitor = NWPathMonitor()
        self.monitor?.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive

            if path.status == .satisfied {
                // post connected notification
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Network.NetworkReachabilityChanged), object: nil, userInfo: [Constants.Network.kReachability:true])
                }
            } else {
                // post disconnected notification
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Network.NetworkReachabilityChanged), object: nil, userInfo: [Constants.Network.kReachability:false])
                }
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        self.monitor?.start(queue: queue)
    }

    func stopMonitoring() {
        self.monitor?.cancel()
    }
}
