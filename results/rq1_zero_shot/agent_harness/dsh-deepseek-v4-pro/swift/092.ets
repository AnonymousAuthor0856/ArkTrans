// Translated from 092.swift (Zen Bonsai App)

@Entry
@Component
struct Index {
  build() {
    ZenBonsaiAppView()
  }
}

@Component
struct ZenBonsaiAppView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          HeaderSection()
            .padding({ top: 24 })

          Blank().height(32)

          BonsaiVisual()
            .width(220)
            .height(220)

          Blank().height(32)

          StatusRow()

          Blank().height(32)

          ActivityLogSection()
            .padding({ bottom: 24 })
        }
        .padding({ left: 24, right: 24, bottom: 80 })
        .backgroundColor('#FFFFFF')
      }
      .backgroundColor('#FFFFFF')

      SimpleBottomNav()
        .backgroundColor('#FFFFFF')
    }
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#7F8C8D')
        .letterSpacing(2)
      Blank().height(8)
      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Lighter)
        .fontColor('#2C3E50')
    }
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem({ icon: '♥', label: 'Health', value: '98%', tint: '#E57373' })
      StatusItem({ icon: '📅', label: 'Age', value: '4 Yrs', tint: '#8D6E63' })
      StatusItem({ icon: '✅', label: 'Water', value: '2 Days', tint: '#64B5F6' })
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
  }
}

@Component
struct StatusItem {
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop tint: string = '#000000'

  build() {
    Column() {
      Stack() {
        Circle()
          .fill('#F7F9F9')
          .stroke('#ECEFF1')
          .strokeWidth(1)
          .width(50)
          .height(50)
        Text(this.icon)
          .fontSize(24)
          .fontColor(this.tint)
          .width(24)
          .height(24)
      }
      Blank().height(8)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2C3E50')
      Text(this.label)
        .fontSize(11)
        .fontColor('#7F8C8D')
    }
  }
}

@Component
struct ActivityLogSection {
  build() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Semibold)
          .fontColor('#2C3E50')
        Blank()
        Text('+')
          .fontSize(20)
          .fontColor('#6A8E6A')
          .width(28)
          .height(28)
          .textAlign(TextAlign.Center)
          .backgroundColor('#E8F5E9')
          .borderRadius(14)
          .onClick(() => {})
      }
      .width('100%')

      Blank().height(16)

      CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })
      Blank().height(12)
      CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })
      Blank().height(12)
      CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct CareLogItem {
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop isDone: boolean = false

  build() {
    Row() {
      Circle()
        .fill(this.isDone ? '#6A8E6A' : '#E0E0E0')
        .width(12)
        .height(12)
      Blank().width(16)
      Column() {
        Text(this.title)
          .fontSize(14)
          .fontColor(this.isDone ? '#2C3E50' : '#7F8C8D')
        Text(this.subtitle)
          .fontSize(11)
          .fontColor('#9E9E9E')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor('#6A8E6A')
          .width(20)
          .height(20)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#F0F0F0', radius: 12 })
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Column() {
      Divider().color('#F5F5F5')
      Row() {
        NavIcon({ icon: '⌂', isSelected: true })
          .layoutWeight(1)
        NavIcon({ icon: 'ⓘ', isSelected: false })
          .layoutWeight(1)
        NavIcon({ icon: '⚙', isSelected: false })
          .layoutWeight(1)
      }
      .width('100%')
      .height(80)
      .backgroundColor('#FFFFFF')
    }
  }
}

@Component
struct NavIcon {
  @Prop icon: string = ''
  @Prop isSelected: boolean = false

  build() {
    Column() {
      Text(this.icon)
        .fontSize(28)
        .fontColor(this.isSelected ? '#6A8E6A' : '#CFD8DC')
        .width(28)
        .height(28)
      if (this.isSelected) {
        Blank().height(4)
        Circle()
          .fill('#6A8E6A')
          .width(4)
          .height(4)
      }
    }
  }
}

@Component
struct BonsaiVisual {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(220)
      .height(220)
      .onReady(() => {
        const w = 220
        const h = 220
        const potWidth = w * 0.5
        const potHeight = h * 0.15
        const potTop = h * 0.85

        this.context.fillStyle = '#8D6E63'
        this.context.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)
        this.context.fillStyle = '#CC8D6E63'
        this.context.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

        this.context.strokeStyle = '#5D4037'
        this.context.lineWidth = 25
        this.context.lineCap = 'round'
        this.context.beginPath()
        this.context.moveTo(w * 0.5, potTop)
        this.context.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
        this.context.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
        this.context.stroke()

        this.context.lineWidth = 15
        this.context.beginPath()
        this.context.moveTo(w * 0.38, h * 0.55)
        this.context.lineTo(w * 0.25, h * 0.45)
        this.context.stroke()

        this.context.fillStyle = '#6A8E6A'
        this.context.beginPath()
        this.context.ellipse(w * 0.6, h * 0.25, 45, 45, 0, 0, Math.PI * 2)
        this.context.fill()
        this.context.fillStyle = '#CC6A8E6A'
        this.context.beginPath()
        this.context.ellipse(w * 0.68, h * 0.28, 35, 35, 0, 0, Math.PI * 2)
        this.context.fill()
        this.context.fillStyle = '#E66A8E6A'
        this.context.beginPath()
        this.context.ellipse(w * 0.55, h * 0.22, 30, 30, 0, 0, Math.PI * 2)
        this.context.fill()

        this.context.fillStyle = '#6A8E6A'
        this.context.beginPath()
        this.context.ellipse(w * 0.35, h * 0.5, 35, 35, 0, 0, Math.PI * 2)
        this.context.fill()
        this.context.fillStyle = '#CC6A8E6A'
        this.context.beginPath()
        this.context.ellipse(w * 0.30, h * 0.45, 25, 25, 0, 0, Math.PI * 2)
        this.context.fill()

        this.context.fillStyle = '#6A8E6A'
        this.context.beginPath()
        this.context.ellipse(w * 0.22, h * 0.42, 25, 25, 0, 0, Math.PI * 2)
        this.context.fill()
      })
  }
}
