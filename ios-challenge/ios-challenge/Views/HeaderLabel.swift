//
//  HeaderLabel.swift
//  ios-challenge
//
//  Created by Caio Madeira on 10/06/21.
//

import Foundation
import SwiftUI


struct HeaderLabel: View {
    
    let title: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View{
            
            Text(title)
                .font(.custom("AlNile-Bold", size: 35))
                .foregroundColor(.black)
                .frame(width: width, height: height, alignment: .leading)
                .padding(.leading, 20)

    
    }
    
}
