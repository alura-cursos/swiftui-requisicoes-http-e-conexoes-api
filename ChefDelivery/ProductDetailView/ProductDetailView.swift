//
//  ProductDetailView.swift
//  ChefDelivery
//
//  Created by Giovanna Moeller on 03/06/23.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: ProductType
    @State private var productQuantity = 1
    
    @State private var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var service = HomeService()
    
    var body: some View {
        VStack {

            ProductDetailHeaderView(product: product)
            
            Spacer()
            
            ProductDetailQuantityView(productQuantity: $productQuantity)
            
            //Text("\(productQuantity)")
            
            Spacer()
            
            ProductDetailButtonView {
                Task {
                    await confirmOrder()
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Chef Delivery"), message: Text("Pedido enviado com sucesso"), dismissButton: .default(Text("Ok"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        }
    }
    
    func confirmOrder() async {
        do {
            let result = try await service.confirmOrder(product: product)
            switch result {
            case .success(let message):
                showAlert = true
            case .failure(let error):
                print(error.localizedDescription)
                showAlert = false
            }
        } catch {
            print(error.localizedDescription)
            showAlert = false
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: storesMock[0].products[0])
    }
}

struct ProductDetailButtonView: View {
    
    var onButtonPress: () -> Void
    
    var body: some View {
        Button {
            onButtonPress()
        } label: {
            HStack {
                Image(systemName: "cart")
                Text("Enviar pedido")
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .font(.title3)
            .bold()
            .foregroundColor(.white)
            .background(Color("ColorRed"))
            .cornerRadius(32)
            .shadow(color: Color("ColorRedDark").opacity(0.5), radius: 10, x: 6, y: 8)
        }
    }
}
