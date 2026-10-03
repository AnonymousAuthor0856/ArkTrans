@Entry
@Component
struct ClimateControllerApp {
  build() {
    Stack() {
      ClimateControllerView()
    }
    .backgroundColor('#FFFFFFFF')
    .width('100%')
    .height('100%')
  }
}

@Component
struct ClimateControllerView {
  build() {
    Column() {
      HeaderSection()
        .padding({ top: 16 })

      Row()
        .height(40)

      TemperatureDialSection()

      Row()
        .height(40)

      ControlGridSection()

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor('#FFFFFFFF')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Button() {
        // No op
      } label: {
        Image($r('sys.media.ohos_ic_menu'))
          .width(28)
          .height(28)
          .fillColor('#FF1C1C1E')
      }
      .backgroundColor(Color.Transparent)

      Blank()
        .layoutWeight(1)

      Column() {
        Text('LIVING ROOM')
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF8E8E93')
          .letterSpacing(2)
        Text('Connected')
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor('#FF007AFF')
      }

      Blank()
        .layoutWeight(1)

      Button() {
        // No op
      } label: {
        Image($r('sys.media.ohos_ic_settings'))
          .width(28)
          .height(28)
          .fillColor('#FF1C1C1E')
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  private adjustTemp(delta: number): void {
    let newTemp = this.targetTemp + delta
    let clamped = Math.min(Math.max(newTemp, 16.0), 30.0)
    this.targetTemp = Math.round(clamped * 10) / 10.0
  }

  build() {
    Column() {
      Stack() {
        // Background Circle
        Circle()
          .width(240)
          .height(240)
          .fill(Color.Transparent)
          .stroke('#FFF2F2F7')
          .strokeWidth(40)

        // Animated Arc Indicator and Knob
        TemperatureDial({
          progress: (this.targetTemp - 16.0) / (30.0 - 16.0),
          isActive: this.isActive
        })
          .width(240)
          .height(240)

        // Center Text
        Column() {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? '#FF1C1C1E' : '#FF8E8E93')
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF8E8E93')
        }
      }
      .width(280)
      .height(280)

      Row()
        .height(32)

      Row({ space: 32 }) {
        RoundControlButton({
          iconName: 'down',
          action: () => { this.adjustTemp(-0.5) },
          enabled: this.isActive
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor('#FF1C1C1E')
          .onChange((isOn: boolean) => {
            this.isActive = isOn
          })

        RoundControlButton({
          iconName: 'up',
          action: () => { this.adjustTemp(0.5) },
          enabled: this.isActive
        })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TemperatureDial {
  @Prop progress: number = 0.0
  @Prop isActive: boolean = true
  @State animatedProgress: number = 0.0

  aboutToAppear(): void {
    this.animatedProgress = this.progress
  }

  build() {
    Stack() {
      // Arc using Canvas
      Canvas(this.renderArc)
        .width('100%')
        .height('100%')

      // Knob Indicator
      this.knobView()
    }
    .width(240)
    .height(240)
  }

  private renderArc(context: CanvasRenderingContext2D): void {
    const size = 240
    const strokeWidth = 40
    const startAngleDegrees = 135
    const sweepAngleDegrees = 270 * this.animatedProgress
    const endAngleDegrees = startAngleDegrees + sweepAngleDegrees

    const radius = (size - strokeWidth) / 2
    const centerX = size / 2
    const centerY = size / 2

    const startRad = (startAngleDegrees - 90) * Math.PI / 180
    const endRad = (endAngleDegrees - 90) * Math.PI / 180

    context.beginPath()
    context.arc(centerX, centerY, radius, startRad, endRad, false)
    context.strokeStyle = this.isActive ? '#FF007AFF' : '#FF8E8E93'
    context.lineWidth = strokeWidth
    context.lineCap = 'round'
    context.stroke()
  }

  @Builder
  private knobView() {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill('#FFFFFFFF')
      Circle()
        .width(20)
        .height(20)
        .fill(this.isActive ? '#FF007AFF' : '#FF8E8E93')
    }
    .position(this.calculateKnobPosition())
  }

  private calculateKnobPosition(): Position {
    const size = 240
    const strokeWidth = 40
    const radius = (size - strokeWidth) / 2
    const centerX = size / 2
    const centerY = size / 2

    const endAngleDegrees = 135 + 270 * this.animatedProgress
    const angleInRadians = (endAngleDegrees - 90) * Math.PI / 180

    const knobX = centerX + radius * Math.cos(angleInRadians)
    const knobY = centerY + radius * Math.sin(angleInRadians)

    return { x: knobX, y: knobY }
  }
}

@Component
struct RoundControlButton {
  @Prop iconName: string = 'down'
  @Prop action: () => void = () => {}
  @Prop enabled: boolean = true

  build() {
    Button() {
      this.action()
    } label: {
      Image(this.iconName === 'down' ? $r('sys.media.ohos_ic_arrow_down') : $r('sys.media.ohos_ic_arrow_up'))
        .width(28)
        .height(28)
        .fillColor(this.enabled ? '#FF1C1C1E' : '#FFD1D1D6')
    }
    .width(56)
    .height(56)
    .backgroundColor(this.enabled ? '#FFF2F2F7' : '#FFF9F9F9')
    .borderRadius(28)
    .border({
      width: this.enabled ? 0 : 1,
      color: this.enabled ? Color.Transparent : '#FFEEEEEE'
    })
    .enabled(this.enabled)
  }
}

@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF8E8E93')
        .padding({ bottom: 16 })

      Row({ space: 16 }) {
        QuickActionCard({
          iconName: 'refresh',
          label: 'Fan Speed',
          status: 'Auto'
        })
        QuickActionCard({
          iconName: 'heart',
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
      }

      Row()
        .height(16)

      Row({ space: 16 }) {
        QuickActionCard({
          iconName: 'info',
          label: 'Timer',
          status: 'Set 2h'
        })
        QuickActionCard({
          iconName: 'home',
          label: 'Away',
          status: 'Off'
        })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct QuickActionCard {
  @Prop iconName: string = 'refresh'
  @Prop label: string = ''
  @Prop status: string = ''
  @Prop isActive: boolean = false

  build() {
    Column() {
      Image(this.getIconResource())
        .width(24)
        .height(24)
        .fillColor(this.isActive ? '#FFFFFFFF' : '#FF1C1C1E')
        .padding({ bottom: 8 })

      Blank()
        .layoutWeight(1)

      Column() {
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive ? '#FFFFFFFF' : '#FF1C1C1E')
        Text(this.status)
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor('#FF8E8E93')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(100)
    .layoutWeight(1)
    .backgroundColor(this.isActive ? '#FF1C1C1E' : '#FFF2F2F7')
    .borderRadius(20)
  }

  private getIconResource(): Resource {
    if (this.iconName === 'refresh') {
      return $r('sys.media.ohos_ic_refresh')
    } else if (this.iconName === 'heart') {
      return $r('sys.media.ohos_ic_favorite')
    } else if (this.iconName === 'info') {
      return $r('sys.media.ohos_ic_info')
    } else {
      return $r('sys.media.ohos_ic_home')
    }
  }
}