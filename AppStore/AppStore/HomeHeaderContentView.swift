//
//  HomeHeaderContentView.swift
//  AppStore
//
//  Created by Brett Markowitz on 11/1/20.
//

import SwiftUI

struct HomeHeaderContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("SUNDAY, NOVEMBER 1")
                .font(.system(size: 13, weight: .semibold, design: .default))
                .foregroundColor(.secondary)
            HStack {
                Text("Home")
                    .font(.system(size: 34, weight: .bold, design: .default))
                Spacer()
                Circle()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.blue)
            }
            .background(Color(.clear))
        }
        .padding(.top)
        .background(Color(.clear))
    }
}

struct HomeHeaderContentView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red
            HomeHeaderContentView()
        }
    }
}
