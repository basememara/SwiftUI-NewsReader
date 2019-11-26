//
//  MiddlewareType.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-26.
//

protocol MiddlewareType {
    func execute(on action: ActionType)
}
