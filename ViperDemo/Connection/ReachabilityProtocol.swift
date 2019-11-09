//
//  File.swift
//  TooliEngine
//
//  Created by Abdelrahman Ahmed on 1/23/19.
//

import RxSwift
import Reachability
import RxReachability

public protocol ReachabilityProtocol:class {
    var isReachable:Observable<Bool> {get}
    var isReachableNow:Bool {get}
}

extension ReachabilityProtocol {
    
    public var isReachable:Observable<Bool> {
        return Reachability.shared.rx.status
            .map { connection in
            return connection != .none
        }
    }
    
    public var isReachableNow:Bool {
        return Reachability.shared.connection != .none
    }
}
