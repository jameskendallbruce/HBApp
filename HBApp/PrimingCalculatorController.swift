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
        
        cornSugarObj = CornSugar(co2: 2.5, volume: 5.0, temperature: 65.0)
        
        var honeyObj : Honey

        honeyObj = Honey(co2: 2.5, volume: 5.0, temperature: 65.0)

        
        print("This is your corn results: " + String(cornSugarObj.calcActual()))
        print("This is your honey results: " + String(honeyObj.calcActual()))

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
    var partsPerGallon: Float {get}
    var yieldPercent: Float {get}
    
    func calcIdeal() -> Float
    //This calculates the default, ideal priming sugar (corn sugar) which has a 100% yield. For instances that are not 100%, we'll need to change that.
    func calcActual() -> Float
}

extension PrimingSugar {
    func calcIdeal() -> Float {
        var result: Float
        result = 15.195 * self.volume * (self.co2 - 3.0378 + (0.050062 * self.temperature) - (0.00026555 * pow(self.temperature, 2)))
        return result
    }
    
    func calcActual() -> Float {
        var result: Float
        let idealResult : Float = calcIdeal()
        result = (idealResult * 42 * 1.0)/(self.partsPerGallon * self.yieldPercent)
        return result
    }
}


struct CornSugar : PrimingSugar {
    var name : String = "Corn Sugar"
    var co2 : Float
    var volume : Float
    var temperature : Float
    let partsPerGallon: Float = 42
    let yieldPercent: Float = 1.0
    
    init(co2: Float, volume: Float, temperature: Float){
        self.co2 = co2
        self.volume = volume
        self.temperature = temperature
    }
}

struct Honey : PrimingSugar {
    var name : String = "Honey"
    var co2 : Float
    var volume : Float
    var temperature : Float
    let partsPerGallon: Float = 38
    let yieldPercent: Float = 0.95
    
    init(co2: Float, volume: Float, temperature: Float){
        self.co2 = co2
        self.volume = volume
        self.temperature = temperature
    }
}
