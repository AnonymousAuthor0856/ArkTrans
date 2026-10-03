const ZenGreen: string = '#6A8E6A'
const ZenGreenLight: string = '#E8F5E9'
const ZenBrown: string = '#8D6E63'
const ZenTextPrimary: string = '#2C3E50'
const ZenTextSecondary: string = '#7F8C8D'
const ZenWhite: string = '#FFFFFF'

@Entry
@Component
struct Index {
  build() {
    ZenBonsaiApp()
  }
}

@Component
struct ZenBonsaiApp {
  build() {
    Column() {
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
      .layoutWeight(1)
      .padding(24)
      .alignItems(HorizontalAlign.Center)

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
        .fontWeight(FontWeight.Medium)
        .fontColor(ZenTextSecondary)
        .letterSpacing(2)

      Blank()
        .height(8)

      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Lighter)
        .fontColor(ZenTextPrimary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem({
        icon: '♥',
        label: 'Health',
        value: '98%',
        tint: '#E57373'
      })

      StatusItem({
        icon: '▣',
        label: 'Age',
        value: '4 Yrs',
        tint: ZenBrown
      })

      StatusItem({
        icon: '✓',
        label: 'Water',
        value: '2 Days',
        tint: '#64B5F6'
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct StatusItem {
  icon: string = ''
  label: string = ''
  value: string = ''
  tint: string = ZenGreen

  build() {
    Column() {
      Stack() {
        Text(this.icon)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tint)
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .backgroundColor('#F7F9F9')
      .border({
        width: 1,
        color: '#ECEFF1',
        radius: 25
      })

      Blank()
        .height(8)

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZenTextPrimary)

      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
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
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#202124')

        Stack() {
          Text('+')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor(ZenGreen)
            .margin({ bottom: 3 })
        }
        .width(28)
        .height(28)
        .borderRadius(14)
        .backgroundColor(ZenGreenLight)
        .onClick(() => {
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(16)

      CareLogItem({
        title: 'Watering',
        subtitle: 'Today, 8:00 AM',
        isDone: true
      })

      Blank()
        .height(12)

      CareLogItem({
        title: 'Pruning',
        subtitle: 'Tomorrow',
        isDone: false
      })

      Blank()
        .height(12)

      CareLogItem({
        title: 'Fertilizer',
        subtitle: 'In 5 days',
        isDone: false
      })
    }
    .width('100%')
  }
}

@Component
struct CareLogItem {
  title: string = ''
  subtitle: string = ''
  isDone: boolean = false

  build() {
    Row() {
      Blank()
        .width(12)
        .height(12)
        .borderRadius(6)
        .backgroundColor(this.isDone ? ZenGreen : '#E0E0E0')

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
          .fontWeight(FontWeight.Bold)
          .fontColor(ZenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .backgroundColor('#FAFAFA')
    .border({
      width: 1,
      color: '#F0F0F0',
      radius: 12
    })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Row() {
      NavIcon({
        icon: '⌂',
        isSelected: true
      })

      NavIcon({
        icon: 'i',
        isSelected: false
      })

      NavIcon({
        icon: '⚙',
        isSelected: false
      })
    }
    .width('100%')
    .height(80)
    .backgroundColor(ZenWhite)
    .border({
      width: 1,
      color: '#F5F5F5'
    })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct NavIcon {
  icon: string = ''
  isSelected: boolean = false

  build() {
    Column() {
      Text(this.icon)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected ? ZenGreen : '#CFD8DC')

      if (this.isSelected) {
        Blank()
          .height(4)

        Blank()
          .width(4)
          .height(4)
          .borderRadius(2)
          .backgroundColor(ZenGreen)
      }
    }
    .width(80)
    .height(60)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BonsaiVisual {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawCircle(x: number, y: number, radius: number, color: string): void {
    this.context.beginPath()
    this.context.fillStyle = color
    this.context.arc(x, y, radius, 0, Math.PI * 2)
    this.context.fill()
  }

  private drawBonsai(): void {
    const w: number = 220
    const h: number = 220
    const potWidth: number = w * 0.5
    const potHeight: number = h * 0.15
    const potTop: number = h * 0.85

    this.context.clearRect(0, 0, w, h)

    this.context.fillStyle = ZenBrown
    this.context.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    this.context.fillStyle = 'rgba(141,110,99,0.8)'
    this.context.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    this.context.beginPath()
    this.context.moveTo(w * 0.5, potTop)
    this.context.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    this.context.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    this.context.strokeStyle = '#5D4037'
    this.context.lineWidth = 25
    this.context.lineCap = 'round'
    this.context.stroke()

    this.context.beginPath()
    this.context.moveTo(w * 0.38, h * 0.55)
    this.context.lineTo(w * 0.25, h * 0.45)
    this.context.strokeStyle = '#5D4037'
    this.context.lineWidth = 15
    this.context.lineCap = 'round'
    this.context.stroke()

    this.drawCircle(w * 0.6, h * 0.25, 45, ZenGreen)
    this.drawCircle(w * 0.68, h * 0.28, 35, 'rgba(106,142,106,0.8)')
    this.drawCircle(w * 0.55, h * 0.22, 30, 'rgba(106,142,106,0.9)')

    this.drawCircle(w * 0.35, h * 0.5, 35, ZenGreen)
    this.drawCircle(w * 0.3, h * 0.45, 25, 'rgba(106,142,106,0.8)')

    this.drawCircle(w * 0.22, h * 0.42, 25, ZenGreen)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawBonsai()
        })
    }
    .width(220)
    .height(220)
  }
}