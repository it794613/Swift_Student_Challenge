//
//  File.swift
//  
//
//  Created by 최진용 on 2023/04/12.
//

import SwiftUI

struct AddCurveView: View {
    //    @State private var draggedOffset = CGSize.zero
    //    @State private var accumulatedOffset = CGSize.zero
     @Environment(\.colorScheme) var scheme
    @State private var firstLocation = CGPoint.zero
    @State private var secondLocation = CGPoint.zero
    @State var firstX: String = "width"
    @State var firstY: String = "height"
    @State var secondX: String = "0"
    @State var secondY: String = "0"
    
    var body: some View {
        ZStack {
            Theme.myBackgroundColor(forScheme: scheme).ignoresSafeArea()
            VStack(spacing: 30) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12).fill(Theme.white(forScheme: scheme)).shadow(radius: 2)
                    GeometryReader { proxy in
                        ZStack {
                            let width = proxy.size.width
                            let height = proxy.size.height
                            Text("(width, 0)").position(x: width - 40, y:0).font(.system(size: 12))
                            Text("(0, height)").position(x: 50, y: height).font(.system(size: 12))
                            Circle()
                                .frame(width: 10)
                                .position(CGPoint(x: width - 5, y: 5))
                                .foregroundColor(Theme.black(forScheme: scheme))
                            Circle()
                                .frame(width: 10).position(CGPoint(x: 5, y: height - 5))
                                .foregroundColor(Theme.black(forScheme: scheme))
                            Path{ path in
                                path.move(to: CGPoint(x: width - 5, y: 5))
                                path.addLine(to: CGPoint(x: 5, y: height - 5))
                                path.closeSubpath()
                            }.stroke(lineWidth: 2)
                                .cornerRadius(20)
                                .opacity(0.2)
                            Path{ path in
                                path.move(to: CGPoint(x: width - 5, y: 5))
                                path.addCurve(to: CGPoint(x: 0, y: height), control1: firstLocation, control2: secondLocation)
                            }.stroke(lineWidth: 2)
                                .cornerRadius(20)
                            Path { path in
                                path.move(to: CGPoint(x: width, y: 0))
                                path.addLine(to: firstLocation)
                                path.closeSubpath()
                            }.stroke(lineWidth: 2)
                                .cornerRadius(20)
                                .opacity(0.5)
                                .foregroundColor(.blue)
                            
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: height))
                                path.addLine(to: secondLocation)
                                path.closeSubpath()
                            }.stroke(lineWidth: 2)
                                .cornerRadius(20)
                                .opacity(0.5)
                                .foregroundColor(.red)
                            
                            Circle()
                                .foregroundColor(Color.blue)
                                .frame(width: 20)
                                .position(firstLocation)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            let limitedX = max(min(gesture.location.x, width - width / 200), width / 200)
                                            let limitedY = max(min(gesture.location.y, height - height / 200), height / 200)
                                            
                                            firstLocation = CGPoint(x: limitedX, y: limitedY)
                                            print(firstLocation)
                                            getFirstLocation()
                                        }
                                )
                                .onAppear {
                                    resetFirstLoaction(x: width, y: height)
                                }
                            Circle()
                                .foregroundColor(Color.red)
                                .frame(width: 20)
                                .position(secondLocation)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            let limitedX = max(min(gesture.location.x, width - width / 100), width / 100)
                                            let limitedY = max(min(gesture.location.y, height - height / 100), height / 100)
                                            
                                            secondLocation = CGPoint(x: limitedX, y: limitedY)
                                            getSecondLocation()
                                            print(secondLocation)
                                        }
                                )
                                .onAppear {
                                    resetSecondLocation(x: 0, y: 0)
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
                Text(AttributedString(text: "path.addQuadCurve(\n      to:             (x: 0, y: height),        \n      control1: (x: \(firstX) , y: \(firstY)),\n      control2: (x: \(secondX), y: \(secondY))\n)", highlight: ["addQuadCurve", "to:", "control1:", "control2"]))
                    .padding()
                //                    .multilineTextAlignment(.leading)
                    .frame(width: 350)
                    .background(Theme.white(forScheme: scheme))
                    .foregroundColor(Theme.black(forScheme: scheme))
                    .font(.system(size: 17, weight: .semibold))
                //                    .shadow(radius: 2)
                    .cornerRadius(12)
            }
        }.navigationTitle("addCurve")
    }
    
    
    
    func resetFirstLoaction(x: CGFloat, y: CGFloat) {
        self.firstLocation = CGPoint(x: x, y: y)
    }
    func resetSecondLocation(x: CGFloat, y: CGFloat) {
        self.secondLocation = CGPoint(x: x, y: y)
    }
    func getSecondLocation() {
        let currentX = Int(secondLocation.x)
        let currentY = Int(secondLocation.y)
        

        DispatchQueue.main.async {
            secondX = String(currentX - 3)
            secondY = String(currentY - 3)
            if currentX == 297 {
                secondX = "width"
            }
            if currentY == 297 {
                secondY = "height"
            }
        }
    }
    func getFirstLocation() {
        let currentX = Int(firstLocation.x)
        let currentY = Int(firstLocation.y)
        

        DispatchQueue.main.async {
            firstX = String(currentX - 1)
            firstY = String(currentY - 1)
            if currentX == 298 {
                firstX = "width"
            }
            if currentY == 298 {
                firstY = "height"
            }
        }
    }
    
}


struct AddCurveView_Preview: PreviewProvider {
    static var previews: some View {
        AddCurveView()
    }
}
