//
//  AppCoordinator+Alert.swift
//  EduVPN
//
//  Created by Jeroen Leenarts on 09-06-18.
//  Copyright © 2018 SURFNet. All rights reserved.
//

import UIKit

import AppAuth

extension AppCoordinator {

    public func dueToUserCancellation(error: Error) -> Bool {
        let error = error as NSError
        return error.domain == OIDGeneralErrorDomain && (error.code == OIDErrorCode.programCanceledAuthorizationFlow.rawValue || error.code == OIDErrorCode.userCanceledAuthorizationFlow.rawValue)
    }
    public func showError(_ error: Error) {
        if dueToUserCancellation(error: error) {
            return
        }

        showAlert(title: NSLocalizedString("Error", comment: "Error alert title"), message: error.localizedDescription)
    }

    func showNoAuthFlowAlert() {
        showAlert(title: "No auth flow available", message: "A call to `resumeAuthFlow` was called, but none available")
    }

    func showNoProfilesAlert() {
        showAlert(title: NSLocalizedString("No profiles available", comment: "No profiles available title"), message: NSLocalizedString("There are no profiles configured for you on the instance you selected.", comment: "No profiles available message"))
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK button"), style: .default))
        self.navigationController.present(alert, animated: true)
    }
}
