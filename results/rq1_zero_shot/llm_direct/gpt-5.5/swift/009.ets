import { window } from '@kit.ArkUI';

@Entry
@Component
struct VideoPlayerRoot {
  @State sw: number = 720
  @State sh: number = 1280

  readonly VIDEO_SURFACE_RATIO: number = 0.50

  readonly primary: ResourceColor = '#1E3A8A'
  readonly background: ResourceColor = '#0F172A'
  readonly surface: ResourceColor = '#1E293B'
  readonly surfaceVariant: ResourceColor = '#334155'
  readonly outline: ResourceColor = '#475569'
  readonly onSurface: ResourceColor = '#E2E8F0'
  readonly chip: ResourceColor = '#E8DEF8'

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true)
      win.setWindowSystemBarEnable([])
    }).catch(() => {
    })
  }

  getScale(): number {
    return Math.min(this.sw / 720.0, this.sh / 1280.0)
  }

  getPadX(): number {
    return 24.0 * this.getScale()
  }

  getTitleH(): number {
    return 56.0 * this.getScale()
  }

  getVideoH(): number {
    return Math.max(this.sh * this.VIDEO_SURFACE_RATIO, 360 * this.getScale())
  }

  getContentW(): number {
    return this.sw - 2 * this.getPadX()
  }

  getLeftW(): number {
    return this.getContentW() * 0.40
  }

  getRightW(): number {
    return this.getContentW() * 0.47
  }

  @Builder
  tonalButton(title: string, color: ResourceColor) {
    Text(title)
      .fontSize(18 * this.getScale())
      .fontWeight(FontWeight.Medium)
      .fontColor(color)
      .width(180 * this.getScale())
      .height(96 * this.getScale())
      .textAlign(TextAlign.Center)
      .backgroundColor(this.chip)
      .borderRadius(18 * this.getScale())
  }

  build() {
    Column({ space: 10 }) {
      Text('Video Player')
        .fontSize(18 * this.getScale())
        .fontWeight(FontWeight.Medium)
        .fontColor('#E2E8F0')
        .height(this.getTitleH())
        .padding({ top: 12, bottom: 12 })

      Stack({ alignContent: Alignment.Center }) {
        Text('Video Surface')
          .fontSize(16 * this.getScale())
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(226,232,240,0.9)')
      }
      .width('100%')
      .height(300)
      .backgroundColor(this.surfaceVariant)
      .borderRadius(24 * this.getScale())
      .margin({ right: 10 })

      Text('Journey through the Skies')
        .fontSize(18 * this.getScale())
        .fontWeight(FontWeight.Medium)
        .fontColor('#E0E8F0')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      Column({ space: 10 * this.getScale() }) {
        Row({ space: 18 * this.getScale() }) {
          Blank()
            .layoutWeight(1)

          Blank()
            .width(this.getLeftW())
            .height(32 * this.getScale())
            .backgroundColor(this.primary)
            .borderRadius(16 * this.getScale())

          Blank()
            .width(6 * this.getScale())
            .height(72 * this.getScale())
            .backgroundColor(this.primary)
            .borderRadius(3 * this.getScale())

          Stack({ alignContent: Alignment.End }) {
            Blank()
              .width(this.getRightW())
              .height(32 * this.getScale())
              .backgroundColor('#475569')
              .borderRadius(16 * this.getScale())

            Blank()
              .width(12 * this.getScale())
              .height(12 * this.getScale())
              .backgroundColor(this.primary)
              .borderRadius(6 * this.getScale())
              .margin({ right: 10 * this.getScale() })
          }
          .width(this.getRightW())
          .height(32 * this.getScale())

          Blank()
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('1:35')
            .fontSize(12 * this.getScale())
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .padding({ left: 10 })

          Blank()
            .layoutWeight(1)

          Text('4:00')
            .fontSize(12 * this.getScale())
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .padding({ right: 10 })
        }
        .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({
        left: this.getPadX(),
        right: this.getPadX(),
        top: 8 * this.getScale(),
        bottom: 6 * this.getScale()
      })

      Row({ space: 24 * this.getScale() }) {
        this.tonalButton('−10s', Color.Black)

        Stack({ alignContent: Alignment.Center }) {
          Blank()
            .width(120 * this.getScale())
            .height(120 * this.getScale())
            .backgroundColor(this.primary)
            .borderRadius(60 * this.getScale())

          Text('▶')
            .fontSize(40 * this.getScale())
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .translate({ x: 3 * this.getScale() })
        }
        .width(120 * this.getScale())
        .height(120 * this.getScale())

        this.tonalButton('+30s', '#1D192B')
      }
      .padding({ top: 10 * this.getScale(), bottom: 10 })

      Button({ type: ButtonType.Normal, stateEffect: false }) {
        Text('Fullscreen')
          .fontSize(18 * this.getScale())
          .fontWeight(FontWeight.Medium)
          .fontColor('#47434E')
          .width(220 * this.getScale())
          .height(64 * this.getScale())
          .textAlign(TextAlign.Center)
      }
      .width(220 * this.getScale())
      .height(64 * this.getScale())
      .backgroundColor(Color.Transparent)
      .border({
        width: 1,
        color: this.outline,
        radius: 12 * this.getScale()
      })
      .margin({ top: 12 * this.getScale() })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .onAreaChange((oldValue, newValue) => {
      this.sw = Number(newValue.width)
      this.sh = Number(newValue.height)
    })
  }
}