@Entry
@Component
struct Index {
  build() {
    Column() {
      TopHeader()

      MainContent().layoutWeight(1)

      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room').fontSize(16).fontColor('#757575')
        Text('AeroSense').fontSize(24).fontColor('#1A1A1A').fontWeight(FontWeight.Bold)
      }
      Stack() {
        Text('⚙').fontSize(24).fontColor('#1A1A1A')
      }
      .width(48).height(48)
      .borderRadius(24)
      .backgroundColor('#FAFAFA')
      .onClick(() => {})
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MainContent {
  build() {
    List({ space: 32 }) {
      ListItem() {
        AirQualityCircle()
      }

      ListItem() {
        Column() {
          Row({ space: 16 }) {
            MetricCard({ label: 'Temp', value: '23°C', icon: 'ⓘ', statusColor: '#1A1A1A' }).layoutWeight(1)
            MetricCard({ label: 'Humidity', value: '45%', icon: '✓', statusColor: '#4CAF50' }).layoutWeight(1)
          }
          .width('100%')

          Blank().height(16)

          Row({ space: 16 }) {
            MetricCard({ label: 'PM 2.5', value: '12', icon: '✓', statusColor: '#4CAF50' }).layoutWeight(1)
            MetricCard({ label: 'CO2', value: '850', icon: '⚠', statusColor: '#FF9800' }).layoutWeight(1)
          }
          .width('100%')
        }
      }

      ListItem() {
        StatusBanner()
      }
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 16, bottom: 16 })
  }
}

@Component
struct AirQualityCircle {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Stack() {
      Canvas(this.ctx)
        .width(220).height(220)
        .onReady(() => { this.drawRing() })

      Column() {
        Text('AQI').fontSize(14).fontColor('#757575').fontWeight(FontWeight.Bold).letterSpacing(2)
        Text('42').fontSize(80).fontColor('#1A1A1A').fontWeight(FontWeight.Medium)
        Text('Excellent')
          .fontSize(16)
          .fontColor('#4CAF50')
          .backgroundColor('rgba(76,175,80,0.1)')
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }

  drawRing() {
    const ctx = this.ctx
    const w = this.ctx.width
    const h = this.ctx.height
    const cx = w / 2
    const cy = h / 2
    const r = w / 2
    const startAngle = 135 * Math.PI / 180

    ctx.strokeStyle = '#FAFAFA'
    ctx.lineWidth = 40
    ctx.lineCap = 'round'
    ctx.beginPath()
    ctx.arc(cx, cy, r, startAngle, (135 + 270) * Math.PI / 180)
    ctx.stroke()

    ctx.strokeStyle = '#4CAF50'
    ctx.beginPath()
    ctx.arc(cx, cy, r, startAngle, (135 + 110) * Math.PI / 180)
    ctx.stroke()

    ctx.fillStyle = '#FFFFFF'
    ctx.beginPath()
    ctx.arc(cx + (w / 2) * 0.7, cy + (h / 2) * 0.7, 12, 0, Math.PI * 2)
    ctx.fill()
  }
}

@Component
struct MetricCard {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop icon: string = ''
  @Prop statusColor: string = ''

  build() {
    Column() {
      Row() {
        Text(this.icon).fontSize(20).fontColor(this.statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.value).fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1A1A1A')
        Text(this.label).fontSize(12).fontColor('#757575')
      }
    }
    .height(110)
    .padding(16)
    .borderRadius(24)
    .backgroundColor('#FAFAFA')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Text('⌂').fontSize(24).fontColor('#1A1A1A')
        Blank().width(12)
        Text('Room Analysis').fontSize(16).fontWeight(FontWeight.Bold)
      }
      .alignItems(VerticalAlign.Center)

      Blank().height(12)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor('#757575')
        .lineHeight(22)
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider().color('#EEEEEE')

      Row() {
        ControlIcon({ icon: '☰', desc: 'Menu' })

        Button() {
          Row() {
            Text('↻').fontSize(18).fontColor('#FFFFFF')
            Blank().width(8)
            Text('Refresh Data').fontColor('#FFFFFF')
          }
        }
        .backgroundColor('#1A1A1A')
        .borderRadius(16)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .onClick(() => {})

        ControlIcon({ icon: '+', desc: 'Add Room' })
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct ControlIcon {
  @Prop icon: string = ''
  @Prop desc: string = ''

  build() {
    Stack() {
      Text(this.icon).fontSize(24).fontColor('#1A1A1A')
    }
    .width(48).height(48)
    .borderRadius(24)
    .border({ width: 1, color: '#EEEEEE' })
    .onClick(() => {})
  }
}
