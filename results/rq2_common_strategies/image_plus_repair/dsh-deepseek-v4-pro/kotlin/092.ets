// 092.kt -> 092.ets
// Zen Garden (Juniper #04) — translated from Jetpack Compose to ArkUI/ArkTS

// --- Color Palette (Custom Muted Earth Tones) ---
const ZenGreen: string = '#6A8E6A'
const ZenGreenLight: string = '#E8F5E9'
const ZenBrown: string = '#8D6E63'
const ZenTextPrimary: string = '#2C3E50'
const ZenTextSecondary: string = '#7F8C8D'
const ZenWhite: string = '#FFFFFF'
const ZenAccent: string = '#D4E157'

@Entry
@Component
struct ZenBonsaiPage {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Column() {
      Scroll() {
        Column() {
          this.HeaderSection()
          Row().height(32)
          this.BonsaiVisual()
          Row().height(32)
          this.StatusRow()
          Row().height(32)
          this.ActivityLogSection()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenWhite)
  }

  @Builder
  HeaderSection() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(11)
        .fontColor(ZenTextSecondary)
        .letterSpacing(2)
      Row().height(8)
      Text('Zen Garden')
        .fontSize(32)
        .fontWeight(FontWeight.Lighter)
        .fontColor(ZenTextPrimary)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StatusRow() {
    Row() {
      this.StatusItem('♥', 'Health', '98%', '#E57373')
      this.StatusItem('▦', 'Age', '4 Yrs', ZenBrown)
      this.StatusItem('◉', 'Water', '2 Days', '#64B5F6')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  StatusItem(icon: string, label: string, value: string, tint: string) {
    Column() {
      Column() {
        Text(icon)
          .fontSize(24)
          .fontColor(tint)
      }
      .width(50)
      .height(50)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#F7F9F9')
      .borderRadius(25)
      .border({ width: 1, color: '#ECEFF1' })

      Row().height(8)
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZenTextPrimary)
      Text(label)
        .fontSize(11)
        .fontColor(ZenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActivityLogSection() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        Column() {
          Text('+')
            .fontSize(20)
            .fontColor(ZenGreen)
        }
        .width(28)
        .height(28)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(ZenGreenLight)
        .borderRadius(14)
        .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row().height(16)
      this.CareLogItem('Watering', 'Today, 8:00 AM', true)
      Row().height(12)
      this.CareLogItem('Pruning', 'Tomorrow', false)
      Row().height(12)
      this.CareLogItem('Fertilizer', 'In 5 days', false)
    }
    .width('100%')
  }

  @Builder
  CareLogItem(title: string, subtitle: string, isDone: boolean) {
    Row() {
      Row()
        .width(12)
        .height(12)
        .backgroundColor(isDone ? ZenGreen : '#E0E0E0')
        .borderRadius(6)

      Row().width(16)

      Column() {
        Text(title)
          .fontSize(14)
          .fontColor(isDone ? ZenTextPrimary : ZenTextSecondary)
        Text(subtitle)
          .fontSize(11)
          .fontColor('#9E9E9E')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      if (isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor(ZenGreen)
      }
    }
    .width('100%')
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#F0F0F0' })
    .padding(16)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SimpleBottomNav() {
    Row() {
      this.NavIcon('⌂', true)
      this.NavIcon('ⓘ', false)
      this.NavIcon('⚙', false)
    }
    .width('100%')
    .height(80)
    .backgroundColor(ZenWhite)
    .border({ width: 1, color: '#F5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NavIcon(icon: string, isSelected: boolean) {
    Column() {
      Text(icon)
        .fontSize(28)
        .fontColor(isSelected ? ZenGreen : '#CFD8DC')
      if (isSelected) {
        Row().height(4)
        Row()
          .width(4)
          .height(4)
          .backgroundColor(ZenGreen)
          .borderRadius(2)
      }
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  BonsaiVisual() {
    Canvas(this.context)
      .width(220)
      .height(220)
      .onReady(() => {
        this.drawBonsai()
      })
  }

  private drawBonsai() {
    const w: number = this.context.width
    const h: number = this.context.height

    // 1. Draw Pot
    const potWidth: number = w * 0.5
    const potHeight: number = h * 0.15
    const potTop: number = h * 0.85

    this.context.fillStyle = ZenBrown
    this.context.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    // Pot Rim
    this.context.fillStyle = 'rgba(141,110,99,0.8)'
    this.context.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    // 2. Draw Trunk (Bezier curves)
    this.context.beginPath()
    this.context.moveTo(w * 0.5, potTop)
    this.context.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    this.context.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    this.context.strokeStyle = '#5D4037'
    this.context.lineWidth = 25
    this.context.lineCap = 'round'
    this.context.stroke()

    // Secondary Branch
    this.context.beginPath()
    this.context.moveTo(w * 0.38, h * 0.55)
    this.context.lineTo(w * 0.25, h * 0.45)
    this.context.strokeStyle = '#5D4037'
    this.context.lineWidth = 15
    this.context.lineCap = 'round'
    this.context.stroke()

    // 3. Draw Leaves (Clusters of circles)
    this.fillCircle(w * 0.6, h * 0.25, 45, ZenGreen)
    this.fillCircle(w * 0.68, h * 0.28, 35, 'rgba(106,142,106,0.8)')
    this.fillCircle(w * 0.55, h * 0.22, 30, 'rgba(106,142,106,0.9)')
    this.fillCircle(w * 0.35, h * 0.5, 35, ZenGreen)
    this.fillCircle(w * 0.30, h * 0.45, 25, 'rgba(106,142,106,0.8)')
    this.fillCircle(w * 0.22, h * 0.42, 25, ZenGreen)
  }

  private fillCircle(x: number, y: number, radius: number, color: string) {
    this.context.beginPath()
    this.context.arc(x, y, radius, 0, Math.PI * 2)
    this.context.fillStyle = color
    this.context.fill()
  }
}
