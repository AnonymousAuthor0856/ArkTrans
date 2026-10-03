@Entry
@Component
struct Index {
  build() {
    Column() {
      Column() {
        HeaderSection()

        Blank().height(32)

        BonsaiVisual()

        Blank().height(32)

        StatusRow()

        Blank().height(32)

        ActivityLogSection()
      }
      .width('100%')
      .layoutWeight(1)
      .padding(24)
      .alignItems(HorizontalAlign.Center)

      SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontColor('#7F8C8D')
        .letterSpacing(2)
      Blank().height(8)
      Text('Zen Garden')
        .fontSize(34)
        .fontWeight(FontWeight.Lighter)
        .fontColor('#2C3E50')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem({ icon: '♥', label: 'Health', value: '98%', tint: '#E57373' })
      StatusItem({ icon: '▦', label: 'Age', value: '4 Yrs', tint: '#8D6E63' })
      StatusItem({ icon: '✓', label: 'Water', value: '2 Days', tint: '#64B5F6' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Component
struct StatusItem {
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop tint: string = ''

  build() {
    Column() {
      Stack() {
        Text(this.icon).fontSize(24).fontColor(this.tint)
      }
      .width(50).height(50)
      .borderRadius(25)
      .backgroundColor('#F7F9F9')
      .border({ width: 1, color: '#ECEFF1' })

      Blank().height(8)

      Text(this.value).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#2C3E50')
      Text(this.label).fontSize(10).fontColor('#7F8C8D')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActivityLogSection {
  build() {
    Column() {
      Row() {
        Text('Care Schedule').fontSize(16).fontWeight(FontWeight.Bold)
        Stack() {
          Text('+').fontSize(20).fontColor('#6A8E6A')
        }
        .width(28).height(28)
        .borderRadius(14)
        .backgroundColor('#E8F5E9')
        .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(16)

      CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })
      Blank().height(12)
      CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })
      Blank().height(12)
      CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
    }
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
      Stack() {
      }
      .width(12).height(12)
      .borderRadius(6)
      .backgroundColor(this.isDone ? '#6A8E6A' : '#E0E0E0')

      Blank().width(16)

      Column() {
        Text(this.title).fontSize(14).fontColor(this.isDone ? '#2C3E50' : '#7F8C8D')
        Text(this.subtitle).fontSize(10).fontColor('#9E9E9E')
      }
      .layoutWeight(1)

      if (this.isDone) {
        Text('✓').fontSize(20).fontColor('#6A8E6A')
      }
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .backgroundColor('#FAFAFA')
    .border({ width: 1, color: '#F0F0F0' })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Row() {
      NavIcon({ icon: '⌂', isSelected: true })
      NavIcon({ icon: 'ⓘ', isSelected: false })
      NavIcon({ icon: '⚙', isSelected: false })
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#F5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct NavIcon {
  @Prop icon: string = ''
  @Prop isSelected: boolean = false

  build() {
    Column() {
      Text(this.icon).fontSize(28).fontColor(this.isSelected ? '#6A8E6A' : '#CFD8DC')
      if (this.isSelected) {
        Blank().height(4)
        Stack() {
        }
        .width(4).height(4)
        .borderRadius(2)
        .backgroundColor('#6A8E6A')
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BonsaiVisual {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.ctx)
      .width(220).height(220)
      .onReady(() => { this.drawBonsai() })
  }

  drawBonsai() {
    const ctx = this.ctx
    const w = this.ctx.width
    const h = this.ctx.height
    const potWidth = w * 0.5
    const potHeight = h * 0.15
    const potTop = h * 0.85

    ctx.fillStyle = '#8D6E63'
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)
    ctx.fillStyle = 'rgba(141,110,99,0.8)'
    ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    ctx.strokeStyle = '#5D4037'
    ctx.lineWidth = 25
    ctx.lineCap = 'round'
    ctx.beginPath()
    ctx.moveTo(w * 0.5, potTop)
    ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    ctx.stroke()

    ctx.lineWidth = 15
    ctx.beginPath()
    ctx.moveTo(w * 0.38, h * 0.55)
    ctx.lineTo(w * 0.25, h * 0.45)
    ctx.stroke()

    ctx.fillStyle = '#6A8E6A'
    ctx.beginPath()
    ctx.arc(w * 0.6, h * 0.25, 45, 0, Math.PI * 2)
    ctx.fill()
    ctx.fillStyle = 'rgba(106,142,106,0.8)'
    ctx.beginPath()
    ctx.arc(w * 0.68, h * 0.28, 35, 0, Math.PI * 2)
    ctx.fill()
    ctx.fillStyle = 'rgba(106,142,106,0.9)'
    ctx.beginPath()
    ctx.arc(w * 0.55, h * 0.22, 30, 0, Math.PI * 2)
    ctx.fill()
    ctx.fillStyle = '#6A8E6A'
    ctx.beginPath()
    ctx.arc(w * 0.35, h * 0.5, 35, 0, Math.PI * 2)
    ctx.fill()
    ctx.fillStyle = 'rgba(106,142,106,0.8)'
    ctx.beginPath()
    ctx.arc(w * 0.30, h * 0.45, 25, 0, Math.PI * 2)
    ctx.fill()
    ctx.fillStyle = '#6A8E6A'
    ctx.beginPath()
    ctx.arc(w * 0.22, h * 0.42, 25, 0, Math.PI * 2)
    ctx.fill()
  }
}
