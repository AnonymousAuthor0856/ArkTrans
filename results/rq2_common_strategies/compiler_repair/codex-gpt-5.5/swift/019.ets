@Entry
@Component
struct Index {
  @State fontSize: number = 23
  @State syncProgress: number = 0.3

  private cPrimary: string = '#8B5CF6'
  private cSecondary: string = '#D946EF'
  private cTertiary: string = '#3B82F6'
  private cBackground: string = '#F9F5FF'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#F1E9FE'
  private cOutline: string = '#E3D7FE'
  private cText: string = '#1E1E1E'

  private fontLabel(): string {
    return 'Font Size: ' + Math.round(this.fontSize).toString() + 'sp'
  }

  private changeSync(delta: number): void {
    const next = this.syncProgress + delta
    if (next < 0) {
      this.syncProgress = 0
    } else if (next > 1) {
      this.syncProgress = 1
    } else {
      this.syncProgress = next
    }
  }

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(6)
        .radius(3)
        .fill(this.cSurfaceVariant)
      Rect()
        .width((this.syncProgress * 100).toString() + '%')
        .height(6)
        .radius(3)
        .fill(this.cPrimary)
    }
    .width('100%')
    .height(6)
  }

  build() {
    Column() {
      Text('Subtitle Editor')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cText)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(56)
        .backgroundColor(this.cBackground)

      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Rect()
            .width('100%')
            .height(200)
            .radius(22)
            .fill(this.cSurface)
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(this.cText)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(200)
        .shadow({ radius: 8, color: '#2E000000', offsetY: 6 })
        .margin({ bottom: 24 })

        Text(this.fontLabel())
          .fontSize(14)
          .fontColor(this.cText)
          .textAlign(TextAlign.Center)
          .width('100%')

        Slider({ value: this.fontSize, min: 16, max: 48, step: 1 })
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value
          })
          .margin({ top: 12, bottom: 24 })

        Text('Sync Progress')
          .fontSize(14)
          .fontColor(this.cText)
          .textAlign(TextAlign.Center)
          .width('100%')

        this.ProgressBar()
          
        Row() {
          Button('Sync +')
            .height(48)
            .layoutWeight(1)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .backgroundColor(this.cPrimary)
            .borderRadius(14)
            .onClick(() => {
              this.changeSync(0.1)
            })
          Blank().width(12)
          Button('Sync -')
            .height(48)
            .layoutWeight(1)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .backgroundColor(this.cSecondary)
            .borderRadius(14)
            .onClick(() => {
              this.changeSync(-0.1)
            })
        }
        .width('100%')
        .margin({ top: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.cBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
