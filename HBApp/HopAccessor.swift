//
//  HopAccessor.swift
//  HBApp
//
//  Created by Nolan Bruce on 8/23/19.
//  Copyright © 2019 Nolan Bruce. All rights reserved.
//

import Foundation

struct Hop {
    var name : String
    var oz : Float
    var aa : Float
    var min : Int
    //let dq = "\""
    
    init(name : String, oz : Float, aa : Float, min : Int) {
        self.name = name
        self.oz = oz
        self.aa = aa
        self.min = min
    }
    
    init() {
        self.name = ""
        self.oz = Float(0)
        self.aa = Float(0)
        self.min = Int(0)
    }
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let oz = json["oz"] as? Float,
            let aa = json["aa"] as? Float,
            let min = json["min"] as? Int
        else {
                return nil
        }
        self.name = name
        self.oz = oz
        self.aa = aa
        self.min = min
    }
    
    func toJSON() -> String {
        var result = "\n\"" + self.name + "\" : {\n"
        
        result += "    \"oz\" : " + String(self.oz) + ",\n"
        result += "    \"aa\" : " + String(self.aa) + ",\n"
        result += "    \"min\" : " + String(self.min) + "\n"
        
        result += "}"
        return result
    }
    
    //Just trying to make things pretty
    func toJSON(tabs: Int) -> String {
        var result = addTabs(i: tabs) + "\"" + self.name + "\" : {\n"
        
        result += addTabs(i: tabs) + "    \"oz\" : " + String(self.oz) + ",\n"
        result += addTabs(i: tabs) + "    \"aa\" : " + String(self.aa) + ",\n"
        result += addTabs(i: tabs) + "    \"min\" : " + String(self.min) + "\n"
        
        result += addTabs(i: tabs) + "}"
        return result
    }
}

struct Hops {
    fileprivate var hops : [Hop] = []
    
    init() {
        //do nothing
    }
    
    init(aHop: Hop) {
        self.hops.append(aHop)
    }
    
    init(hops: [Hop]) {
        for hop in hops {
            self.hops.append(hop)
        }
    }
    
    mutating func append(aHop: Hop) {
        self.hops.append(aHop)
    }
    
    func getHop(name: String) -> Hop {
        for hop in hops {
            if hop.name == name {
                return hop
            }
        }
        return Hop()
    }
    
    func toJSON() -> String {
        var result = "{\n" + addTabs(i: 1) + "\"Hops\" : {\n"
        
        for i in 0...(self.hops.count - 1) {
            result += self.hops[i].toJSON(tabs: 2)
            if i < self.hops.count - 1 {
                result += ","
            }
            result += "\n"
        }
        
        result += addTabs(i: 1) + "}\n}"
        return result
    }
}

class HopAccessor {
    
    let hopsFile = "Hops.json" //this is the file. we will write to and read from it
    //let text = "{\"test\" : \"test\"}" //just a text
    var hops : Hops = Hops()


    init() {
        print("HopAccessor.init, init?")
        var hopsJSON: [String: AnyObject]
        
        //First make sure our hopsFile exists.
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            do {
                let fileURL = dir.appendingPathComponent(self.hopsFile)
                if(FileManager.default.fileExists(atPath: (fileURL.path))){  // just use String when you have to check for existence of your file
                    print("File exists")
                } else {
                    print("Hops file doesn't exist. Initializing one with a few common hops.")
                    var magnum, kentGoldings, cascade : Hop
                    //Magnum Hops
                    magnum = Hop(name : "Magnum", oz : Float(2), aa : Float(13), min : 60)
                    self.hops.append(aHop: magnum)
                    //Kent Golding Hops
                    kentGoldings = Hop(name : "Kent Goldings", oz : Float(1), aa : Float(5.5), min : 30)
                    self.hops.append(aHop: kentGoldings)
                    //Cascade Hops
                    cascade = Hop(name : "Cascade", oz : Float(1), aa : Float(5.3), min : 10)
                    self.hops.append(aHop: cascade)
                    if JSONHelper.writeToFile(file: self.hopsFile, json: self.hops.toJSON()) {
                        print("Successfully initialized new hop file.")
                    } else {
                        print("Failed to initialize new hops file.")
                    }
                }
            }
        }
    
        //Read in
        //print(JSONHelper.readJSONFromFile(file: self.hopsFile) as Any)
        hopsJSON = JSONHelper.readJSONFromFile(file: self.hopsFile)!
        for tmp in hopsJSON["Hops"] as! [String: Any] {
            //(tmp)
            var aa: Float
            var oz: Float
            var min: Int
            
            let hop = tmp.value as! [String: Any]
            
            let name = tmp.key
            print(name)
            
            if let n = hop["oz"] as? NSNumber {
                oz = n.floatValue
            } else {
                oz = Float(0)
            }
            print(oz)
            
            if let n = hop["aa"] as? NSNumber {
                aa = n.floatValue
            } else {
                aa = Float(0)
            }
            print(aa)
            
            if let n = hop["min"] as? NSNumber {
                min = n.intValue
            } else {
                min = Int(0)
            }
            print(min)
            
            self.hops.append(aHop: Hop(name: name, oz: oz, aa: aa, min: min))
        }
        
        print(self.hops.toJSON())
    }
    
    func saveHop(aHop: Hop) {
        self.hops.append(aHop: aHop)
    }
    
    func getHop(name: String) -> Hop {
        return self.hops.getHop(name: name)
    }
    
    func writeToFile() -> Bool {
        return JSONHelper.writeToFile(file: self.hopsFile, json: self.hops.toJSON())
    }
}

func addTabs(i: Int) -> String {
    var tabs = ""
    let tab = "    "
    
    for _ in 1...i {
        tabs += tab
    }
    return tabs
}
