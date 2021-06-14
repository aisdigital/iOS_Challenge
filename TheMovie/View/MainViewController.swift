//
//  MainViewController.swift
//  TheMovie
//
//  Created by Marcos Jr on 13/06/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private let service = MovieService()
    let searchButton = UIButton(type: .custom)
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchTextField.addTarget(self, action: #selector(searchMovies(_:)), for: .allEditingEvents)
        setupSearchButton()
    }
    
    func setupSearchButton() {
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .gray
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        searchButton.isUserInteractionEnabled = false
        
        searchTextField.leftView = searchButton
        searchTextField.leftViewMode = .always
    }
    
    func setupDetailView(viewModel: MovieDetailsViewModel) -> MovieDetailsViewController {
        return (storyboard?.instantiateViewController(identifier: "MovieDetailsViewController", creator: { coder in
            return MovieDetailsViewController(coder: coder, viewModel: viewModel)
        }))!
    }
    
    @objc func searchMovies(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else { return }
        
        service.search(by: sender.text ?? "", completion: validateResponse)
        
    }
    
    func validateResponse(response: [Movie]) {
        movies = response
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier,
                                                 for: indexPath) as! MovieTableViewCell
        cell.configure(with: MovieCellViewModel(model: movies[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let request = service.getMovieBy(id: movies[indexPath.row].id)
        request.responseDecodable(of: MovieDetails.self) { response in
            switch response.result {
            case let .success(result):
                self.present(self.setupDetailView(viewModel: MovieDetailsViewModel(with: result)), animated: true)
            case .failure(_):
                AlertManager(with: .error, title: AlertTitles.networkError,
                             message: AlertMessages.cannotConnect).show()
                print(response.debugDescription)
            }
        }
    }
}

