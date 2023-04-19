//
//  File.swift
//  
//
//  Created by 최진용 on 2023/04/12.
//

import SwiftUI

struct AddQuardCurveView: View {
    @Environment(\.colorScheme) var scheme
    @State private var location = CGPoint.zero
    @State private var xLocation: String = "0"
    @State private var yLocation: String = "0"
    
    var body: some View {
        ZStack {
            Theme.myBackgroundColor(forScheme: scheme).ignoresSafeArea()
            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Theme.white(forScheme: scheme))
                        .shadow(radius: 2)
                    GeometryReader { proxy in
                        ZStack {
                            let width = proxy.size.width
                            let height = proxy.size.height
                            Text("(width, 0)").position(x: width - 40, y:0).font(.system(size: 12))
                            Text("(0, height)").position(x: 50, y: height).font(.system(size: 12))
                            
                            Circle().frame(width: 10).position(CGPoint(x: width - 5, y: 5)).foregroundColor(Theme.black(forScheme: scheme))
                            Circle().frame(width: 10).position(CGPoint(x: 5, y: height - 5)).foregroundColor(Theme.black(forScheme: scheme))
                            Path{ path in
                                path.move(to: CGPoint(x: width - 5, y: 5))
                                path.addLine(to: CGPoint(x: 5, y: height - 5))
                                path.closeSubpath()
                            }.stroke(lineWidth: 2)
                                .fill(Theme.black(forScheme: scheme))
                                .cornerRadius(20)
                                .opacity(0.2)
                            Path{ path in
                                path.move(to: CGPoint(x: width - 5, y: 5))
                                path.addQuadCurve(to: CGPoint(x: 5, y: height - 5), control: location)
                            }.stroke(lineWidth: 2)
                                .cornerRadius(20)
                            
                            Path { path in
                                path.move(to: CGPoint(x: width, y: 0))
                                path.addLine(to: location)
                                path.closeSubpath()
                            }.stroke(lineWidth: 2)
                                .cornerRadius(20)
                                .opacity(0.5)
                                .foregroundColor(.blue)
                            
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: height))
                                path.addLine(to: location)
                                path.closeSubpath()
                            }.stroke(lineWidth: 2)
                                .cornerRadius(20)
                                .opacity(0.5)
                                .foregroundColor(.red)
                            
                            Circle()
                                .foregroundColor(Color.blue)
                                .frame(width: 20)
                                .position(location)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            let limitedX = max(min(gesture.location.x, width - width / 200), width / 200)
                                            let limitedY = max(min(gesture.location.y, height - height / 200), height / 200)
                                            
                                            location = CGPoint(x: limitedX, y: limitedY)
                                            currentLocation()
                                            print(location)
                                        }
                                )
                                .onAppear {
                                    resetLoaction(x:  width - width / 140, y: height - height / 140)
                                }
                        }
                    }.frame(width: 300,height: 300)
                        .background(Color.clear)
                        .padding()
                }.frame(width: 350, height: 350)
                Text(AttributedString(text: " path.move(\n     to: CGPoint(x: width, y: 0)            \n)", highlight: "move"))
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(width: 350)
                    .background(Theme.white(forScheme: scheme))
                    .foregroundColor(Theme.black(forScheme: scheme))
                    .font(.system(size: 17, weight: .semibold))
//                    .shadow(radius: 2)
                    .cornerRadius(12)
                Text(AttributedString(text: "path.addQuadCurve(\n      to: \n            CGPoint(x: 0, y: height),        \n      control: \n            CGPoint(x: \(xLocation) , y: \(yLocation))\n)", highlight: ["addQuadCurve", "to:", "control:"]))
                    .padding()
                    .frame(width: 350)
                    .background(Theme.white(forScheme: scheme))
                    .foregroundColor(Theme.black(forScheme: scheme))
                    .font(.system(size: 17, weight: .semibold))
//                    .shadow(radius: 2)
                    .cornerRadius(12)
            }
        }.navigationTitle("addQuadCurve")
    }
    
    func resetLoaction(x: CGFloat, y: CGFloat) {
        self.location = CGPoint(x: x, y: y)
    }
    
    func currentLocation() {
        let currentX = Int(location.x)
        let currentY = Int(location.y)
        
        
        DispatchQueue.main.async {
            xLocation = String(currentX - 1)
            yLocation = String(currentY - 1)
            if currentX == 298 {
                xLocation = "width"
            }
            if currentY == 298 {
                yLocation = "height"
            }
        }
    }
}


struct AddQuardCurveView_Preview: PreviewProvider {
    static var previews: some View {
        AddQuardCurveView()
    }
}
