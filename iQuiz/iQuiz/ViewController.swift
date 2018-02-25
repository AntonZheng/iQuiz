//
//  ViewController.swift
//  iQuiz
//
//  Created by Anton Zheng on 2/14/18.
//  Copyright © 2018 Anton Zheng. All rights reserved.
//

import UIKit
import SystemConfiguration

struct catQuestions : Decodable {
    var title: String
    var desc: String
    var questions: [question]
}

struct question : Decodable {
    var text : String
    var answer: String
    var answers: [String]
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var cats = [catQuestions]()
    var download = false
    var inputURL = ""
    
    var num : Int?
    
    // No longer needed as we read JSON files now
    
//    let titleArray:[String] = ["Mathematics","Marvel Super Heroes","Science"]
      let icons = [UIImage(named:"math.png"), UIImage(named:"super.png"), UIImage(named:"science.png")]
//    let desc = ["Lets learn about math!", "How much do you know about super heroes?", "Has science gone too far?"]
//
//    let mathq = ["1 + 5 =","2 * 5 ="]
//    let mchoices = [["6","3","0","2"],["2","34","10","20"]]
//    let mathansw = ["6","10"]
//
//    let superq = ["What is Spirderman's name?","Who plays Tony Stark in Marvel's Iron Man film series?"]
//    let schoices = [["Timmy Turner","Peter Parker","Clark Kent","Tony Stark"],["George Clooney","Tim Duncan","Kanye West","Robert Downey Jr"]]
//    let superansw = ["Peter Parker","Robert Downey Jr"]
//
//    let sciq = ["What is the most common element on the planet?","What is the chemical formula for water?"]
//    let scichoices = [["Gold","Silver","Hydrogen","Mercury"],["O2","NaCl","HCl","H2O"]]
//    let scians = ["Hydrogen","H2O"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cats.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text = self.cats[index].title
        cell.detailTextLabel!.text = self.cats[index].desc
        cell.imageView?.image = icons[index]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowSelected = indexPath.row
        num = rowSelected
        performSegue(withIdentifier: "Quest", sender: self)
    }
    
    // downloads from inputted URL
    func downloadJSON(completed: @escaping () -> ()) {
        let jsonURL = inputURL
        let url = URL(string: jsonURL)
        if Reachability.isConnectedToNetwork(){
            URLSession.shared.dataTask(with: url!) { data, urlResponse, error in
                if(error == nil){
                    do {
                        self.cats = try JSONDecoder().decode([catQuestions].self, from: data!)
                        print(self.cats.count)
                        
                        DispatchQueue.main.async {
                            completed()
                        }
                    } catch {
                        print("Error")
                        let jAlert: UIAlertController = UIAlertController(title: "JSON Error", message: "Error reading JSON.", preferredStyle: .alert)
                        let cancel = UIAlertAction(title: "ok", style: .cancel)
                        jAlert.addAction(cancel)
                        self.present(jAlert, animated: true, completion: nil)
                    }
                } else {
                    let jAlert: UIAlertController = UIAlertController(title: "JSON Download Error", message: "Error downloading JSON.", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "ok", style: .cancel)
                    jAlert.addAction(cancel)
                    self.present(jAlert, animated: true, completion: nil)
                }
                }.resume()

        }else{
            print("Internet Connection not Available!")
            let intAlert: UIAlertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet. Using Local JSON file.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "ok", style: .cancel)
            intAlert.addAction(cancel)
            present(intAlert, animated: true, completion: nil)
            loadLocal()
        }
        download = false
    }
    
    //Use Local JSON file
    func loadLocal() {
        let path = Bundle.main.path(forResource: "questions", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            self.cats = try JSONDecoder().decode([catQuestions].self, from: data)
        } catch{}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Quest" {
            let qVar = segue.destination as! QuestionController
            for quest in self.cats[num!].questions {
                qVar.questions.append(quest.text)
                qVar.answers.append(Int(quest.answer)!)
                qVar.choices.append(quest.answers)
            }
        }
    }
    
    @IBOutlet weak var tbl: UITableView!
    
//    @IBAction func settings(_ sender: UIBarButtonItem) {
//        let alert: UIAlertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "ok", style: .cancel)
//        alert.addAction(cancel)
//        present(alert, animated: true, completion: nil)
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.dataSource = self
        tbl.delegate = self
        if Reachability.isConnectedToNetwork() == false {
            let intAlert: UIAlertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet. Using Local JSON file.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "ok", style: .cancel)
            intAlert.addAction(cancel)
            present(intAlert, animated: true, completion: nil)
        }
        if(download) {
            downloadJSON {
                self.tbl.reloadData()
            }
        } else {
            loadLocal()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

