//
//  ViewController.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 04/06/21.
//

import UIKit

final class MoviesViewController: UIViewController {
    
    
    @IBOutlet private weak var moviesTableView: UITableView!
    private var movies = [Movie]()
    private var movieListViewModel: MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListViewModel = MovieListViewModel()
        movieListViewModel.delegate = self
        moviesTableView.dataSource = self
        movieListViewModel.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let indexPath =  moviesTableView.indexPathForSelectedRow {
                let movie = self.movies[indexPath.row]
                let controller = segue.destination as? MovieDetailTableViewController
                
                controller?.movieId = movie.id
                
            }
        }
    }
    
}

extension MoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        movieListViewModel.paginate(indexPath: indexPath)
        
        let movie = movies[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath)
                as? MovieTableViewCell else {
            
            return UITableViewCell()
        }
        
        cell.configure(viewModel: MovieCellViewModel(model: movie))
        
        return cell
    }
    
}

extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
}

extension MoviesViewController: MoviesDelegate {
    
    func getData(data: [Movie]?) {
        guard let collection = data else { return }
        movies = collection
        moviesTableView.reloadData()
    }
    
}

