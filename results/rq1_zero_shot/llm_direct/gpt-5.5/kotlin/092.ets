const ZenGreen: string = '#6A8E6A'
const ZenGreenLight: string = '#E8F5E9'
const ZenBrown: string = '#8D6E63'
const ZenTextPrimary: string = '#2C3E50'
const ZenTextSecondary: string = '#7F8C8D'
const ZenWhite: string = '#FFFFFF'

@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        HeaderSection()

        Blank()
          .height(32)

        BonsaiVisual()
          .width(220)
          .height(220)

        Blank()
          .height(32)

        StatusRow()

        Blank()
          .height(32)

        ActivityLogSection()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 104 })
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(ZenWhite)

      SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenWhite)
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontColor(ZenTextSecondary)
        .letterSpacing(2)
        .fontWeight(FontWeight.Medium)

      Blank()
        .height(8)

      Text('Zen Garden')
        .fontSize(36)
        .fontColor(ZenTextPrimary)
        .fontWeight(FontWeight.Lighter)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem({ icon: '♥', label: 'Health', value: '98%', tint: '#E57373' })
      StatusItem({ icon: '▣', label: 'Age', value: '4 Yrs', tint: ZenBrown })
      StatusItem({ icon: '✓', label: 'Water', value: '2 Days', tint: '#64B5F6' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Component
struct StatusItem {
  @Prop icon: string
  @Prop label: string
  @Prop value: string
  @Prop tint: string

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.icon)
          .fontSize(24)
          .fontColor(this.tint)
          .fontWeight(FontWeight.Bold)
      }
      .width(50)
      .height(50)
      .backgroundColor('#F7F9F9')
      .border({ width: 1, color: '#ECEFF1' })
      .borderRadius(25)

      Blank()
        .height(8)

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZenTextPrimary)

      Text(this.label)
        .fontSize(11)
        .fontColor(ZenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActivityLogSection {
  build() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(ZenTextPrimary)

        Stack({ alignContent: Alignment.Center }) {
          Text('+')
            .fontSize(24)
            .fontColor(ZenGreen)
            .fontWeight(FontWeight.Medium)
        }
        .width(28)
        .height(28)
        .backgroundColor(ZenGreenLight)
        .borderRadius(14)
        .onClick(() => {
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(16)

      CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })

      Blank()
        .height(12)

      CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })

      Blank()
        .height(12)

      CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
    }
    .width('100%')
  }
}

@Component
struct CareLogItem {
  @Prop title: string
  @Prop subtitle: string
  @Prop isDone: boolean

  build() {
    Row() {
      Circle()
        .width(12)
        .height(12)
        .fill(this.isDone ? ZenGreen : '#E0E0E0')

      Blank()
        .width(16)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontColor(this.isDone ? ZenTextPrimary : ZenTextSecondary)

        Text(this.subtitle)
          .fontSize(11)
          .fontColor('#9E9E9E')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      if (this.isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor(ZenGreen)
          .fontWeight(FontWeight.Bold)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .border({ width: 1, color: '#F0F0F0' })
    .borderRadius(12)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Row() {
      NavIcon({ icon: '⌂', isSelected: true })
      NavIcon({ icon: 'i', isSelected: false })
      NavIcon({ icon: '⚙', isSelected: false })
    }
    .width('100%')
    .height(80)
    .backgroundColor(ZenWhite)
    .border({ width: 1, color: '#F5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct NavIcon {
  @Prop icon: string
  @Prop isSelected: boolean

  build() {
    Column() {
      Text(this.icon)
        .fontSize(28)
        .fontColor(this.isSelected ? ZenGreen : '#CFD8DC')
        .fontWeight(FontWeight.Bold)

      if (this.isSelected) {
        Blank()
          .height(4)

        Circle()
          .width(4)
          .height(4)
          .fill(ZenGreen)
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BonsaiVisual {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawCircle(ctx: CanvasRenderingContext2D, color: string, alpha: number, radius: number, x: number, y: number): void {
    ctx.globalAlpha = alpha
    ctx.beginPath()
    ctx.fillStyle = color
    ctx.arc(x, y, radius, 0, Math.PI * 2)
    ctx.fill()
    ctx.globalAlpha = 1
  }

  private drawBonsai(): void {
    const ctx = this.context
    const w = ctx.width
    const h = ctx.height

    ctx.clearRect(0, 0, w, h)

    const potWidth = w * 0.5
    const potHeight = h * 0.15
    const potTop = h * 0.85

    ctx.fillStyle = ZenBrown
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    ctx.globalAlpha = 0.8
    ctx.fillStyle = ZenBrown
    ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)
    ctx.globalAlpha = 1

    ctx.beginPath()
    ctx.moveTo(w * 0.5, potTop)
    ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    ctx.strokeStyle = '#5D4037'
    ctx.lineWidth = 25
    ctx.lineCap = 'round'
    ctx.stroke()

    ctx.beginPath()
    ctx.moveTo(w * 0.38, h * 0.55)
    ctx.lineTo(w * 0.25, h * 0.45)
    ctx.strokeStyle = '#5D4037'
    ctx.lineWidth = 15
    ctx.lineCap = 'round'
    ctx.stroke()

    this.drawCircle(ctx, ZenGreen, 1, 45, w * 0.6, h * 0.25)
    this.drawCircle(ctx, ZenGreen, 0.8, 35, w * 0.68, h * 0.28)
    this.drawCircle(ctx, ZenGreen, 0.9, 30, w * 0.55, h * 0.22)

    this.drawCircle(ctx, ZenGreen, 1, 35, w * 0.35, h * 0.5)
    this.drawCircle(ctx, ZenGreen, 0.8, 25, w * 0.3, h * 0.45)

    this.drawCircle(ctx, ZenGreen, 1, 25, w * 0.22, h * 0.42)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawBonsai()
        })
        .onAreaChange(() => {
          this.drawBonsai()
        })
    }
    .width('100%')
    .height('100%')
  }
}