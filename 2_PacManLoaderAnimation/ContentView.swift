//
//  ContentView.swift
//  2_PacManLoaderAnimation
//
//  Created by Viettasc on 11/7/19.
//  Copyright © 2019 Viettasc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var isAnimated = false
    
    var backgroundView: some View {
        RadialGradient(gradient: Gradient(colors: [Color.black,.blue]), center: .center, startRadius: 5, endRadius: 500)
            .scaleEffect(1.2)
    }
    
    var pacman: some View {
        Group {
            Circle()
                .frame(width: 5)
                .foregroundColor(.white)
                .offset(x: isAnimated ? 20 : 45, y: 5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: false))
                .onAppear {
                    self.isAnimated.toggle()
            }
            PacManComponent(isAnimated: isAnimated, isBottom: false)
            PacManComponent(isAnimated: isAnimated, isBottom: true)
            Circle()
                .frame(width: 5)
                .offset(x: 15, y: -25)
        }
    }
    
    var body: some View {
        ZStack {
            backgroundView
            pacman
        }
    }
    
}

struct PacManComponent: View {
    var isAnimated: Bool
    var isBottom: Bool
    fileprivate var degrees: Double {
        return isBottom ? 180 : 0
    }
    fileprivate var axis: (CGFloat, CGFloat) {
        return isBottom ? (0, 1) : (1, 0)
    }
    var body: some View {
        Circle()
            .trim(from: 1/3, to: isAnimated ? 0.9999 : 0.9)
            .frame(width: 100, height: 100)
            .rotationEffect(.degrees(degrees))
            .foregroundColor(.yellow)
            .animation(Animation.easeInOut(duration: 0.2).repeatForever(autoreverses: true))
            .rotation3DEffect(.degrees(degrees), axis: (x: axis.0, y: axis.1, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
