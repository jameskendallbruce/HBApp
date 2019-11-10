//
//  PrimingCalculatorController.swift
//  HBApp
//
//  Created by Nolan Bruce on 8/22/19.
//  Copyright © 2019 Nolan Bruce. All rights reserved.
//

import UIKit

class PrimingCalculatorController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var cornSugarObj : CornSugar
        
        cornSugarObj = CornSugar(co2: 2.3, volume: 5.0, temperature: 70.0)
        
        print("This is your corn results: " + String(cornSugarObj.calcPriming()))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//PS: Priming Sugar weight in Grams.
//Vbeer: Volume of your Beer in Gallons.
//VCO2: Desired Co2 volume for your beer.
//Tferm: Temperature of Your Beer prior to bottling it. (Fahrenheit)
//PS = 15.195 × Vbeer × (VCO2 – 3.0378 + (0.050062 × Tferm) – (0.00026555 × (Tferm)2))

protocol PrimingSugar {
    var name : String {get}
    var co2 : Float {get}
    var volume : Float {get}
    var temperature : Float {get}
    
    func calcPriming() -> Float
}

extension PrimingSugar {
    func calcPriming() -> Float {
        var result: Float
        result = 15.195 * self.volume * (self.co2 - 3.0378 + (0.050062 * self.temperature) - (0.00026555 * pow(self.temperature, 2)))
        return result
    }
}

struct CornSugar : PrimingSugar {
    var name : String = "Corn Sugar"
    var co2 : Float
    var volume : Float
    var temperature : Float
    
    init(co2: Float, volume: Float, temperature: Float){
        self.co2 = co2
        self.volume = volume
        self.temperature = temperature
    }
}
