@Entry
@Component
struct Index {
  @State currentColor: string = '#00FFFF'
  @State showExtraNode: boolean = false

  private cPrimary: string = '#00FFFF'
  private cSecondary: string = '#00FF88'
  private cTertiary: string = '#BB86FC'
  private cBackground: string = '#0D0D0D'
  private cSurface: string = '#1C1C1C'
  private cSurfaceVariant: string = '#2E2E2E'
  private cOutline: string = '#3F3F3F'
  private cOnSurface: string = '#FFFFFF'

  @Builder
  Link(widthValue: number, x: number, y: number, angle: number) {
    Rect()
      .width(widthValue)
      .height(6)
      .radius(3)
      .fill(this.currentColor)
      .rotate({ angle: angle })
      .translate({ x: x, y: y })
  }

  @Builder
  Node(x: number, y: number) {
    Circle()
      .width(40)
      .height(40)
      .fill(this.currentColor)
      .translate({ x: x, y: y })
  }

  @Builder
  ColorButton(label: string, bg: string) {
    Button(label)
      .height(34)
      .padding({ left: 16, right: 16 })
      .fontSize(14)
      .fontColor(Color.Black)
      .backgroundColor(bg)
      .borderRadius(17)
      .onClick(() => {
        this.currentColor = bg
      })
  }

  @Builder
  CanvasMap() {
    Stack({ alignContent: Alignment.Center }) {
      Rect()
        .width('100%')
        .height('100%')
        .fill(this.cBackground)
      this.Link(210, -70, -20, -30)
      this.Link(190, 20, 80, 50)
      this.Node(-90, -80)
      this.Node(40, 20)
      this.Node(-20, 130)
      if (this.showExtraNode) {
        this.Link(150, 82, -55, 25)
        this.Node(130, -35)
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  BottomBar() {
    Row() {
      this.ColorButton('Cyan', this.cPrimary)
      Blank().width(12)
      this.ColorButton('Green', this.cSecondary)
      Blank().width(12)
      this.ColorButton('Purple', this.cTertiary)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding(12)
    .backgroundColor(this.cSurfaceVariant)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  build() {
    Stack() {
      this.CanvasMap()

      Column() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cPrimary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
          .backgroundColor(this.cBackground)
        Blank()
        this.BottomBar()
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .width(56)
            .height(56)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .backgroundColor(this.cSecondary)
            .borderRadius(28)
            .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
            .onClick(() => {
              this.showExtraNode = true
            })
            .margin({ right: 16, bottom: 78 })
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
