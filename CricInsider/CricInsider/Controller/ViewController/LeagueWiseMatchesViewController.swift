//
//  LeagueWiseMatchesViewController.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 25/2/23.
//

import UIKit

class LeagueWiseMatchesViewController: UIViewController {

    @IBOutlet weak var matchSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableViewMatches: UITableView!
    @IBOutlet weak var collectionViewLeague: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLeague .dataSource = self
        collectionViewLeague.delegate = self
        collectionViewLeague.register(UINib(nibName: LeaguesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: LeaguesCollectionViewCell.identifier)

        // setup the layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       // setup the layout
        //seup the with only three acomodation
        let width = (view.frame.size.width - 20) / 3
        layout.itemSize = CGSize(width: width, height: 180)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionViewLeague.collectionViewLayout = layout
        tableViewMatches.dataSource = self
        tableViewMatches.delegate = self
        tableViewMatches.register(UINib(nibName: MatchesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MatchesTableViewCell.identifier)


        
        
    }
    

}
extension LeagueWiseMatchesViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewLeague.dequeueReusableCell(withReuseIdentifier: LeaguesCollectionViewCell.identifier, for: indexPath) as! LeaguesCollectionViewCell
        return cell
    }

    

}
extension LeagueWiseMatchesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMatches.dequeueReusableCell(withIdentifier: MatchesTableViewCell.identifier, for: indexPath) as! MatchesTableViewCell
        return cell
    }

}