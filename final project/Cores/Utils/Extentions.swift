//
//  Extentions.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 03/08/23.
//

import Foundation

class Extensions {
    // Function to convert HTML to NSAttributedString
    class func convertHTMLToAttributedString(_ htmlString: String) -> NSAttributedString? {
        guard let data = htmlString.data(using: .utf8) else { return nil }

        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]

            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString
        } catch {
            print("Error converting HTML to NSAttributedString: \(error)")
            return nil
        }
    }
}
