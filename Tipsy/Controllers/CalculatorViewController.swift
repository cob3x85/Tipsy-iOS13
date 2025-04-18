//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!

    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!

    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculatePressed(_ sender: UIButton) {

        let bill = billTextField.text!
        if bill != "" {
            billTotal = Double(bill)!
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)
        }

        //In Main.storyboard there is a segue between CalculatorVC and ResultsVC with the identifier "goToResults".
        //This line triggers the segue to happen.
        self.performSegue(withIdentifier: "goToResults", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController

            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false

        sender.isSelected = true

        let buttontitle = sender.currentTitle!

        let buttonTitleMinusPercentageSign = String(buttontitle.dropLast())
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentageSign)!
        tip = buttonTitleAsNumber / 100

    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        print(sender.value)
        splitNumberLabel.text = String(format: "%.0f", sender.value)

        numberOfPeople = Int(sender.value)
    }
}
