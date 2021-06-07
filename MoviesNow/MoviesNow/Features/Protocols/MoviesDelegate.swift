//
//  MoviesDelegate.swift
//  MoviesNow
//
//  Created by Maurício de Freitas Sayão on 04/06/21.
//

import Foundation

protocol MoviesDelegate: AnyObject {
    
    func getData(data: [Movie]?)
}
