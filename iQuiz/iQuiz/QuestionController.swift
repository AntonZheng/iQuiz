//
//  QuestionController.swift
//  iQuiz
//
//  Created by Anton Zheng on 2/18/18.
//  Copyright © 2018 Anton Zheng. All rights reserved.
//

import UIKit

class QuestionController: UIViewController {
    var num : Int?
    var questions:[String]?
    var ans:[String] = [""]
    var choices:[[String]]?
    var correct: Int = 0
    var index:Int = 0
    var choice:String = ""
    var chosen:Bool = false
    var nextq:Bool = false

    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var nextsub: UIButton!
    
    @IBOutlet weak var canswer: UILabel!
    
    @IBAction func choose(_ sender: Any) {
        enableb()
        choice = choices![index][(sender as AnyObject).tag]
        if((sender as AnyObject).tag == 0) {
            b1.backgroundColor = UIColor.red
        } else if((sender as AnyObject).tag == 1) {
            b2.backgroundColor = UIColor.red
        } else if((sender as AnyObject).tag == 2) {
            b3.backgroundColor = UIColor.red
        } else if((sender as AnyObject).tag == 3) {
            b4.backgroundColor = UIColor.red
        }
        print(choice)
        print(ans[index])
        chosen = true
    }
    
    @IBAction func Submit(_ sender: Any) {
        if(nextq) {
            if(index == num) {
                performSegue(withIdentifier: "ans", sender: self)
            } else {
                nextsub.setTitle("Submit", for: .normal)
                nextq = false
                enableb()
                loadQ()
                canswer.text = ""
            }
        } else if(chosen) {
            if(choice == ans[index]) {
                canswer.text = "Correct! Correct answer: " + ans[index]
                correct+=1
            } else {
                canswer.text = "Incorrect! Correct answer: " + ans[index]
            }
            disableb()
            index+=1
            nextq = true
            nextsub.setTitle("Next", for: .normal)
            chosen = false
        }
        if(index == num) {
            performSegue(withIdentifier: "ans", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ans" {
            let aVar = segue.destination as! AnsController
            aVar.corr = correct
            aVar.tot = num!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        num = questions?.count
        canswer.text = ""
        loadQ()
        // Do any additional setup after loading the view.
    }
    
    public func disableb() {
        b1.isEnabled = false
        b2.isEnabled = false
        b3.isEnabled = false
        b4.isEnabled = false
        b1.backgroundColor = UIColor.gray
        b2.backgroundColor = UIColor.gray
        b3.backgroundColor = UIColor.gray
        b4.backgroundColor = UIColor.gray
    }
    
    public func enableb() {
        b1.isEnabled = true
        b2.isEnabled = true
        b3.isEnabled = true
        b4.isEnabled = true
        b1.backgroundColor = UIColor.blue
        b2.backgroundColor = UIColor.blue
        b3.backgroundColor = UIColor.blue
        b4.backgroundColor = UIColor.blue
    }
    
    public func loadQ() {
        question.text = questions?[index]
        b1.setTitle(choices![index][0], for: .normal)
        b2.setTitle(choices![index][1], for: .normal)
        b3.setTitle(choices![index][2], for: .normal)
        b4.setTitle(choices![index][3], for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
