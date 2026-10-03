

import SwiftUI


struct NoResultsView_Preview: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
                .font(.system(size: 50))
                .padding(.bottom)

            Text("No Results")
                .font(.title2)
                .bold()
                .padding(.bottom, 3)

            Text("Check the spelling, try a new search or choose another category.")
                .multilineTextAlignment(.center)
                .font(.callout)
                .foregroundStyle(.secondary)
                .padding(.bottom, 15)
        }
    }
}

#Preview {
    NoResultsView_Preview()

}
