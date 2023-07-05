//
//  ContentView.swift
//  ChefDelivery
//
//  Created by ALURA on 17/05/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Attributes
    
    private var service = HomeService()
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationBar()
                    .padding(.horizontal, 15)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        OrderTypeGridView()
                        CarouselTabView()
                        StoresContainerView()
                    }
                }
            }
        }
        .onAppear {
            service.fetchData()
        }
    }
    
    // MARK: - Methods
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}
