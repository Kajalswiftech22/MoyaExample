//
//  ComicsViewController.swift
//  MoyaExample
//
//  Created by intern on 6/6/23.
//

import UIKit
import Moya
import Kingfisher


class ComicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var comicsTableView: UITableView!
    
    let provider = MoyaProvider<Marvel>()
    
    
    enum ViewState<T> {
        case loading
        case ready(T)
        case error
    }
    
    var comics:[Movie] = []
    
    var comicsWithDetail:[Results] = []
    var filteredMovie:[Results] = []
    
    var searchText:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.comicsTableView.delegate = self
        self.comicsTableView.dataSource = self
        searchTextfield.addTarget(self, action: #selector(ComicsViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        
        self.comicsTableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesTableViewCell")
        
        fetchDataFromApi()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovie.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = comicsTableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        
        let url = URL(string: filteredMovie[indexPath.row].poster_path ?? "")
        cell.movieTitleLabel.text = filteredMovie[indexPath.row].title
        cell.movieDescription.text = filteredMovie[indexPath.row].overview
        cell.releaseDateLabel.text = filteredMovie[indexPath.row].release_date
        if let posterPath = filteredMovie[indexPath.row].poster_path {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)", relativeTo: Marvel.comics.baseURL)
            cell.imageFirst.load(url: imageURL!)
        } else {
            cell.imageFirst.kf.setImage(with: URL(string: ""), placeholder: UIImage(named: "movie"))
            cell.imageFirst.contentMode = .scaleAspectFit
        }
        
        if let poster_path = comicsWithDetail[indexPath.row].poster_path {
            
        } else {
            //cell.imageFirst.image = UIImage(named: "Movie")
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        comicsTableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieContent") as! MovieContentViewController
        vc.movieContent = comicsWithDetail[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }
    
    func searchMovies() {
        searchTextfield.resignFirstResponder()
    }
    
    func fetchDataFromApi(){
        provider.request(.comics) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                
                do {
                    //                    print(try response.mapJSON())
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(Movie.self, from: response.data)
                    
                    print(movies)
                    self.comics = [movies]
                    self.comicsWithDetail = self.comics[0].results!
                    self.filteredMovie = self.comicsWithDetail
                    self.comicsTableView.reloadData()
                    
                } catch {
                    
                }
            case .failure(let error): break
                
            }
        }
    }
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print(textField.text as Any)
        
        let searchText = searchTextfield.text?.lowercased()
        if searchText == ""{
            filteredMovie = comicsWithDetail
            self.comicsTableView.reloadData()
        }else{
            filteredMovie = comicsWithDetail.filter {
                $0.title!.lowercased().contains(searchText ?? "")
            }
            self.searchText = searchTextfield.text?.lowercased() ?? ""
            debugPrint("*************\(filteredMovie)")
            self.comicsTableView.reloadData()
        }
        
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
