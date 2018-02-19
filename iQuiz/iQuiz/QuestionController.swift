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
    var ans:[String]?
    var choices:[[String]]?
    var correct: Int = 0
    var index:Int = 0
    var choice:String = ""
    var chosen:Bool = false

    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var question: UILabel!
    
    @IBAction func choose(_ sender: Any) {
    }
    @IBAction func Submit(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        num = questions?.count
        loadQ()
        // Do any additional setup after loading the view.
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
