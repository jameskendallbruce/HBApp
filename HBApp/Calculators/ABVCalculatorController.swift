//
//  ABVCalculatorController.swift
//  HBApp
//
//  Created by Nolan Bruce on 8/22/19.
//  Copyright © 2019 Nolan Bruce. All rights reserved.
//

import UIKit

class ABVCalculatorController : UIViewController {
    
    
    @IBOutlet weak var ABVCalculation: UILabel!
    @IBOutlet weak var OGTextField: UITextField!
    @IBOutlet weak var FGTextField: UITextField!
    @IBOutlet weak var butCalculateABV: UIButton!
    //@IBOutlet weak var OG: UITextField!
    //@IBOutlet weak var FG: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(calculateABV(OG: 1.050, FG: 1.010))
        butCalculateABV.layer.cornerRadius = 5
    }
    
    /*
    * Calculates ABV with function (@OG - @FG) * 131.25
    *
    * If either gravity reading is invalid or if FG is greater than OG, returns a
    * negative number, indicating failure
    *
    * Returns a Float representation of abv
    */
    func calculateABV(OG: Float, FG: Float) -> Float {
        print("calculateABV called")
        var abv: Float = 0.0
        
        //TODO: Display error message on console in case of invalid parameters
        //If OG or FG are invalid, return a negative number
        if (OG < 1) || (FG < 1) {
            print("OG and FG must both be greater than 1")
            return -1.0
        }
        //if FG is greater than OG, return a negative number
        if (FG > OG) {
            print("Final Gravity must be less than Original Gravity")
            return -1.0
        }
        
        abv = ((OG - FG) * 131.25)
        
        print("calculateABV returning")
        return String(format: "%.2f", abv).toFloat
    }
    
    
    @IBAction func onFGTextFieldGo(_ sender: Any) {
        self.onCalculateABV(self)
    }
 
    @IBAction func onCalculateABV(_ sender: Any) {
        print("onCalculateABV called")
        if ((self.OGTextField.text! != "") && (self.FGTextField.text! != "")) {
            print("OG.text: " + self.OGTextField.text!)
            print("FG.text: " + self.FGTextField.text!)
            if ((self.OGTextField.text!.isNumeric) && (self.FGTextField.text!.isNumeric)) {
                let OG = self.OGTextField.text!.toFloat
                let FG = self.FGTextField.text!.toFloat
                let result = calculateABV(OG: OG, FG: FG)
                print("Result: " + String(result))
                ABVCalculation.text = "ABV: " + String(result) + "%"
            } else {
                print("OG and FG values must be numeric")
            }
        } else {
            print("Error. Input a value for both OG and FG")
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
        let sb = segue.destination as! ABVCalculatorController
        sb.butCalculateABV.layer.cornerRadius = 5
    }
    */
}

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
        return Set(self).isSubset(of: nums)
    }
    
    var toFloat: Float {
        return (self as NSString).floatValue
    }
}
