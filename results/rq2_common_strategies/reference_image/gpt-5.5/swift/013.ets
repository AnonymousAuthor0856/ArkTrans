class RMColors {
  static readonly primary: string = '#EF476F'
  static readonly secondary: string = '#FFD166'
  static readonly tertiary: string = '#06D6A0'
  static readonly background: string = '#FFFCF2'
  static readonly surface: string = '#FFF8E1'
  static readonly outline: string = '#BDBDBD'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1F1F1F'
  static readonly onSurface: string = '#1F1F1F'
}

@Entry
@Component
struct RetroMusicPlayerRoot {
  @State private scaleValue: number = 1
  @State private knobX: number = 140
  @State private knobY: number = 140
  @State private isDragging: boolean = false

  private dragStartX: number = 140
  private dragStartY: number = 140

  private s(value: number): number {
    return value * this.scaleValue
  }

  private updateKnobPosition(x: number, y: number): void {
    const centerX: number = this.s(140)
    const centerY: number = this.s(140)
    const radius: number = this.s(120)

    const dx: number = x - centerX
    const dy: number = y - centerY
    const distance: number = Math.sqrt(dx * dx + dy * dy)

    if (distance <= radius) {
      this.knobX = x
      this.knobY = y
    } else {
      const angle: number = Math.atan2(dy, dx)
      this.knobX = centerX + Math.cos(angle) * radius
      this.knobY = centerY + Math.sin(angle) * radius
    }
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height(this.s(80))
          .fill(RMColors.background)

        Text('Retro Music Player')
          .fontSize(this.s(34))
          .fontWeight(FontWeight.Bold)
          .fontColor(RMColors.onSurface)
      }
      .width('100%')
      .height(this.s(80))

      Blank()

      Column({ space: this.s(32) }) {
        Stack({ alignContent: Alignment.TopStart }) {
          Rect()
            .width(this.s(280))
            .height(this.s(280))
            .radius(this.s(16))
            .fill(RMColors.surface)
            .stroke(RMColors.outline)
            .strokeWidth(this.s(3))

          Circle()
            .width(this.s(240))
            .height(this.s(240))
            .fill(Color.Transparent)
            .stroke(RMColors.secondary)
            .strokeWidth(this.s(8))
            .position({ x: this.s(20), y: this.s(20) })

          Circle()
            .width(this.s(24))
            .height(this.s(24))
            .fill(RMColors.primary)
            .position({
              x: this.knobX - this.s(12),
              y: this.knobY - this.s(12)
            })
            .gesture(
              PanGesture({
                fingers: 1,
                direction: PanDirection.All,
                distance: 0
              })
                .onActionStart(() => {
                  this.isDragging = true
                  this.dragStartX = this.knobX
                  this.dragStartY = this.knobY
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.updateKnobPosition(
                    this.dragStartX + event.offsetX,
                    this.dragStartY + event.offsetY
                  )
                })
                .onActionEnd(() => {
                  this.isDragging = false
                })
            )
        }
        .width(this.s(280))
        .height(this.s(280))

        Text('Track: Summer Nights')
          .fontSize(this.s(22))
          .fontWeight(FontWeight.Medium)
          .fontColor(RMColors.onSurface)

        Row({ space: this.s(32) }) {
          Button('Play', { type: ButtonType.Normal, stateEffect: true })
            .width(this.s(140))
            .height(this.s(56))
            .borderRadius(this.s(12))
            .backgroundColor(RMColors.primary)
            .fontSize(this.s(22))
            .fontWeight(FontWeight.Medium)
            .fontColor(RMColors.onPrimary)

          Button('Pause', { type: ButtonType.Normal, stateEffect: true })
            .width(this.s(140))
            .height(this.s(56))
            .borderRadius(this.s(12))
            .backgroundColor(RMColors.secondary)
            .fontSize(this.s(22))
            .fontWeight(FontWeight.Medium)
            .fontColor(RMColors.onSecondary)
        }

        Text('Knob X:268 Y:303')
          .fontSize(this.s(16))
          .fontWeight(FontWeight.Medium)
          .fontColor(RMColors.tertiary)
      }
      .alignItems(HorizontalAlign.Center)
      .padding({
        left: this.s(32),
        right: this.s(32)
      })

      Blank()

      Rect()
        .width('100%')
        .height(this.s(60))
        .fill(Color.Transparent)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RMColors.background)
    .onAreaChange((oldArea: Area, newArea: Area) => {
      const width: number = Number(newArea.width)
      const height: number = Number(newArea.height)

      if (width > 0 && height > 0) {
        const newScale: number = Math.max(width / 360.0, height / 640.0)

        if (Math.abs(newScale - this.scaleValue) > 0.001) {
          this.scaleValue = newScale
          this.knobX = 140 * newScale
          this.knobY = 140 * newScale
          this.dragStartX = this.knobX
          this.dragStartY = this.knobY
        }
      }
    })
  }
}