//
//  MovieDetailsController.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit
import Kingfisher

private let cellId = "cellId"
private let headerMovieId = "headerMovieId"
private let infoMovieId = "infoMovieId"
private let similarMovieId = "similarMovieId"
private let footerMovieId = "footerMovieId"
private let videoId = "videoId"


//MARK: - UICollectionViewFlowLayout
class HeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attribute) in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                guard let collectionView = collectionView else {return}
                let contentOffSetY = collectionView.contentOffset.y
                attribute.frame = CGRect(
                    x: 0,
                    y: contentOffSetY,
                    width: collectionView.bounds.width,
                    height: attribute.bounds.height - contentOffSetY)
            }
        })
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}


class MovieDetailsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //MARK: - Properties
    
    private var viewModel: MovieDetailsViewModelProtocol
    var similar: [SimilarMovies] = []
        
    //MARK: - Lifecycle
    init(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
        let layout = HeaderLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
        
    //MARK: - Selectors
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .aisdigital
        title = "Details Movie"
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 134, right: 0)
        collectionView.backgroundColor = .black
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerMovieId)
        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerMovieId)
        collectionView.register(InfoMovieCell.self, forCellWithReuseIdentifier: infoMovieId)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: videoId)
        
    }
    
    func setupBindings() {
        viewModel.movieDetails.bind { [weak self] _ in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.viewModel.similiarMovies.bind { [weak self] _ in
                            guard let self = self else { return }
                            DispatchQueue.main.async {
                                self.viewModel.videoMovies.bind { [weak self] video in
                                    guard let self = self else { return }
                                        DispatchQueue.main.async {
                                            self.collectionView.reloadData()
                                        }
                                    }
                                }
                            }
                    }
                }
            }
    }


extension MovieDetailsController {
    
   
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerMovieId, for: indexPath) as! HeaderView
            
            if let urlPoster = URL(string: "\(viewModel.movieDetails.value?.getImageBackDropPath().description ?? "")") {
                header.imageMovie.kf.setImage(with: urlPoster)
            } else {
                header.imageMovie.image = UIImage(named: "spider")
            }
            
            header.delegate = self
            
            return header
        
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerMovieId, for: indexPath) as! FooterView
            
            footerView.setupSimilar(similar: viewModel.similiarMovies.value)
            return footerView
    
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var return_cell: UICollectionViewCell!
        
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoMovieId, for: indexPath) as!
                InfoMovieCell
            
            cell.nameMovieLabel.text = "\(viewModel.movieDetails.value?.title?.description ?? "")"
            cell.popularityLabel.text = "Popularity: \(viewModel.movieDetails.value?.popularity.rounded().description ?? "0.0")"
            cell.likesLabel.text = "\(viewModel.movieDetails.value?.vote_count?.description ?? "") Likes"
            return_cell = cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoId, for: indexPath) as!
                VideoCell
            
            cell.key = viewModel.videoMovies.value.first?.key?.description ?? ""
            print("URLtrailler: \(cell.key ?? "")")
            
            
            return_cell = cell
        }
        return return_cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        var height: CGFloat = UIScreen.main.bounds.height
        
        if indexPath.item == 0 {
            let cell = InfoMovieCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.layoutIfNeeded()
            
            let estimativaTamanho = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
            height = estimativaTamanho.height
        }
        
        if indexPath.item == 1 {
            let cell = VideoCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.layoutIfNeeded()
            
            let estimativaTamanho = cell.systemLayoutSizeFitting(CGSize(width: width, height: width))
            height = estimativaTamanho.height
        }
        
            
        
        return .init(width: width , height: height)
    }
    
}

extension MovieDetailsController: HeaderViewDelegate {
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
}




