//
//  ReachabilityService.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import RxSwift

import class Dispatch.DispatchQueue

public enum ReachabilityStatus {
    case reachable(viaWiFi: Bool)
    case unreachable
}

extension ReachabilityStatus {
    var reachable: Bool {
        switch self {
        case .reachable:
            return true
        case .unreachable:
            return false
        }
    }
}

protocol ReachabilityService {
    var reachability: Observable<ReachabilityStatus> { get }
}

enum ReachabilityServiceError: Error {
    case failedToCreate
}

// swiftlint:disable identifier_name
class DefaultReachabilityService: ReachabilityService {

    private let _reachabilitySubject: BehaviorSubject<ReachabilityStatus>

    var reachability: Observable<ReachabilityStatus> {
        return _reachabilitySubject.asObservable()
    }

    let _reachability: Reachability

    init() throws {
        guard let reachabilityRef = Reachability() else { throw ReachabilityServiceError.failedToCreate }
        let reachabilitySubject = BehaviorSubject<ReachabilityStatus>(value: .unreachable)

        // so main thread isn't blocked when reachability via WiFi is checked
        let backgroundQueue = DispatchQueue(label: "reachability.wificheck")

        reachabilityRef.whenReachable = { reachability in
            backgroundQueue.async {
                reachabilitySubject.on(.next(.reachable(viaWiFi: reachabilityRef.isReachableViaWiFi)))
            }
        }

        reachabilityRef.whenUnreachable = { reachability in
            backgroundQueue.async {
                reachabilitySubject.on(.next(.unreachable))
            }
        }

        try reachabilityRef.startNotifier()
        _reachability = reachabilityRef
        _reachabilitySubject = reachabilitySubject
    }

    deinit {
        _reachability.stopNotifier()
    }
}

extension ObservableConvertibleType {
    func retryOnBecomesReachable(_ valueOnFailure: Element,
                                 reachabilityService: ReachabilityService) -> Observable<Element> {
        return self.asObservable()
            .catchError { error -> Observable<Element> in
                reachabilityService.reachability
                    .skip(1)
                    .filter { $0.reachable }
                    .flatMap { _ in
                        Observable.error(error)
                    }
                    .startWith(valueOnFailure)
            }
            .retry()
    }
}
