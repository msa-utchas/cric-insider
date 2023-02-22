//
//  DateWiseMatchViewController.swift
//  CricInsider
//
//  Created by BJIT on 22/2/23.
//

import UIKit

class DateWiseMatchViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableViewMatchList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.addShadow()
        tableViewMatchList.dataSource = self
        tableViewMatchList.delegate = self
        let nib = UINib(nibName: MatchesTableViewCell.identifier, bundle: nil)
        tableViewMatchList.register(nib, forCellReuseIdentifier: MatchesTableViewCell.identifier)
       
    }


}
extension DateWiseMatchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMatchList.dequeueReusableCell(withIdentifier: MatchesTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    
}
