//
//  ViewController.swift
//  rotateButton4
//
//  Created by Indra Kurniawan on 26/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    // Set the different options of rotation
    var rotationOptions: Array = [0, Double.pi/2, Double.pi, 3*Double.pi/2]

    // Set the original matrix
    var matrix: [[Double]] = [
        [0,0,0,0],
        [0,0,0,0],
        [0,0,0,0]
    ]
    
    var maxRow: Int = 0
    var maxCol: Int = 0
    
    //+90 derajat
    let origin: Double = 0
    let delta: Double = Double.pi/2
    let round: Double = 2 * Double.pi
    
    @IBOutlet weak var btn00: UIButton!
    @IBOutlet weak var btn01: UIButton!
    @IBOutlet weak var btn02: UIButton!
    @IBOutlet weak var btn03: UIButton!
    @IBOutlet weak var btn10: UIButton!
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn13: UIButton!
    @IBOutlet weak var btn20: UIButton!
    @IBOutlet weak var btn21: UIButton!
    @IBOutlet weak var btn22: UIButton!
    @IBOutlet weak var btn23: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let buttons: [[UIButton]] = [
            [btn00,btn01,btn02,btn03],
            [btn10,btn11,btn12,btn13],
            [btn20,btn21,btn22,btn23]
        ]
        
        maxRow = matrix.count-1
        maxCol = matrix[0].count-1
        
        randomizeMatrix()
        
        matrix[0][0] = 0
        matrix[0][1] = 0
        matrix[1][0] = 0
        
        for r in 0...maxRow {
            for c in 0...maxCol {
                buttons[r][c].imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(matrix[r][c]))
            }
        }
        
//        b00.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(matrix[0][0]))
//        b01.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(matrix[0][1]))
//        b10.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(matrix[1][0]))
//        b11.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(matrix[1][1]))

    }
    
    func rotateElement(row: Int, col: Int, sender: UIButton) {
        
        matrix[row][col] = matrix[row][col] + delta >= round ? origin : matrix[row][col] + delta
        rotate(view: sender)
        print(matrix)

        verifyGoal()
    }
    
    //btn00t == button00tapped
    @IBAction func btn00t(_ sender: Any) {
//        rotateElement(row: 0, col: 0, sender: btn00)
    }
    
    @IBAction func btn01t(_ sender: Any) {
//        rotateElement(row: 0, col: 1, sender: btn01)
    }
    
    @IBAction func btn02t(_ sender: Any) {
        rotateElement(row: 0, col: 2, sender: btn02)
    }
    
    @IBAction func btn03t(_ sender: Any) {
        rotateElement(row: 0, col: 3, sender: btn03)
    }
    
    @IBAction func btn10t(_ sender: Any) {
//        rotateElement(row: 1, col: 0, sender: btn10)
    }
    
    @IBAction func btn11t(_ sender: Any) {
        rotateElement(row: 1, col: 1, sender: btn11)
    }
    
    @IBAction func btn12t(_ sender: Any) {
        rotateElement(row: 1, col: 2, sender: btn12)
    }
    
    @IBAction func btn13t(_ sender: Any) {
        rotateElement(row: 1, col: 3, sender: btn13)
    }
   
    @IBAction func btn20t(_ sender: Any) {
        rotateElement(row: 2, col: 0, sender: btn20)
    }
    
    @IBAction func btn21t(_ sender: Any) {
        rotateElement(row: 2, col: 1, sender: btn21)
    }
    
    @IBAction func btn22t(_ sender: Any) {
        rotateElement(row: 2, col: 2, sender: btn22)
    }
    
    @IBAction func btn23t(_ sender: Any) {
        rotateElement(row: 2, col: 3, sender: btn23)
    }
    
    func randomizeMatrix() {
        for r in 0...maxRow {
            for c in 0...maxCol {
                let randomAngleIndex: Int = Int.random(in: 0...3)
                
                matrix[r][c] = rotationOptions[randomAngleIndex]
                
            }
        }
    }
    
    func verifyGoal() {
        var status = true
        
        // let's check every cells
        for r in 0...maxRow {
            for c in 0...maxCol {
                // let's check if the angle is right: angle = 0
                if matrix[r][c] != 0 {
                    // If there is one wrong, then it's false
                    status = false
                }
            }
        }
        
        if status {
            let alert = UIAlertController(title: "You Won!", message: "Congratulations 👍", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Next", style: UIAlertAction.Style.default, handler: { action -> Void in
                 self.performSegue(withIdentifier: "win", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func rotate(view: UIView) {
        UIView.animate(withDuration: 0.05, animations: ({
            view.transform = view.transform.rotated(by: CGFloat(Double.pi/2))
        }))
    }
}
