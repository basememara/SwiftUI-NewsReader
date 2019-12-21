//
//  File.swift
//  
//
//  Created by Basem Emara on 2019-12-20.
//

#if canImport(SwiftUI)
import SwiftUI

@available(OSX 10.15, iOS 13.0, watchOS 6.0, *)
public extension View {
    
    /// Wrap different views to be returned through opaque types.
    ///
    ///     func displayView() -> some View {
    ///         guard let article = article else {
    ///             return ShowErrorView()
    ///                 .eraseToAnyView()
    ///         }
    ///
    ///         return ShowArticleView(article: article)
    ///             .eraseToAnyView()
    ///     }
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
#endif
