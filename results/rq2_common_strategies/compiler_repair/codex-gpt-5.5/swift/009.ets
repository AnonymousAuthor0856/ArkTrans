@Entry
@Component
struct Index {
  private cPrimary: string = '#1E3A8A'
  private cBackground: string = '#0F172A'
  private cSurface: string = '#1E293B'
  private cSurfaceVariant: string = '#334155'
  private cOutline: string = '#475569'
  private cOnSurface: string = '#E2E8F0'
  private cChip: string = '#E8DEF8'
  private cMuted: string = '#A3AAB5'

  @Builder
  TonalButton(title: string) {
    Button(title)
      .width(90)
      .height(48)
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .fontColor('#1D192B')
      .backgroundColor(this.cChip)
      .borderRadius(18)
  }

  @Builder
  ProgressArea() {
    Column() {
      Row() {
        Blank()
        Rect()
          .width('40%')
          .height(32)
          .radius(16)
          .fill(this.cPrimary)
        Rect()
          .width(6)
          .height(72)
          .radius(3)
          .fill(this.cPrimary)
          .margin({ left: 9, right: 9 })
        Stack({ alignContent: Alignment.End }) {
          Rect()
            .width('100%')
            .height(32)
            .radius(16)
            .fill(this.cOutline)
          Circle()
            .width(12)
            .height(12)
            .fill(this.cPrimary)
            .margin({ right: 10 })
        }
        .width('47%')
        .height(32)
        Blank()
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('1:35')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cMuted)
          .padding({ left: 10 })
        Blank()
        Text('4:00')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cMuted)
          .padding({ right: 10 })
      }
      .width('100%')
      .margin({ top: 10 })
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 8, bottom: 6 })
  }

  build() {
    Column() {
      Text('Video Player')
        .height(56)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cOnSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height(300)
          .radius(24)
          .fill(this.cSurfaceVariant)
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E6E2E8F0')
      }
      .width('100%')
      .height(300)
      .padding({ right: 10 })

      Text('Journey through the Skies')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E0E8F0')
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      this.ProgressArea()

      Row() {
        this.TonalButton('-10s')
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(120)
            .height(120)
            .fill(this.cPrimary)
          Text('▶')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ left: 4 })
        }
        .width(120)
        .height(120)
        .margin({ left: 24, right: 24 })
        this.TonalButton('+30s')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 10, bottom: 10 })

      Button('Fullscreen')
        .width(220)
        .height(64)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#47434E')
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: this.cOutline, radius: 12 })
        .margin({ top: 12 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
