@Entry
@Component
struct Index {
  build() {
    Stack() {
      // WindowGroup is a SwiftUI concept not directly available in ArkTS Entry components.
      // In ArkTS, the @Entry component itself represents the window content.
      // We map the inner structure directly.
      
      // ZStack with alignment .bottom maps to Stack with alignContent Alignment.Bottom
      Stack({ alignContent: Alignment.Bottom }) {
        // VStack with spacing 0 maps to Column with space 0
        Column({ space: 0 }) {
          // ScrollView with showsIndicators false maps to Scroll with scrollbarVisibility BarState.Off
          Scroll() {
            // LazyVStack maps to List or Grid depending on context, but since it's a vertical stack of items,
            // and we have a ForEach inside, we can use a List for efficient rendering if items are uniform,
            // or a Column inside a Scroll if static. However, LazyVStack implies dynamic/lazy loading.
            // In ArkTS, List is the standard for lazy vertical lists.
            // The modifiers padding(.horizontal) and padding(.bottom) apply to the container.
            
            // Note: The skeleton shows LazyVStack containing a ForEach. 
            // In ArkTS, List contains ListItem which can contain ForEach logic via builder or direct iteration.
            // Since we don't have the 'workouts' data source defined, we will create a placeholder array.
            
            List() {
              // Placeholder for workouts data
              ForEach([1, 2, 3], (item: number) => {
                ListItem() {
                  Text(`Workout ${item}`)
                    .width('100%')
                    .padding(16)
                    .backgroundColor('#F5F5F5')
                    .borderRadius(8)
                }
              })
            }
            .layoutWeight(1)
            .padding({ left: 16, right: 16 }) // Approximation of HealthDashboardTokens.Spacing.md
            .padding({ bottom: 100 }) // Approximation of bottomBarHeight + Spacing.lg
          }
          .scrollBar(BarState.Off)
          .layoutWeight(1)
        }
      }
      // statusBarHidden(true) is handled by window configuration in mainAbility or page config, 
      // not typically in UI build method. Ignoring as per standard ArkTS UI patterns.
    }.width('100%').height('100%')
  }
}