//
//  DeepLinkManager.swift
//  DeepLinkPractice1
//
//  Created by 강성찬 on 2024-06-27.
//


import SwiftUI

class DeepLinkManager: ObservableObject {
    
    @Published var currentTab: ParisCafeTab = .home
    @Published var navigationPath = NavigationPath()
    @Published var currentCafeID: String?
    
    
    func checkDeepLink(url: URL) {
        guard let deepLinkComponent = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host else {
            return
        }
        
        print(deepLinkComponent)
        if deepLinkComponent == ParisCafeTab.home.title {
            resetNavigationPath()
            currentTab = .home
        } else if deepLinkComponent == ParisCafeTab.search.title {
            resetNavigationPath()
            currentTab = .search
        } else if deepLinkComponent == ParisCafeTab.setting.title {
            resetNavigationPath()
            currentTab = .setting
        } else {
            checkInternalDeepLinks(component: deepLinkComponent)
        }
    }
    
    func checkInternalDeepLinks(component: String) {
        if let cafe = DataSource.data.first(where: {$0.id == component}) {
            currentTab = .search
            resetNavigationPath()
            currentCafeID = cafe.id
        }
    }
    
    func resetNavigationPath() {
        navigationPath = NavigationPath()
    }
    
    func updateNavigationPath() {
        resetNavigationPath()
        if let selectedCafeID = currentCafeID,
           let selectedCafe = DataSource.data.first(where: { $0.id == selectedCafeID}) {
            navigationPath.append(selectedCafe)
        }
    }
}
    
