@Entry
@Component
struct RootScreen {
  @State fontSize: number = 23
  @State syncProgress: number = 0.3

  // Color constants
  private readonly cPrimary: string = '#8B5CF6'
  private readonly cSecondary: string = '#D946EF'
  private readonly cBackground: string = '#F9F5FF'
  private readonly cSurface: string = '#FFFFFF'
  private readonly cSurfaceVariant: string = '#F1E9FE'
  private readonly cOutline: string = '#E3D7FE'
  private readonly cOnPrimary: string = '#FFFFFF'
  private readonly cOnSecondary: string = '#FFFFFF'
  private readonly cOnSurface: string = '#1E1E1E'

  build() {
    Column({ space: 0 }) {
      // Title bar
      Row({ space: 0 }) {
        Text('Subtitle Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cOnSurface)
          .padding({ left: 16, top: 12, bottom: 12 })
      }
      .width('100%')
      .backgroundColor(this.cBackground)

      // Content area
      Column({ space: 24 }) {
        // Sample subtitle line display
        Column()
          .width('100%')
          .height(200)
          .backgroundColor(this.cSurface)
          .borderRadius(22)
          .shadow({
            radius: 8,
            color: '#2E000000',
            offsetY: 6
          })
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        // Text inside the display
        Text('Sample Subtitle Line')
          .fontSize(this.fontSize)
          .fontColor(this.cOnSurface)

        // Font size label
        Text('Font Size: ' + Math.round(this.fontSize).toString() + 'sp')
          .fontSize(14)
          .fontColor(this.cOnSurface)

        // Slider for font size
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1
        })
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value
          })

        // Sync progress label
        Text('Sync Progress')
          .fontSize(14)
          .fontColor(this.cOnSurface)

        // Progress bar
        Progress({
          value: this.syncProgress,
          total: 1,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(this.cPrimary)
          .backgroundColor(this.cSurfaceVariant)

        // Buttons row
        Row({ space: 12 }) {
          // Sync + button
          Button() {
            Text('Sync +')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.cOnPrimary)
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor(this.cPrimary)
          .borderRadius(14)
          .onClick(() => {
            this.syncProgress = Math.min(1.0, this.syncProgress + 0.1)
          })

          // Sync - button
          Button() {
            Text('Sync -')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.cOnSecondary)
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor(this.cSecondary)
          .borderRadius(14)
          .onClick(() => {
            this.syncProgress = Math.max(0.0, this.syncProgress - 0.1)
          })
        }
        .width('100%')

        // Bottom spacer
        Blank().height(50)
      }
      .padding(16)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.cBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
    .padding(0)
  }
}