import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
                List {
                    NavigationLink {
                        LineView()
                    } label: {
                        MenuRow(title: "Path.addLine", description: "Description of Path function move and addLine", image: "pen")
                    }
                    NavigationLink {
                        AddQuardCurveView()
                    } label: {
                        MenuRow(title: "Path.addQuadCurve", description: "Quadratic Bézier parametric curve", image: "curve")
                    }
                    NavigationLink {
                        AddCurveView()
                    } label: {
                        MenuRow(title: "Path.addCurve", description: "Cubic Bézier parametric curve", image: "wave")
                    }
                }
                .navigationTitle("Path")
        }
    }
}
