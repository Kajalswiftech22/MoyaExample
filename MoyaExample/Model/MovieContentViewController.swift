//
//  MovieContentViewController.swift
//  MoyaExample
//
//  Created by Kajol   on 07/06/23.
//

import UIKit

class MovieContentViewController: UIViewController {
    
    
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var movieContent:Results?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitle.text = movieContent?.title
                if movieContent?.poster_path != nil
                {
                    let url = URL(string: movieContent?.poster_path! ?? "")
                    contentImage.load(url: url!)
                    contentImage.contentMode = .scaleToFill
                }
                else{
                    contentImage.image = UIImage(named: "")
                }
                contentLabel.text = movieContent?.overview
//
            }
        
        
    }
    

