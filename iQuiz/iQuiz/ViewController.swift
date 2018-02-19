//
//  ViewController.swift
//  iQuiz
//
//  Created by Anton Zheng on 2/14/18.
//  Copyright © 2018 Anton Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
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
    
    
    let titleArray:[String] = ["Mathematics","Marvel Super Heroes","Science"]
    let icons = [UIImage(named:"math.png"), UIImage(named:"super.png"), UIImage(named:"science.png")]
    let desc = ["Lets learn about math!", "How much do you know about super heroes?", "Has science gone too far?"]
    
    @IBOutlet weak var tbl: UITableView!
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        let alert: UIAlertController = UIAlertController(title: "Setings", message: "Setings go here", preferredStyle: .alert)
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

