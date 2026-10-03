// Index.ets  —  Zen Garden (ArkTS / ArkUI port of the Jetpack Compose screen)

const ZenGreen: string = '#6A8E6A'
const ZenGreenLight: string = '#E8F5E9'
const ZenBrown: string = '#8D6E63'
const ZenBrownSoft: string = 'rgba(141,110,99,0.8)'
const ZenTrunk: string = '#5D4037'
const ZenTextPrimary: string = '#2C3E50'
const ZenTextSecondary: string = '#7F8C8D'
const ZenWhite: string = '#FFFFFF'

@Entry
@Component
struct ZenGardenPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  // ---------------- Bonsai drawing ----------------
  private fillCircle(x: number, y: number, r: number, color: string): void {
    this.ctx.beginPath()
    this.ctx.arc(x, y, r, 0, Math.PI * 2)
    this.ctx.fillStyle = color
    this.ctx.fill()
  }

  private drawBonsai(): void {
    const w: number = this.ctx.width
    const h: number = this.ctx.height
    const ctx = this.ctx

    // 1. Pot
    const potWidth: number = w * 0.5
    const potHeight: number = h * 0.15
    const potTop: number = h * 0.85
    ctx.fillStyle = ZenBrown
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    // Pot rim
    ctx.fillStyle = ZenBrownSoft
    ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    // 2. Trunk
    ctx.beginPath()
    ctx.moveTo(w * 0.5, potTop)
    ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    ctx.strokeStyle = ZenTrunk
    ctx.lineWidth = 25
    ctx.lineCap = 'round'
    ctx.stroke()

    // Secondary branch
    ctx.beginPath()
    ctx.moveTo(w * 0.38, h * 0.55)
    ctx.lineTo(w * 0.25, h * 0.45)
    ctx.strokeStyle = ZenTrunk
    ctx.lineWidth = 15
    ctx.lineCap = 'round'
    ctx.stroke()

    // 3. Foliage clusters
    this.fillCircle(w * 0.6, h * 0.25, 45, ZenGreen)
    this.fillCircle(w * 0.68, h * 0.28, 35, 'rgba(106,142,106,0.8)')
    this.fillCircle(w * 0.55, h * 0.22, 30, 'rgba(106,142,106,0.9)')

    this.fillCircle(w * 0.35, h * 0.5, 35, ZenGreen)
    this.fillCircle(w * 0.30, h * 0.45, 25, 'rgba(106,142,106,0.8)')

    this.fillCircle(w * 0.22, h * 0.42, 25, ZenGreen)
  }

  // ---------------- Builders ----------------
  @Builder
  HeaderSection() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ZenTextSecondary)
        .letterSpacing(2)
      Text('Zen Garden')
        .fontSize(38)
        .fontWeight(FontWeight.Light)
        .fontColor(ZenTextPrimary)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StatusItem(icon: string, label: string, value: string, tint: string) {
    Column() {
      Stack() {
        Text(icon)
          .fontSize(20)
          .fontColor(tint)
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .backgroundColor('#F7F9F9')
      .border({ width: 1, color: '#ECEFF1' })

      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZenTextPrimary)
        .margin({ top: 8 })

      Text(label)
        .fontSize(11)
        .fontColor(ZenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StatusRow() {
    Row() {
      this.StatusItem('♥', 'Health', '98%', '#E57373')
      this.StatusItem('▦', 'Age', '4 Yrs', ZenBrown)
      this.StatusItem('✓', 'Water', '2 Days', '#64B5F6')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  CareLogItem(title: string, subtitle: string, isDone: boolean) {
    Row() {
      Column()
        .width(12)
        .height(12)
        .borderRadius(6)
        .backgroundColor(isDone ? ZenGreen : '#E0E0E0')

      Column() {
        Text(title)
          .fontSize(14)
          .fontColor(isDone ? ZenTextPrimary : ZenTextSecondary)
        Text(subtitle)
          .fontSize(11)
          .fontColor('#9E9E9E')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      if (isDone) {
        Text('✓')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(ZenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#F0F0F0' })
  }

  @Builder
  ActivityLogSection() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(ZenTextPrimary)
        Blank()
        Stack() {
          Text('+')
            .fontSize(20)
            .fontColor(ZenGreen)
        }
        .width(28)
        .height(28)
        .borderRadius(14)
        .backgroundColor(ZenGreenLight)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 16 })

      this.CareLogItem('Watering', 'Today, 8:00 AM', true)
      this.CareLogItem('Pruning', 'Tomorrow', false)
        .margin({ top: 12 })
      this.CareLogItem('Fertilizer', 'In 5 days', false)
        .margin({ top: 12 })
    }
    .width('100%')
  }

  @Builder
  NavIcon(icon: string, isSelected: boolean) {
    Column() {
      Text(icon)
        .fontSize(24)
        .fontColor(isSelected ? ZenGreen : '#CFD8DC')
      if (isSelected) {
        Column()
          .width(4)
          .height(4)
          .borderRadius(2)
          .backgroundColor(ZenGreen)
          .margin({ top: 4 })
      }
    }
    .justifyContent(FlexAlign.Center)
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

  // ---------------- Page ----------------
  build() {
    Column() {
      Scroll() {
        Column() {
          this.HeaderSection()

          Canvas(this.ctx)
            .width(220)
            .height(220)
            .margin({ top: 32 })
            .onReady(() => {
              this.drawBonsai()
            })

          this.StatusRow()
            .margin({ top: 32 })

          this.ActivityLogSection()
            .margin({ top: 32 })
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)

      this.SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenWhite)
  }
}