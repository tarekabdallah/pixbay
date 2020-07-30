//
//  CameraService.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/30/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import AVFoundation
import RxSwift
import RxCocoa

class CameraService {
    var isAuthorized: Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        return  status == .authorized || status == .restricted
    }

    var authorizationStatus: AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }

    var authorizationStatusStrings = BehaviorRelay<[String]>(value: [])

    init() {
        authorizationStatusStrings.accept(getAuthorizationStatusStrings())
    }

    func requestAuthorization() {
        AVCaptureDevice.requestAccess(for: .video) { _ in
            self.authorizationStatusStrings.accept(self.getAuthorizationStatusStrings())
        }
    }
}

// MARK: - Private Helper Methods
private extension CameraService {
    func getAuthorizationStatusStrings() -> [String] {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return ["camera_service.permission.authorized".localized]
        case .restricted:
            return ["camera_service.permission.restricted".localized]
        default:
            return ["misc.label.disabled".localized]
        }
    }
}
