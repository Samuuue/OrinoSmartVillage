//
//  ScannView.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 03/10/22.
//

import SwiftUI
import CodeScanner

struct ScannView: View {
    
    @State var isPresentingScaner = true
    @State var scannedCode: String = ""
    @State var scannerComplete = false
    @State var toogleDisplay = true
    
    var scannerSheet: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPresentingScaner = false
                    scannerComplete = true
                }
            })
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(LocalizedStringKey("QR code label"))
                Button(LocalizedStringKey("QR code button")) {
                    toogleDisplay.toggle()
                    self.isPresentingScaner = true
                }
                .font(.system(size: 25))
            }
            if scannerComplete {
                if(toogleDisplay) {
                    Display(url: URL(string: scannedCode)!)
                        .overlay(closeButton, alignment: .topTrailing)
                }
            }
        }
        .sheet(isPresented: $isPresentingScaner) {
            self.scannerSheet
        }
    }
}

extension ScannView {
    private var closeButton: some View {
        Button(action: {
            toogleDisplay.toggle()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(10)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        })
    }
}

//struct ScanView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScannView()
//    }
//}
