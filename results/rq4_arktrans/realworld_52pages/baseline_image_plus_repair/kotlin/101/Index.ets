@Entry
@Component
struct HomeScreen {
  // Color Tokens matching the Kotlin source
  private readonly COLOR_BACKGROUND: string = '#F8FBF1';
  private readonly COLOR_ON_SURFACE: string = '#191D19';
  private readonly COLOR_ON_SURFACE_VARIANT: string = '#424940';
  private readonly COLOR_PRIMARY_CONTAINER: string = '#D7F5D9';
  private readonly COLOR_ON_PRIMARY_CONTAINER: string = '#00210A';

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Menu Icon (Hamburger)
        Image($r('app.media.ic_menu'))
          .width(24)
          .height(24)
          .fillColor(this.COLOR_ON_SURFACE)
          .onClick(() => {
            // Handle menu click
          })

        Blank().width(16)

        // Title
        Text('Notes')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.COLOR_ON_SURFACE)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Flex({ justifyContent: FlexAlign.End, alignItems: ItemAlign.Center }) {
          Blank().layoutWeight(1)

          // Search Icon
          Image($r('app.media.ic_search'))
            .width(24)
            .height(24)
            .fillColor(this.COLOR_ON_SURFACE)
            .margin({ right: 8 })
            .onClick(() => {
              // Handle search click
            })

          // Grid View Icon
          Image($r('app.media.ic_grid_view'))
            .width(24)
            .height(24)
            .fillColor(this.COLOR_ON_SURFACE)
            .margin({ right: 8 })
            .onClick(() => {
              // Handle grid toggle
            })

          // More Options Icon (Vertical Dots)
          Image($r('app.media.ic_more_vert'))
            .width(24)
            .height(24)
            .fillColor(this.COLOR_ON_SURFACE)
            .onClick(() => {
              // Handle more options
            })
        }
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(this.COLOR_BACKGROUND)

      // Main Content Area - Empty State
      Column() {
        Text('No notes yet')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.COLOR_ON_SURFACE)
          .margin({ bottom: 8 })

        Text('Tap + to create your first note')
          .fontSize(16)
          .fontColor(this.COLOR_ON_SURFACE_VARIANT)
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.COLOR_BACKGROUND)

      // Floating Action Button (FAB)
      Row() {
        Image($r('app.media.ic_add'))
          .width(24)
          .height(24)
          .fillColor(this.COLOR_ON_PRIMARY_CONTAINER)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor(this.COLOR_PRIMARY_CONTAINER)
      .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
      .position({ x: 'calc(100% - 72vp)', y: 'calc(100% - 72vp)' })
      .onClick(() => {
        // Handle create note
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.COLOR_BACKGROUND)
  }
}