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
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelSearchPlayerText: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var playerData: [PlayersInfo] = []
    let viewModel = SearchPlayerViewModel()
    var count: Int = 10
    private var cancelable: Set<AnyCancellable> = []
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewSearchedPlayerList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBackground.addShadow()
        labelSearchPlayerText.layer.masksToBounds = true
        labelSearchPlayerText.layer.cornerRadius = 8
        binder()
        searchTextField.delegate = self
        tableViewSearchedPlayerList.delegate = self
        tableViewSearchedPlayerList.dataSource = self
        //tableViewTopConstraint.constant = -10
        tableViewSearchedPlayerList.layer.cornerRadius = 10
        tableViewSearchedPlayerList.register(UINib(nibName: PlayerDetailsHeader.identifier, bundle: nil), forCellReuseIdentifier: PlayerDetailsHeader.identifier)
        Task{
            activityIndicator.startAnimating()
            await viewModel.callApiAndSaveDataIfNeeded()
            activityIndicator.stopAnimating()
        }
        
        
        print(count)
        
    }
    
    
}

extension SearchPlayerViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerData.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Player List"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSearchedPlayerList.dequeueReusableCell(withIdentifier: SearchedPlayerTableViewCell.identifier, for: indexPath) as! SearchedPlayerTableViewCell
        cell.selectionStyle = .none
        cell.labelName.text = playerData[indexPath.row].fullName
        cell.labelCountryName.text = playerData[indexPath.row].country
        cell.imageViewProfile.sd_setImage(with: URL(string: playerData[indexPath.row].imagePath ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setSelectedPlayerId(id: Int(playerData[indexPath.row].id))
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
        
        viewModel.$selectedPlayerId.sink(){[weak self] id in
            guard let self = self else {return}
            
            if let id = id{
                let vc = self.storyboard?.instantiateViewController(identifier: ViewPlayerInfoViewController.identifier) as! ViewPlayerInfoViewController
                vc.loadViewIfNeeded()
                Task{
                    await vc.viewModel.getPlayerData(id:id)
                  }
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }.store(in: &cancelable)
        
    }
    
}
