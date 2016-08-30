//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Andriy Pryvalov on 30.08.16.
//  Copyright © 2016 Andriy Pryvalov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currenOperation = Operation.Empty
    
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        
        } catch let err as NSError{
            print(err.debugDescription)
        }
        outputLbl.text = "0"
        
    }
    
    @IBAction func NumberPressed(sender: UIButton){
        PlaySound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func DivideBtnPressed(sender: AnyObject){
        ProcessOperation(operation: .Divide)
    }
    
    @IBAction func MultiplyBtnPressed(sender: AnyObject){
        ProcessOperation(operation: .Multiply)
    }
    
    @IBAction func AddBtnPressed(sender: AnyObject){
        ProcessOperation(operation: .Add)
    }
    
    @IBAction func SubstractBtnPressed(sender: AnyObject){
        ProcessOperation(operation: .Substract)
    }
    
    @IBAction func EqualBtnPressed(sender: AnyObject){
        ProcessOperation(operation: currenOperation)
    }
    
    func PlaySound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }

    func ProcessOperation(operation: Operation) {
        PlaySound()
        if currenOperation != Operation.Empty{
            if runningNumber != "" {
               rightValStr = runningNumber
                runningNumber = ""
                
                
                if currenOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currenOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currenOperation == Operation.Substract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currenOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            currenOperation = operation
        }else {
            leftValStr = runningNumber
            runningNumber = ""
            currenOperation = operation
            
        }
    }


}

