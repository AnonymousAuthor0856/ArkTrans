class VPColors {
  static readonly PRIMARY: string = '#1E3A8A'
  static readonly BACKGROUND: string = '#0F172A'
  static readonly SURFACE: string = '#1E293B'
  static readonly SURFACE_VARIANT: string = '#334155'
  static readonly OUTLINE: string = '#475569'
  static readonly ON_SURFACE: string = '#E2E8F0'
  static readonly CHIP: string = '#E8DEF8'
}

@Entry
@Component
struct VideoPlayerRoot {
  @State private rootWidth: number = 375
  @State private rootHeight: number = 667

  private getScale(): number {
    return Math.min(this.rootWidth / 720.0, this.rootHeight / 1280.0)
  }

  private getPadX(): number {
    return 24.0 * this.getScale()
  }

  private getTitleHeight(): number {
    return 56.0 * this.getScale()
  }

  private getCornerRadius(value: number): number {
    return value * this.getScale()
  }

  private getContentWidth(): number {
    return Math.max(this.rootWidth - 2.0 * this.getPadX(), 0)
  }

  private getLeftProgressWidth(): number {
    return this.getContentWidth() * 0.40
  }

  private getRightProgressWidth(): number {
    return this.getContentWidth() * 0.47
  }

  private lengthToNumber(value: Length): number {
    const parsedValue = Number.parseFloat(value.toString())
    return Number.isNaN(parsedValue) ? 0 : parsedValue
  }

  @Builder
  tonalButton(title: string, scale: number) {
    Text(title)
      .fontSize(18)
      .fontWeight(600)
      .fontColor('#1D192B')
      .textAlign(TextAlign.Center)
      .width(180 * scale)
      .height(96 * scale)
      .backgroundColor(VPColors.CHIP)
      .borderRadius(18 * scale)
  }

  build() {
    Column({ space: 10 }) {
      Text('Video Player')
        .fontSize(18)
        .fontWeight(600)
        .fontColor('#E2E8F0')
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(this.getTitleHeight())
        .padding({ top: 12, bottom: 12 })

      Stack({ alignContent: Alignment.Center }) {
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(500)
          .fontColor('#D5DCE8')
      }
      .width('100%')
      .height(300)
      .margin({ right: 10 })
      .backgroundColor(VPColors.SURFACE_VARIANT)
      .borderRadius(this.getCornerRadius(24))

      Row() {
        Text('Journey through the Skies')
          .fontSize(18)
          .fontWeight(600)
          .fontColor('#E0E8F0')
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      Column({ space: 10 * this.getScale() }) {
        Row({ space: 18 * this.getScale() }) {
          Blank()
            .layoutWeight(1)

          Blank()
            .width(this.getLeftProgressWidth())
            .height(32 * this.getScale())
            .backgroundColor(VPColors.PRIMARY)
            .borderRadius(16 * this.getScale())

          Blank()
            .width(6 * this.getScale())
            .height(72 * this.getScale())
            .backgroundColor(VPColors.PRIMARY)
            .borderRadius(3 * this.getScale())

          Stack({ alignContent: Alignment.End }) {
            Blank()
              .width(this.getRightProgressWidth())
              .height(32 * this.getScale())
              .backgroundColor('#475569')
              .borderRadius(16 * this.getScale())

            Blank()
              .width(12 * this.getScale())
              .height(12 * this.getScale())
              .backgroundColor(VPColors.PRIMARY)
              .borderRadius(6 * this.getScale())
              .margin({ right: 10 * this.getScale() })
          }
          .width(this.getRightProgressWidth())
          .height(32 * this.getScale())

          Blank()
            .layoutWeight(1)
        }
        .width('100%')
        .height(72 * this.getScale())

        Row() {
          Text('1:35')
            .fontSize(12)
            .fontWeight(500)
            .fontColor('#A3AAB5')
            .padding({ left: 10 })

          Blank()
            .layoutWeight(1)

          Text('4:00')
            .fontSize(12)
            .fontWeight(500)
            .fontColor('#A3AAB5')
            .padding({ right: 10 })
        }
        .width('100%')
      }
      .width('100%')
      .padding({
        left: this.getPadX(),
        right: this.getPadX(),
        top: 8 * this.getScale(),
        bottom: 6 * this.getScale()
      })

      Row({ space: 24 * this.getScale() }) {
        this.tonalButton('−10s', this.getScale())

        Stack({ alignContent: Alignment.Center }) {
          Blank()
            .width(120 * this.getScale())
            .height(120 * this.getScale())
            .backgroundColor(VPColors.PRIMARY)
            .borderRadius(60 * this.getScale())

          Text('▶')
            .fontSize(40 * this.getScale())
            .fontWeight(700)
            .fontColor('#FFFFFF')
            .translate({ x: 2 * this.getScale() })
        }
        .width(120 * this.getScale())
        .height(120 * this.getScale())

        this.tonalButton('+30s', this.getScale())
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 10 * this.getScale(), bottom: 10 })

      Text('Fullscreen')
        .fontSize(18)
        .fontWeight(600)
        .fontColor('#47434E')
        .textAlign(TextAlign.Center)
        .width(220 * this.getScale())
        .height(64 * this.getScale())
        .border({
          width: 1,
          color: VPColors.OUTLINE
        })
        .borderRadius(12 * this.getScale())
        .margin({ top: 12 * this.getScale() })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(VPColors.BACKGROUND)
    .onAreaChange((_oldValue: Area, newValue: Area) => {
      const width = this.lengthToNumber(newValue.width)
      const height = this.lengthToNumber(newValue.height)
      if (width > 0) {
        this.rootWidth = width
      }
      if (height > 0) {
        this.rootHeight = height
      }
    })
  }
}