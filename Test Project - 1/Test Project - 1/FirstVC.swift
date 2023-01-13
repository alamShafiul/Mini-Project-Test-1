//
//  ViewController.swift
//  Test Project - 1
//
//  Created by Admin on 12/1/23.
//

import UIKit

protocol ReloadProtocol {
    func reloadNews(val: [Article])
}

class FirstVC: UIViewController, ReloadProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var myArticles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.startAnimating()
        
        ApiCaller.shared.delegate = self
        let data = ApiCaller.shared.getDataFromAPI(category: "sports")
        if let article = data?.articles {
            myArticles = article
//            activityIndicator.stopAnimating()
        }
        //tableView.reloadData()
    }
    
    func reloadNews(val: [Article]) {
        DispatchQueue.main.async { [weak self] in
            self?.myArticles = val
            self?.tableView.reloadData()
        }
    }
    
//MARK: - Api calling
    @IBAction func refreshBtnClicked(_ sender: Any) {
        if let article = ApiCaller.shared.getDataFromAPI(category: "business")?.articles {
            myArticles = article
            tableView.reloadData()
        }
    }
}

extension FirstVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArticles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTVCell, for: indexPath) as! customTVC
        
//        cell.imgField.image = UIImage(named: myArticles[indexPath.row].urlToImage ?? "exclamationmark.triangle")
        cell.imgField.image = UIImage(systemName: "exclamationmark.triangle")
        cell.titleField.text = myArticles[indexPath.row].title
        
        //cell.titleField.text = "Hello world"
        
        return cell
    }
}

extension FirstVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//extension ViewController {
//    func getDataFromAPI(category: String?) {
//
//        var tailURL = ""
//        if let category = category {
//            tailURL = "&category=\(category)"
//        }
//        let apiURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=dd85f463bc1c4693bc95c1ef41995b09\(tailURL)"
//        print("URL: \(apiURL)")
//        guard let url = URL(string: apiURL) else {
//            return
//        }
//
//        let _ = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let self = self else { return }
//            if let error = error {
//                //print(error.localizedDescription)
//                print("error!")
//            }
//            else {
//                guard let data = data else { return }
//                do {
//                    let myNews = try JSONDecoder().decode(NewsModel.self, from: data)
//
//                    self.myArticles = myNews.articles
//
//                    DispatchQueue.main.async {
//                        self.activityIndicator.stopAnimating()
//                        self.tableView.reloadData()
//                    }
//                }
//                catch {
//                    print("sorry, some error happened!!")
//                    //print("your error: \(error.localizedDescription)")
//                }
//            }
//        }.resume()
//
//    }
//}


