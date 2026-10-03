@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === WindowGroup ===
      // children: 1
      WindowGroup() {
        // === FurnitureDetailScreen ===
        // props: {"_positional_raw":["true"]}
        // modifiers: ["statusBarHidden(true)"]
        FurnitureDetailScreen({ statusBarHidden: true })
      }
    }.width('100%').height('100%')
  }
}

// Stub for WindowGroup to ensure compilation if not provided by system
@Component
struct WindowGroup {
  @BuilderParam content: () => void

  build() {
    Column() {
      this.content()
    }
  }
}

// Stub for FurnitureDetailScreen to ensure compilation
@Component
struct FurnitureDetailScreen {
  private statusBarHidden: boolean = false

  constructor(options?: { statusBarHidden?: boolean }) {
    super();
    if (options?.statusBarHidden !== undefined) {
      this.statusBarHidden = options.statusBarHidden
    }
  }

  build() {
    Column() {
      Text('Furniture Detail Screen')
    }
  }
}