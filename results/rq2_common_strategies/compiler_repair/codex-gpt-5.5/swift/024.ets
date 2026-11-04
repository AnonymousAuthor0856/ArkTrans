@Entry
@Component
struct Index {
  @State currentColor: string = '#EF476F'
  @State showPoints: boolean = true

  private cPrimary: string = '#EF476F'
  private cSecondary: string = '#FFD166'
  private cTertiary: string = '#06D6A0'
  private cBackground: string = '#FFFCF2'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#F7EDE2'
  private cOutline: string = '#E5D4B1'
  private cText: string = '#1E1E1E'

  @Builder
  ColorButton(label: string, bg: string, fg: string) {
    Button(label)
      .height(44)
      .layoutWeight(1)
      .fontSize(14)
      .fontColor(fg)
      .backgroundColor(bg)
      .borderRadius(6)
      .onClick(() => {
        this.currentColor = bg
        this.showPoints = true
      })
  }

  @Builder
  CanvasArea() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill(this.cBackground)
      if (this.showPoints) {
        Circle()
          .width(20)
          .height(20)
          .fill(this.currentColor)
          .translate({ x: -80, y: -80 })
        Circle()
          .width(20)
          .height(20)
          .fill(this.currentColor)
          .translate({ x: -40, y: -30 })
        Circle()
          .width(20)
          .height(20)
          .fill(this.currentColor)
          .translate({ x: 20, y: 20 })
        Circle()
          .width(20)
          .height(20)
          .fill(this.currentColor)
          .translate({ x: 70, y: 70 })
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  BottomBar() {
    Row() {
      this.ColorButton('Red', this.cPrimary, '#FFFFFF')
      Blank().width(12)
      this.ColorButton('Yellow', this.cSecondary, this.cText)
      Blank().width(12)
      this.ColorButton('Green', this.cTertiary, this.cText)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(this.cSurface)
    .shadow({ radius: 2, color: '#1F000000', offsetY: 2 })
  }

  build() {
    Stack() {
      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cText)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 12, bottom: 12 })
          .backgroundColor(this.cBackground)
        Column() {
          this.CanvasArea()
        }
        .layoutWeight(1)
        .padding({ bottom: 80 })
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.cBackground)

      Column() {
        Blank()
        Row() {
          Blank()
          Button('Clear')
            .width(56)
            .height(56)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cText)
            .backgroundColor(this.cSecondary)
            .borderRadius(28)
            .shadow({ radius: 2, color: '#1F000000', offsetY: 2 })
            .onClick(() => {
              this.showPoints = false
            })
            .margin({ right: 24, bottom: 24 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
