const PRIMARY: number = 0xFFFFA500
const SECONDARY: number = 0xFFFFC300
const BACKGROUND: number = 0xFFFFFBF2
const SURFACE_VARIANT: number = 0xFFFFEED6
const TEXT: number = 0xFF1E1E1E

@Entry
@Component
struct TransferWizard {
  @State progress: number = 40

  private increaseProgress(): void {
    this.progress = Math.min(100, this.progress + 10)
  }

  private decreaseProgress(): void {
    this.progress = Math.max(0, this.progress - 10)
  }

  build() {
    Column() {
      Text('Transfer Wizard')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 28 })

      Blank()
        .layoutWeight(1)

      Stack() {
        Circle()
          .width(520)
          .height(520)
          .fill(SURFACE_VARIANT)

        Circle()
          .width(40)
          .height(40)
          .fill(PRIMARY)
          .position({ x: 148, y: 112 })
      }
      .width('100%')
      .height(520)
      .alignContent(Alignment.Center)

      Blank()
        .layoutWeight(1)

      Column() {
        Text('Transfer Progress')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(TEXT)
          .textAlign(TextAlign.Center)

        Row() {
          Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
            .color(PRIMARY)
            .backgroundColor(SURFACE_VARIANT)
            .height(8)
            .borderRadius(4)
            .layoutWeight(1)

          Circle()
            .width(8)
            .height(8)
            .fill(PRIMARY)
            .margin({ left: 326 })
        }
        .width('80%')
        .height(8)
        .margin({ top: 26 })
        .alignItems(VerticalAlign.Center)

        Row() {
          Button('+')
            .width(116)
            .height(80)
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .backgroundColor(PRIMARY)
            .borderRadius(40)
            .onClick(() => this.increaseProgress())

          Button('-')
            .width(116)
            .height(80)
            .fontSize(26)
            .fontColor(TEXT)
            .backgroundColor(SECONDARY)
            .borderRadius(40)
            .margin({ left: 24 })
            .onClick(() => this.decreaseProgress())
        }
        .justifyContent(FlexAlign.Center)
        .margin({ top: 44, bottom: 40 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [0x33FFC300, 0.0],
        [0x00FFFBF2, 0.52],
        [0x33FFA500, 1.0]
      ]
    })
  }
}
