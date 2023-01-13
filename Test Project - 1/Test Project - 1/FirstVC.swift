//
//  ViewController.swift
//  Test Project - 1
//
//  Created by Admin on 12/1/23.
//

import UIKit
import SDWebImage

class FirstVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var myArticles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //activityIndicator.hidesWhenStopped = true
        
        pleaseCallAPI(category: "health")
       
        
        tableView.reloadData()
    }

    
//MARK: - Api calling
    
    func pleaseCallAPI(category: String) {
        activityIndicator.startAnimating()
        ApiCaller.shared.getDataFromAPI(category: category, completion: { [weak self] getArray in
            if let getArray = getArray {
                self?.myArticles = getArray
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            }
        })
        
        
    }
    
    @IBAction func refreshBtnClicked(_ sender: Any) {
        pleaseCallAPI(category: "business")
    }
}

extension FirstVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArticles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTVCell, for: indexPath) as! customTVC
        cell.imgField.layer.cornerRadius = 10
        cell.imgField.sd_setImage(with: URL(string: (myArticles[indexPath.row].urlToImage) ?? ""), placeholderImage: UIImage(systemName: "photo.fill"))
        cell.titleField.text = myArticles[indexPath.row].title
        
        return cell
    }
}

extension FirstVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


