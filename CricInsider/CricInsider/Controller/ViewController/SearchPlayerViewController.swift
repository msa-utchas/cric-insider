//
//  SearchPlayerViewController.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 15/2/23.
//

import UIKit
import SDWebImage
import Combine

class SearchPlayerViewController: UIViewController {
    var playerData: [PlayersInfo] = []
    let viewModel = SearchPlayerViewModel()
    var count: Int = 10
    private var cancelable: Set<AnyCancellable> = []
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableViewSearchedPlayerList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        binder()
        searchTextField.delegate = self
        tableViewSearchedPlayerList.delegate = self
        tableViewSearchedPlayerList.dataSource = self
        Task{
            await viewModel.callApiAndSaveDataIfNeeded()
        }
        

        print(count)
        
    }
    @IBAction func callApi(_ sender: Any) {
        Task{
            await viewModel.callApiAndSaveDataIfNeeded()
        }
    }
    
}

extension SearchPlayerViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSearchedPlayerList.dequeueReusableCell(withIdentifier: SearchedPlayerTableViewCell.Identifier, for: indexPath) as! SearchedPlayerTableViewCell
        cell.labelName.text = playerData[indexPath.row].fullName
        cell.labelCountryName.text = playerData[indexPath.row].country
        cell.imageViewProfile.sd_setImage(with: URL(string: playerData[indexPath.row].imagePath ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))

        return cell
    }
    
    
}

extension SearchPlayerViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        Task{
            await performSearch(with: updatedText)
        }
        return true
    }
    
    func performSearch(with text: String) async {
        if (text != "") {
            await viewModel.performSearch(searchText: text)
        }
        
        
        else {
            playerData = []
            tableViewSearchedPlayerList.reloadData()
        }
    }
    
}

extension SearchPlayerViewController{
    func binder(){
        viewModel.$playerList.sink { [weak self] playerDataList in
            guard let self = self else {return}
            self.playerData = playerDataList
            DispatchQueue.main.async {
                self.tableViewSearchedPlayerList.reloadData()
            }

        }.store(in: &cancelable)
    }
}
