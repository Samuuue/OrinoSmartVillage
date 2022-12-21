//
//  Display.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 12/10/22.
//
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var title: String
    var url: URL
    var loadStatusChanged: ((Bool, Error?) -> Void)? = nil

    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        preferences.accessibilityActivate()
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.ignoresViewportScaleLimits = true
        webConfiguration.suppressesIncrementalRendering = false
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.allowsAirPlayForMediaPlayback = true
        webConfiguration.allowsPictureInPictureMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        webConfiguration.defaultWebpagePreferences = preferences
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        view.navigationDelegate = context.coordinator
        view.load(URLRequest(url: url))
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // you can access environment via context.environment here
        // Note that this method will be called A LOT
    }

    func onLoadStatusChanged(perform: ((Bool, Error?) -> Void)?) -> some View {
        var copy = self
        copy.loadStatusChanged = perform
        return copy
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.loadStatusChanged?(true, nil)
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.title = webView.title ?? ""
            parent.loadStatusChanged?(false, nil)
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.loadStatusChanged?(false, error)
        }
    }
}

struct Display: View {
    @State var title: String = ""
    @State var error: Error? = nil
    let url: URL

    var body: some View {
        NavigationView {
            WebView(title: $title, url: url)
                .onLoadStatusChanged { loading, error in
                    if loading {
                        print("Loading started")
                        self.title = String(localized: "Carica")                    }
                    else {
                        print("Done loading.")
                        if let error = error {
                            self.error = error
                            if self.title.isEmpty {
                                self.title = String(localized: "Errore")
                            }
                        }
                        else if self.title.isEmpty {
                            self.title = String(localized: "Alcuni luoghi")
                        }
                    }
            }
            .navigationBarTitle(title)
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        Display(url: URL(string: "https://dash.covid19-italy.it/")!)
    }
}
