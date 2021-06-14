//
//  AlertManager.swift
//  Empresas
//
//  Created by Marcos Jr on 01/06/21.
//

import UIKit
import SwiftMessages

class AlertManager {
    private var alertView: MessageView?
    private var toastAlertType: ToastAlertType?
    private var alertController: UIAlertController?
    var alertType: AlertType
    private var title: String?
    private var message: String?
    
    /// Alert types
    ///
    /// - toast: For toast alert selection
    enum AlertType {
        case toast
        case normal
        case confirm
    }
    
    /// Toast Alert types to choose layout definition
    ///
    /// - success: When success needs to be displayed
    /// - info: When info needs to be displayed
    /// - error: When error needs to be displayed
    enum ToastAlertType {
        case success
        case error
        case neutral
    }
    
    /// Initializer for toast
    ///
    /// - Parameters:
    ///   - toastType: What kind of toast based on ToastAlertType
    ///   - title: The alert title
    ///   - message: The message
    init(with toastType: ToastAlertType, title: String, message: String) {
        alertType      = .toast
        toastAlertType = toastType
        self.title     = title
        self.message   = message
        alertView      = MessageView.viewFromNib(layout: .cardView)
        createToastAlert()
    }
    
    /// Init of normal alert type
    ///
    /// - Parameters:
    ///   - title: String - The given title
    ///   - message: String - The given message
    init(withTitle title: String, andMessage message: String ) {
        alertType = .normal
        self.title = title
        self.message = message
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    /// Init of normal alert type
    ///
    /// - Parameters:
    ///   - title: String - The given title
    ///   - message: String - The given message
    ///   - alertType: AlertType - The given type of alert
    init(with alertType: AlertType, title: String, andMessage message: String) {
        self.alertType = alertType
        self.title = title
        self.message = message
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    /// Display the alert in the current context
    ///
    /// - Parameter completion: Completion handler for
    func show(_ completion: (() -> Void)? = nil,
              _ completionNeg: (() -> Void)? = nil,
              confirm: String? = nil,
              negative: String? = nil) {
        switch alertType {
        case .toast:
            var config = SwiftMessages.defaultConfig
            config.presentationContext = .window(windowLevel: UIWindow.Level(rawValue: UIWindow.Level.normal.rawValue))
            config.eventListeners.append({ event in
                if case .didHide = event { completion?() }
            })
            DispatchQueue.main.async {
                SwiftMessages.show(config: config, view: self.alertView!)
            }
        case .normal:
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
                completion?()
            })
            alertController?.addAction(action)
            
            postToWindow()
        case .confirm:
            let actionNo = UIAlertAction(title: "Não", style: .cancel, handler: nil)
            
            let actionYes = UIAlertAction(title: "Sim", style: .default) { (_) in
                completion?()
            }
            
            alertController?.addAction(actionNo)
            alertController?.addAction(actionYes)
            
            let window = UIApplication.shared.delegate!.window ?? UIWindow()
            window?.rootViewController?.present(alertController!, animated: true, completion: nil)
        }
    }
    
    func postToWindow() {
        let window = UIApplication.shared.delegate!.window ?? UIWindow()
        window?.rootViewController?.present(alertController!, animated: true, completion: nil)
    }
    
    private func createToastAlert() {
        let greenBackground = UIColor.init(red: 115, green: 183, blue: 67, alpha: 1)
        switch toastAlertType! {
        case .success:
            alertView!.configureTheme(.success)
            alertView!.configureTheme(backgroundColor: greenBackground, foregroundColor: .white)
        case .error:
            alertView!.configureTheme(.error)
            alertView!.configureTheme(backgroundColor: UIColor.red, foregroundColor: .white)
        case .neutral:
            alertView!.configureTheme(.info)
            alertView!.backgroundColor = UIColor.clear
        }
        alertView!.configureContent(title: self.title!, body: self.message!)
        alertView!.button?.isHidden = true
    }
}
