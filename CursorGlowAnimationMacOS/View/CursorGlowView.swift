//
//  CursorGlowView.swift
//  CursorGlowAnimationMacOS
//
//  Created by Volodymyr Pysarenko on 15.06.2024.
//

import SwiftUI

struct CursorGlowView<Content: View>: View {
    var content: Content
    var glowOpacity: CGFloat = 0.5
    var blurRadius: CGFloat = 50
    
    init(glowOpacity: CGFloat = 0.8, blurRadius: CGFloat = 50, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.glowOpacity = glowOpacity
        self.blurRadius = blurRadius
    }
    
    //Hover+Cursor properties
    //Cursor location on main window
    var cursorLocation: CGPoint {NSApplication.shared.mainWindow?.mouseLocationOutsideOfEventStream ?? .zero}
    @State var location: CGPoint = .zero
    //Storing event
    @State var event: Any?
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let minX = proxy.frame(in: .global).minX
            let minY = proxy.frame(in: .global).minY
            
            //Scaling anchor point
            let tempX = (location.x / size.width)
            let tempY = (location.y / size.height)
            
            let progressX = (tempX < 0 ? 0 : (tempX > 1 ? 1 : tempX))
            let progressY = (tempY < 0 ? 0 : (tempY > 1 ? 1 : tempY))
            
            ZStack{
                content
                //Glow animation
                Circle()
                    .fill(.white.opacity(glowOpacity))
                    .frame(width: 45, height: 45)
                    .blur(radius: blurRadius)
                    .offset(x: 22, y: -14) //x = 45 / 2, y = title bar height / 2
                    .offset(x: location.x, y: location.y)
                    .opacity(location == .zero ? 0 : 1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .animation(.none, value: location)
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .scaleEffect(1 + (location == .zero ? 0 : 0.05), anchor: .init(x: -progressX, y: -progressY))
            .frame(width: size.width, height: size.height)
            .onHover(perform: { hovering in
                if !hovering {
                    //Removing when its moved
                    if let event = event {
                        NSEvent.removeMonitor(event)
                        withAnimation(.linear.speed(1)) {
                            location = .zero
                        }
                        
                    }
                } else {
                    //Adding cursor event observer
                    self.event = NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved]) { event in
                        //Extracting the corect location fo each card
                        //Removing window height will give correct y location
                        let windowHeight = (NSApplication.shared.mainWindow?.frame.height ?? 0)

                        withAnimation(location == .zero ? .linear.speed(2) : .none) {
                            self.location =  CGPoint(x: cursorLocation.x - minX, y: windowHeight - cursorLocation.y - minY)
                        }
                   
                        return event
                    }
                }
            })
        }
    }
}

//#Preview {
//    CursorGlowView()
//}
