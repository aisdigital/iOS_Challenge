//
//  PopularController.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

private let reuseIdentifier = "PopularCell"

class PopularController: UICollectionViewController {
    
    //MARK: - Properties
    private var viewModel: PopularViewModelProtocol
    var refreshControl = UIRefreshControl()
    
    //MARK: - Lifecycle
    init(viewModel: PopularViewModelProtocol) {
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
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .black
        title = "Popular"
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
extension PopularController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.value.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PopularCell
        
        if let urlPoster = URL(string: "\(viewModel.movies.value[indexPath.row].getImagePosterPath())") {
            cell.popularImageView.kf.setImage(with: URL(string: "\(urlPoster)"))
        } else {
            cell.popularImageView.image = UIImage(named: "notimagem")
        }
        cell.nameMovieLabel.text = "\(viewModel.movies.value[indexPath.row].title?.description ?? "")"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movies.value.count - 1 && !viewModel.loadingMovies {
            viewModel.currentPage += 1
            if viewModel.movies.value.count > 0 {
                viewModel.fetchPopular()
            }
            print("Loading more movies Popular")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectMovieItemAt(indexPath: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PopularController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}


