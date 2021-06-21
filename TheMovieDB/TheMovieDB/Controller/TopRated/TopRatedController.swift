//
//  TopRatedController.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

private let reuseIdentifier = "TopRatedCell"

class TopRatedController: UICollectionViewController {
    //MARK: - Properties
    private var viewModel: TopRatedViewModelProtocol
    var refreshControl = UIRefreshControl()
    
    //MARK: - Lifecycle
    init(viewModel: TopRatedViewModelProtocol) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
        addPullToRefresh()
    }
    
    //MARK: - Selectors
    @objc private func pullRefresh() {
        viewModel.currentPage = 1
        viewModel.pullRefresh()
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .black
        title = "Top Rated"
    }
    
    func setupBindings() {
        viewModel.loadingMovies = true
        viewModel.movies.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.viewModel.loadingMovies = false
                self.collectionView.reloadData()
            }
        }
        
        viewModel.isPullRefresh.bind { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                isLoading ? print() : self.refreshControl.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func addPullToRefresh() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(viewModel, action: #selector(pullRefresh), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
}

//MARK: - UICollectionViewDelegate/DataSource
extension TopRatedController {
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.value.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TopRatedCell
        
        print("poster: \(viewModel.movies.value[indexPath.row].getImagePosterPath())")
        if let urlPoster = URL(string: "\(viewModel.movies.value[indexPath.row].getImagePosterPath())") {
            cell.topRatedImageView.kf.setImage(with: URL(string: "\(urlPoster)"))
        } else {
            cell.topRatedImageView.image = UIImage(named: "spider")
        }
        
        cell.titleMovie.text = "\(viewModel.movies.value[indexPath.row].title?.description ?? "")"
        cell.overviewMovie.text = "\(viewModel.movies.value[indexPath.row].overview?.description ?? "")"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectMovieItemAt(indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movies.value.count - 1 && !viewModel.loadingMovies {
            viewModel.currentPage += 1
            
            if viewModel.movies.value.count > 0 {
                viewModel.fetchTopRated()
            }
            
            print("Loading more movies")
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension TopRatedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}

