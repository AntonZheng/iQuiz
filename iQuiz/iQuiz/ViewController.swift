//
//  ViewController.swift
//  iQuiz
//
//  Created by Anton Zheng on 2/14/18.
//  Copyright © 2018 Anton Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var num : Int?
    let titleArray:[String] = ["Mathematics","Marvel Super Heroes","Science"]
    let icons = [UIImage(named:"math.png"), UIImage(named:"super.png"), UIImage(named:"science.png")]
    let desc = ["Lets learn about math!", "How much do you know about super heroes?", "Has science gone too far?"]
    
    let mathq = ["1 + 5 =","2 * 5 ="]
    let mchoices = [["6","3","0","2"],["2","34","10","20"]]
    let mathansw = ["6","10"]
    
    let superq = ["What is Spirderman's name?","Who plays Tony Stark in Marvel's Iron Man film series?"]
    let schoices = [["Timmy Turner","Peter Parker","Clark Kent","Tony Stark"],["George Clooney","Tim Duncan","Kanye West","Robert Downey Jr"]]
    let superansw = ["Peter Parker","Robert Downey Jr"]
    
    let sciq = ["What is the most common element on the planet?","What is the chemical formula for water?"]
    let scichoices = [["Gold","Silver","Hydrogen","Mercury"],["O2","NaCl","HCl","H2O"]]
    let scians = ["Hydrogen","H2O"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text = titleArray[index]
        cell.detailTextLabel!.text = desc[index]
        cell.imageView?.image = icons[index]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowSelected = indexPath.row
        num = rowSelected
        performSegue(withIdentifier: "Quest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Quest" {
            let qVar = segue.destination as! QuestionController
            if(num == 0) {
                qVar.questions = mathq
                qVar.ans = mathansw
                qVar.choices = mchoices
            } else if(num == 1) {
                qVar.questions = superq
                qVar.ans = superansw
                qVar.choices = schoices
            } else if(num == 2) {
                qVar.questions = sciq
                qVar.ans = scians
                qVar.choices = scichoices
            }
        }
    }
    
    @IBOutlet weak var tbl: UITableView!
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        let alert: UIAlertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "ok", style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.dataSource = self
        tbl.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

