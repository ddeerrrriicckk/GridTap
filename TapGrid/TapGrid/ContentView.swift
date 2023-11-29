//
//  ContentView.swift
//  TapGrid
//
//

import SwiftUI

struct ContentView: View {
    @State private var counts = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    let gridSize = 9
    let numText = "0"
    var body: some View {
        //The GeometryReader is used to dynamically determine the size of the view.
        GeometryReader { geometry in
            //Multiplying by 0.9 to create a buffer around the edges of the grid.
            let size = min(geometry.size.width, geometry.size.height) * 0.9
            let squareSize = size / CGFloat(gridSize)
            let fontSize = calculateFontSize(for: numText, in: CGSize(width: squareSize, height: squareSize))
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                VStack(spacing: 0) {
                    ForEach(0..<gridSize, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<gridSize, id: \.self) { col in
                                Rectangle()
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: squareSize, height: squareSize)
                                    .overlay(
                                        Text("\(counts[row][col])")
                                            .font(.system(size: fontSize))
                                            .foregroundColor(.black)
                                            .lineLimit(1)
//                                            .minimumScaleFactor(10.5)
                                            .frame(width: squareSize, height: squareSize, alignment: .center)
                                            .onTapGesture {
                                                counts[row][col] += 1
                                                if counts[row][col] > 9 {
                                                    counts[row][col] = 0
                                                }
                                            }
                                    )
                            }
                        }
                    }
                }
                .frame(width: size, height: size)
                .overlay(
                    // The Rectangle with a stroke is used to draw the square.
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                )
            }
        }
    }
    // Calculate the size of a font to occupy most of the available space.
    func calculateFontSize(for text: String, in size: CGSize) -> CGFloat {
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 1)
        ]
        let strSize = text.size(withAttributes: attributes)
        let targetSize = size
        let scaleFactor = min(targetSize.width / strSize.width, targetSize.height / strSize.height)
        let fontSize = 1 * scaleFactor
        return fontSize
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
