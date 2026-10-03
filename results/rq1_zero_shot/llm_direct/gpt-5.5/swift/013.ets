class RMColorTokens {
  readonly primary: ResourceColor = '#EF476F'
  readonly secondary: ResourceColor = '#FFD166'
  readonly tertiary: ResourceColor = '#06D6A0'
  readonly background: ResourceColor = '#FFFCF2'
  readonly surface: ResourceColor = '#FFF8E1'
  readonly surfaceVariant: ResourceColor = '#FCE7E7'
  readonly outline: ResourceColor = '#BDBDBD'
  readonly success: ResourceColor = '#06D6A0'
  readonly warning: ResourceColor = '#FFA600'
  readonly error: ResourceColor = '#D62828'
  readonly onPrimary: ResourceColor = '#FFFFFF'
  readonly onSecondary: ResourceColor = '#1F1F1F'
  readonly onTertiary: ResourceColor = '#1F1F1F'
  readonly onBackground: ResourceColor = '#1F1F1F'
  readonly onSurface: ResourceColor = '#1F1F1F'
}

class RM {
  static readonly C: RMColorTokens = new RMColorTokens()
}

@Entry
@Component
struct RetroMusicPlayerRoot {
  @State private knobX: number = 140
  @State private knobY: number = 140
  @State private isDragging: boolean = false
  @State private scale: number = 1

  private updateKnob(x: number, y: number): void {
    const centerX: number = 140 * this.scale
    const centerY: number = 140 * this.scale
    const radius: number = 120 * this.scale

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

  private resetKnobToCenter(): void {
    this.knobX = 140 * this.scale
    this.knobY = 140 * this.scale
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('Retro Music Player')
          .fontSize(34 * this.scale)
          .fontWeight(FontWeight.Bold)
          .fontColor(RM.C.onSurface)
      }
      .width('100%')
      .height(80 * this.scale)
      .backgroundColor(RM.C.background)

      Blank()
        .layoutWeight(1)

      Column({ space: 32 * this.scale }) {
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(RM.C.surface)
            .border({
              width: 3 * this.scale,
              color: RM.C.outline,
              radius: 16 * this.scale
            })

          Circle()
            .width(240 * this.scale)
            .height(240 * this.scale)
            .fill(Color.Transparent)
            .stroke(RM.C.secondary)
            .strokeWidth(8 * this.scale)

          Circle()
            .width(24 * this.scale)
            .height(24 * this.scale)
            .fill(RM.C.primary)
            .position({
              x: this.knobX - 12 * this.scale,
              y: this.knobY - 12 * this.scale
            })
        }
        .width(280 * this.scale)
        .height(280 * this.scale)
        .onTouch((event: TouchEvent) => {
          if (event.touches.length <= 0) {
            return
          }

          if (event.type === TouchType.Down || event.type === TouchType.Move) {
            this.isDragging = true
            this.updateKnob(event.touches[0].x, event.touches[0].y)
          } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
            this.isDragging = false
          }
        })

        Text('Track: Summer Nights')
          .fontSize(22 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM.C.onSurface)

        Row({ space: 32 * this.scale }) {
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Play')
              .fontSize(22 * this.scale)
              .fontWeight(FontWeight.Medium)
              .fontColor(RM.C.onPrimary)
          }
          .width(140 * this.scale)
          .height(56 * this.scale)
          .backgroundColor(RM.C.primary)
          .borderRadius(12 * this.scale)
          .onClick(() => {
          })

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Pause')
              .fontSize(22 * this.scale)
              .fontWeight(FontWeight.Medium)
              .fontColor(RM.C.onSecondary)
          }
          .width(140 * this.scale)
          .height(56 * this.scale)
          .backgroundColor(RM.C.secondary)
          .borderRadius(12 * this.scale)
          .onClick(() => {
          })
        }

        Text('Knob X:268 Y:303')
          .fontSize(16 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM.C.tertiary)
      }
      .padding({
        left: 32 * this.scale,
        right: 32 * this.scale
      })

      Blank()
        .layoutWeight(1)

      Row()
        .width('100%')
        .height(60 * this.scale)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RM.C.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .onAreaChange((_oldArea: Area, newArea: Area) => {
      const width: number = parseFloat(String(newArea.width))
      const height: number = parseFloat(String(newArea.height))

      if (width > 0 && height > 0) {
        const nextScale: number = Math.max(width / 360.0, height / 640.0)

        if (Math.abs(nextScale - this.scale) > 0.001) {
          this.scale = nextScale
          this.resetKnobToCenter()
        }
      }
    })
  }
}