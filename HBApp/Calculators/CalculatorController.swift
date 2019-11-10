//
//  CalculatorController.swift
//  HBApp
//
//  Created by Nolan Bruce on 8/20/19.
//  Copyright © 2019 Nolan Bruce. All rights reserved.
//

import UIKit

/*
struct calculators {
    var title: String
}
*/

let calculators = [
    "ABV Calculator",
    "Priming Calculator",
    "IBU Calculator",
    "SRM Calculator"
]

class CalculatorController : UIViewController {
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for calc in calculators {
            print(calc)
        }
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func buttonAction(sender : UIButton!) {
        print("Oi, you done clicked " + sender.titleLabel!.text! + ", eh?")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Calculator", bundle:nil)
        
        switch sender.titleLabel!.text {
        case "ABV Calculator":
            print("'Ats right, you pressed ABV Calculator")
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ABVCalculatorController") as! ABVCalculatorController
            self.show(nextViewController, sender: self)
        case "Priming Calculator":
            print("'Ats right, you pressed Priming Calculator")
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PrimingCalculatorController") as! PrimingCalculatorController
            self.show(nextViewController, sender: self)
        case "IBU Calculator":
            print("'Ats right, you pressed IBU Calculator")
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IBUCalculatorController") as! IBUCalculatorController
            self.show(nextViewController, sender: self)
        case "SRM Calculator":
            print("'Ats right, you pressed SRM Calculator")
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SRMCalculatorController") as! SRMCalculatorController
            self.show(nextViewController, sender: self)
        default:
            print("idk what you pressed, bruv")
        }
        
        /*
         for calc in calculators {
         if sender.titleLabel!.text == calc {
         nextView = calc
         break
         }
         }
         
         if nextView != "Uninitiated" {
         print("Good value")
         } else {
         print("The fuck you doin'?")
         }
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: nextView) as! NextViewController
         self.present(nextViewController, animated:true, completion:nil)
         */
    }
}

extension CalculatorController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.2, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calculators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        //cell.backgroundColor = .gray
        //print(indexPath[1])
        cell.data = calculators[indexPath[1]]
        cell.bg.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return cell
    }
}


class CustomCell: UICollectionViewCell {
    
    var data : String? {
        didSet {
            guard let data = data else { return }
            bg.setTitle(data, for: UIControl.State.init())
            bg.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 25)
            }
    }
    
    let bg: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.contentMode = .scaleAspectFill
        but.clipsToBounds = true
        but.layer.cornerRadius = 20
        but.backgroundColor = .gray
        but.layer.borderWidth = 1
        but.layer.borderColor = UIColor.black.cgColor
        //but.addTarget(self, action: "buttonClicked:", for: .touchUpInside)
        return but
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bg)
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

