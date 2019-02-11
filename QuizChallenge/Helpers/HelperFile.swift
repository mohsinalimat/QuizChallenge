//
//  HelperFile.swift
//  QuizChallenge
//
//  Created by Anton Makarov on 28/01/2019.
//  Copyright © 2019 Anton Makarov. All rights reserved.
//

import UIKit
import SCLAlertView

// MARK: - Closure typealias

public typealias EmptyClosure = () -> Void
public typealias BoolClosure = () -> Bool
public typealias IntClosure = () -> Int
public typealias StringClosure = () -> String

// MARK: - Alert Helper

enum AlertType {
    case warning
    case error
    case success
}

class AlertHelper {
    
    let timeOutShowing = 3.0
    let colorTextButton: UInt = 0xFFFFFF
    
    // Question Alert
    func showConfirmView(title: String, subTitle: String, firstButtonText: String, secondButtonText: String? = nil, completion: @escaping EmptyClosure, secondCompletion: EmptyClosure? = nil) {
        
        let alertView = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false))
        alertView.addButton(firstButtonText) { completion() }
        
        if let text = secondButtonText, secondCompletion != nil {
            alertView.addButton(text) { secondCompletion?() }
        }
        
        alertView.showTitle(title, subTitle: subTitle, style: .question, closeButtonTitle: nil, timeout: nil, colorStyle: 0x43577E, colorTextButton: colorTextButton, circleIconImage: nil)
    }
    
    // Simple Alert with duration
    func showAlertView(title: String, subTitle: String, buttonText: String, type: AlertType, completion: EmptyClosure? = nil) {
        
        let alertView = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false))
        alertView.addButton(buttonText) { completion?() }
        
        let timeOut = SCLAlertView.SCLTimeoutConfiguration(timeoutValue: timeOutShowing, timeoutAction: { completion?() })

        // App Color: 0x43577E
        switch type {
        case .warning:
            alertView.showWarning(title, subTitle: subTitle, closeButtonTitle: buttonText, timeout: timeOut)
        case .error:
            alertView.showError(title, subTitle: subTitle, closeButtonTitle: buttonText, timeout: timeOut)
        case .success:
            alertView.showSuccess(title, subTitle: subTitle, closeButtonTitle: buttonText, timeout: timeOut)
        }
    }
}

// MARK: - Common Helper Class

class CommonHelper {
    
    static var alert = AlertHelper()
    
    static func loadViewController(from storyboard: String, named name: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: name)
    }
    
    // Load test file with questions
    static func loadJsonCategories(from file: String) -> TypeDecodable? {
        
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                guard let jsonResult = try? JSONDecoder().decode(TypeDecodable.self, from: data) else {
                    print("Error parse json")
                    return nil
                }
                
                return jsonResult
            } catch {
                print("Error load json: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
}
