//
//  File.swift
//  
//
//  Created by 최진용 on 2023/04/16.
//

import SwiftUI

struct LineView: View {
    @State var isMoved: Bool = false
    @State var isAdd: Bool = false
    @Environment(\.colorScheme) var scheme
    @State var startPosition: CGPoint = CGPoint(x: 306, y: 3)
    @State var startXLocation: String = "width"
    @State var startYLocation: String = "0"
    @State var endXLocation: String = "0"
    @State var endYLocation: String = "height"
    @State var endPoistion: CGPoint = CGPoint(x: 3, y: 306)
    @State var isEndMoved: Bool = false
    
    var body: some View {
        
        ZStack {
            Theme.myBackgroundColor(forScheme: scheme).ignoresSafeArea()
            VStack(spacing: 20) {
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Theme.white(forScheme: scheme))
                        .frame(width: 350, height: 350)
                        .shadow(radius: 1)
                    GeometryReader { proxy in
                        let width = proxy.size.width
                        let height = proxy.size.height
                        
                        Text("(0,0)").position(CGPoint(x: 3, y: 3)).font(.system(size: 12))
                        Text("Start Point \n (0,width)").position(CGPoint(x: width - width / 6, y: 10)).font(.system(size: 12)).opacity(isMoved ? 0 : 1)
                        Text("(0,height)").position(CGPoint(x: width / 5.7, y: height )).font(.system(size: 12)).opacity(isAdd ? 1 : 0)
                            .opacity(isEndMoved ? 0 : 1)
                        Circle().frame(width: 20).position(startPosition)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        let limitedX = max(min(gesture.location.x, width - width / 100), width / 100)
                                        let limitedY = max(min(gesture.location.y, height - height / 100), height / 100)
                                        
                                        startPosition = CGPoint(x: limitedX, y: limitedY)
                                        currentStartLocation()
                                        print(startPosition)
                                    }
                            )
                            .onChange(of: startPosition, perform: { value in
                                withAnimation(.linear(duration: 1)) { 
                                    isMoved = true
                                }
                            })
                        Circle()
                            .frame(width: 20)
                            .position(endPoistion)
                            .foregroundColor(.red)
                            .opacity(isAdd ? 1 : 0)
                            .opacity(isMoved ? 1 : 0)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        let limitedX = max(min(gesture.location.x, width - width / 100), width / 100)
                                        let limitedY = max(min(gesture.location.y, height - height / 100), height / 100)
                                        
                                        endPoistion = CGPoint(x: limitedX, y: limitedY)
                                        currentEndLocation()
                                        print(endPoistion)
                                    }
                            ).onChange(of: endPoistion, perform: { value in
                                withAnimation(.linear(duration: 1)) { 
                                    isEndMoved = true
                                }
                            })
                        Path { path in
                            path.move(to: startPosition)
                            path.addLine(to: endPoistion)
                            path.closeSubpath()
                        }.stroke(lineWidth: 2)
                            .opacity(isAdd ? 1 : 0)
                            .opacity(isMoved ? 1 : 0)
                            .foregroundColor(Theme.black(forScheme: scheme))
                    }
                     .frame(width: 310, height: 310)
                     .offset(y: 15)
                    .padding(.bottom, 30)
                }
                Text(AttributedString(text: " path.move(\n     to: CGPoint(x: \(startXLocation), y: \(startYLocation))            \n)", highlight: "move"))
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(width: 350)
                    .background(Theme.white(forScheme: scheme))
                    .foregroundColor(Theme.black(forScheme: scheme))
                    .font(.system(size: 17, weight: .semibold))
                
                .background(Theme.white(forScheme: scheme))
                .cornerRadius(12)
                .shadow(radius: 1)
                
                Button {
                    withAnimation(.easeIn(duration: 1)) {
                        isAdd.toggle()
                    }
                } label: {
                    HStack {
                        Text(AttributedString(text: " path.addLine (\n      to: CGPoint(x: \(endXLocation) , y: \(endYLocation) )\n)", highlight: "addLine"))
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 40)
                            .foregroundColor(Theme.black(forScheme: scheme))
                            .font(.system(size: 17, weight: .semibold))
//                        Image(systemName: "chevron.right").foregroundColor(.blue)
//                        Spacer()
                    }.padding()
                        .frame(width: 350)
                        .overlay(alignment: .trailing) { 
                            Image(systemName: "chevron.right").foregroundColor(.blue)
                                .offset(x: -20)
                        }
                }
                .background(Theme.white(forScheme: scheme))
                .cornerRadius(12)
                .shadow(radius: 1)
                .opacity(isMoved ? 1 : 0)
                
            }
        }.navigationTitle("addLine")
    }
    
    func currentStartLocation() {
        let currentX = Int(startPosition.x)
        let currentY = Int(startPosition.y)
        
        DispatchQueue.main.async {
            startXLocation = String(currentX - 3)
            startYLocation = String(currentY - 3)
            if currentX == 306 {
                startXLocation = "width"
            }
            if currentY == 306 {
                startYLocation = "height"
            }
        }
    }
    func currentEndLocation() {
        let currentX = Int(endPoistion.x)
        let currentY = Int(endPoistion.y)
        
        DispatchQueue.main.async {
            endXLocation = String(currentX - 3)
            endYLocation = String(currentY - 3)
            if currentX == 306 {
                endXLocation = "width"
            }
            if currentY == 306 {
                endYLocation = "height"
            }
        }
    }
}
    
    
    
    
    struct LineView_Preview: PreviewProvider {
        static var previews: some View {
            LineView()
        }
    }
