//
//  ConnectionManager.swift
//  Baluchon
//
//  Created by Zidouni on 14/05/2023.
//

import Foundation

protocol ConnectionManager {
    func isConnected() -> Bool
    var isNetworkReachable: Bool { get }
}

class RealConnectionManager: ConnectionManager {
    var isNetworkReachable: Bool = true
    
    func isConnected() -> Bool {
        return isNetworkReachable
    }
}

class NoConnectionManager: ConnectionManager {
    var isNetworkReachable: Bool = false
    
    func isConnected() -> Bool {
        return isNetworkReachable
    }
}
