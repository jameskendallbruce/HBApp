//
//  JSONHelper.swift
//  HBApp
//
//  Created by Nolan Bruce on 8/31/19.
//  Copyright © 2019 Nolan Bruce. All rights reserved.
//

import Foundation

class JSONHelper {
    static func writeToFile(file: String, json: String) -> Bool {
        print("Entering writeToFile")
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                try json.write(to: fileURL, atomically: false, encoding: .utf8)
                return true
            }
            catch {
                //TODO: Add actual exception handling
                print("Damn something went wrong, dog")
                return false
            }
        }
        return false
    }
    
    static func readStringFromFile(file: String) -> String {
        print("Entering readStringFromFile")
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            print(fileURL)
            do {
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                print(text)
                return text
            }
            catch {
                //TODO: Add actual exception handling
                print("Damn something went wrong, dog")
                return ""
            }
        }
        return ""
    }
    
    static func readJSONFromFile(file: String) -> [String: AnyObject]? {
        print("Entering readJSONFromFile")
        let text = readStringFromFile(file: file)
        return convertToDictionary(text: text)
    }
    
    static func convertToDictionary(text: String) -> [String: AnyObject]? {
        print("Entering convertToDictionary")
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]
            } catch {
                print("Error in convertToDictionary: ")
                print(error)
            }
        }
        return nil
    }
}
