const PRIMARY: string = '#1E3A8A'
const BACKGROUND: string = '#0F172A'
const SURFACE_VARIANT: string = '#334155'
const OUTLINE: string = '#475569'
const ON_SURFACE: string = '#E2E8F0'
const CHIP: string = '#E8DEF8'
const MUTED: string = '#A3AAB5'

@Entry
@Component
struct VideoPlayerRoot {
  @State private isPlaying: boolean = false
  @State private progress: number = 0.65

  private seek(seconds: number): void {
    const delta: number = seconds / 240
    this.progress = Math.max(0, Math.min(1, this.progress + delta))
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column({ space: 0 }) {
          Text('Video Player')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_SURFACE)
            .width('100%')
            .height(104)
            .textAlign(TextAlign.Center)
            .padding({ top: 32 })

          Stack({ alignContent: Alignment.Center }) {
            Text('Video Surface')
              .fontSize(32)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_SURFACE)
          }
          .width('100%')
          .height('45%')
          .backgroundColor(SURFACE_VARIANT)
          .borderRadius(24)

          Text('Journey through the Skies')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_SURFACE)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 40, top: 40, bottom: 28 })

          Column({ space: 16 }) {
            Row({ space: 18 }) {
              Blank()
                .layoutWeight(1)

            Blank()
              .width('40%')
              .height(32)
              .backgroundColor(PRIMARY)
              .borderRadius(16)

              Rect()
                .width(6)
                .height(72)
                .backgroundColor(PRIMARY)
                .borderRadius(3)

              Stack({ alignContent: Alignment.End }) {
              Rect()
                .width('100%')
                .height(32)
                .backgroundColor(OUTLINE)
                .borderRadius(16)

                Circle()
                  .width(12)
                  .height(12)
                  .backgroundColor(PRIMARY)
                  .margin({ right: 10 })
              }
              .width('47%')
              .height(32)

              Blank()
                .layoutWeight(1)
            }
            .width('100%')
            .height(72)

            Row() {
              Text('1:35')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor(MUTED)
                .margin({ left: 10 })

              Blank()
                .layoutWeight(1)

              Text('4:00')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor(MUTED)
                .margin({ right: 10 })
            }
            .width('100%')
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 8, bottom: 6 })

          Row({ space: 24 }) {
            Button('-10s')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1D192B')
              .backgroundColor(CHIP)
              .width(188)
              .height(100)
              .borderRadius(18)
              .onClick(() => {
                this.seek(-10)
              })

            Button(this.isPlaying ? '❚❚' : '▶')
              .fontSize(this.isPlaying ? 28 : 42)
              .fontColor('#FFFFFF')
              .backgroundColor(PRIMARY)
              .width(126)
              .height(126)
              .borderRadius(63)
              .onClick(() => {
                this.isPlaying = !this.isPlaying
              })

            Button('+30s')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1D192B')
              .backgroundColor(CHIP)
              .width(188)
              .height(100)
              .borderRadius(18)
              .onClick(() => {
                this.seek(30)
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: 10, bottom: 10 })

          Button('Fullscreen')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor('#47434E')
            .backgroundColor(Color.Transparent)
            .width(230)
            .height(68)
            .borderColor(OUTLINE)
            .borderWidth(2)
            .borderRadius(12)
            .margin({ top: 12 })
            .onClick(() => {
              this.isPlaying = false
            })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BACKGROUND)
    }
    .width('100%')
    .height('100%')
  }
}
