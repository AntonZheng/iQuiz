//
//  SetViewController.swift
//  iQuiz
//
//  Created by Anton Zheng on 2/24/18.
//  Copyright © 2018 Anton Zheng. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    

    @IBOutlet weak var url: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func check(_ sender: Any) {
        performSegue(withIdentifier: "close", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "close" {
            let vc = segue.destination as! ViewController
            vc.inputURL = url.text!
            vc.download = true
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
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
