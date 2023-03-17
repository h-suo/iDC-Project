//
//  Unit.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/17.
//

import UIKit

extension Date {
    func writingTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY-MM-dd HH:mm"
        return formatter.string(from: Date())
    }
}

extension UIViewController {
    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }
}
