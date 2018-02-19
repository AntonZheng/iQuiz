//
//  AnsController.swift
//  iQuiz
//
//  Created by Anton Zheng on 2/19/18.
//  Copyright © 2018 Anton Zheng. All rights reserved.
//

import UIKit

class AnsController: UIViewController {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var desc: UILabel!
    var corr:Int = 0
    var tot:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score.text = "Score: " + String(corr) + "/" + String(tot)
        if(corr == 0){
            desc.text = "Try Harder Next Time!"
        } else if (corr == tot) {
            desc.text = "Perfect!"
        } else {
            desc.text = "Almost!"
        }

        // Do any additional setup after loading the view.
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
