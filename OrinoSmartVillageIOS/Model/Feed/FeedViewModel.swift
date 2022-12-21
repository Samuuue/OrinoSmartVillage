//
//  FeedViewModel.swift
//  OrinoSmartVillageIOS
//
//  Created by Samuele Marelli on 01/11/22.
//

import Foundation

struct PostJSON: Decodable {
    let id: Int
    let status: String
    let link: String
    let title: Title
    let content: Content
    let excerpt: Excerpt
    //let featured_media_url: Bool
    
    struct Title: Decodable {
        let rendered: String
    }
    
    struct Content: Decodable {
        let rendered: String
    }
    
    struct Excerpt: Decodable {
        let rendered: String
    }
}

extension String {
    /// Converts HTML string to a `NSAttributedString`
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}

class FeedViewModel: ObservableObject {
    
    @Published var post: [SinglePost] = []

    func fetch(url: String, cerca: Bool) {
        
        if(self.post.isEmpty || cerca) {
            self.post = []
            
            guard let url = URL(string: url) else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
                    let posts = try  JSONDecoder().decode([PostJSON].self, from: data)
                    DispatchQueue.main.async {
                        posts.forEach { post in
                            self?.post.append(SinglePost(id: post.id, Status: post.status, Title: post.title.rendered, Content: self!.truncString(string: post.content.rendered.htmlAttributedString!.string), Excerpt: self!.truncString(string: post.excerpt.rendered.htmlAttributedString!.string), hasImage: false, Link: URL(string: post.link)!))
                        }
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
            self.post.shuffle()
        }
    }
    
    private func truncString(string: String) -> String {
        var ret: String = ""
        for(index, char) in string.enumerated() {
            if(index <= 150) {
                if(ret == "") {
                    ret = String(char)
                } else {
                    ret += String(char)
                }
            } else {
                if(String(char) == " ") {
                    ret += "..."
                    return ret
                } else {
                    ret += String(char)
                }
            }
        }
        return ret
    }
    
}

