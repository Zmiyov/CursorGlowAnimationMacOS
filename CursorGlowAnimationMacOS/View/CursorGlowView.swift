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
    
    init(glowOpacity: CGFloat = 0.5, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.glowOpacity = glowOpacity
    }
    
    //Hover+Cursor properties
    //Cursor location on main window
    var cursorLocation: CGPoint {NSApplication.shared.mainWindow!.mouseLocationOutsideOfEventStream}
    @State var location: CGPoint = .zero
    //Storing event
    @State var event: Any?
    
    var body: some View {
        VStack(spacing: 20){
            GeometryReader { proxy in
                let size = proxy.size
                let minX = proxy.frame(in: .global).minX
                let minY = proxy.frame(in: .global).minY
                
                ZStack{
                    content
                }
                .frame(width: size.width, height: size.height)
                .onHover(perform: { hovering in
                    if !hovering {
                        //Removing when its moved
                        if let event = event {
                            NSEvent.removeMonitor(event)
                        }
                    } else {
                        //Adding cursor event observer
                        self.event = NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved]) { event in
                            //Extracting the corect location fo each card
                            //Removing window height will give correct y location
                            let windowHeight = (NSApplication.shared.mainWindow?.frame.height ?? 0)
                            let location = CGPoint(x: cursorLocation.x - minX, y: windowHeight - cursorLocation.y - minY)
                            self.location = location
                            return event
                        }
                    }
                })
            }
            Text("X: \(Int(location.x)), Y: \(Int(location.y))")
                .font(.caption)
        }
    }
}

//#Preview {
//    CursorGlowView()
//}
