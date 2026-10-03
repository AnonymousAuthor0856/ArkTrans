import { LengthMetrics } from '@kit.ArkUI'

// --- Color Palette ---
const ZenGreen = '#6A8E6A'
const ZenGreenLight = '#E8F5E9'
const ZenBrown = '#8D6E63'
const ZenTextPrimary = '#2C3E50'
const ZenTextSecondary = '#7F8C8D'
const ZenWhite = '#FFFFFF'
const ZenAccent = '#D4E157'

@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Column() {
      // Main scrollable content
      Scroll() {
        Column({ space: 0 }) {
          Column({ space: 0 })
            .height(32)

          HeaderSection()

          Column({ space: 0 })
            .height(32)

          BonsaiVisual()

          Column({ space: 0 })
            .height(32)

          StatusRow()

          Column({ space: 0 })
            .height(32)

          ActivityLogSection()

          Column({ space: 0 })
            .height(32)
        }
        .padding(24)
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

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
    Column({ space: 8 }) {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontColor(ZenTextSecondary)
        .letterSpacing(2)

      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Lighter)
        .fontColor(ZenTextPrimary)
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem({
        label: 'Health',
        value: '98%',
        iconSymbol: SymbolGlyphModifier($r('sys.symbol.heart_fill')),
        tintColor: '#E57373'
      })
      StatusItem({
        label: 'Age',
        value: '4 Yrs',
        iconSymbol: SymbolGlyphModifier($r('sys.symbol.calendar')),
        tintColor: ZenBrown
      })
      StatusItem({
        label: 'Water',
        value: '2 Days',
        iconSymbol: SymbolGlyphModifier($r('sys.symbol.checkmark_circle_fill')),
        tintColor: '#64B5F6'
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Component
struct StatusItem {
  label: string = ''
  value: string = ''
  iconSymbol: SymbolGlyphModifier = new SymbolGlyphModifier($r('sys.symbol.heart_fill'))
  tintColor: string = ZenGreen

  build() {
    Column({ space: 8 }) {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill('#F7F9F9')
          .stroke('#ECEFF1')
          .strokeWidth(1)

        SymbolGlyph($r('sys.symbol.heart_fill'))
          .attributeModifier(this.iconSymbol)
          .fontSize(24)
          .fontColor([this.tintColor])
      }
      .width(50)
      .height(50)

      Text(this.value)
        .fontSize(16)
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
    Column({ space: 0 }) {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ZenTextPrimary)

        Stack() {
          Circle()
            .width(28)
            .height(28)
            .fill(ZenGreenLight)

          SymbolGlyph($r('sys.symbol.plus'))
            .fontSize(16)
            .fontColor([ZenGreen])
        }
        .width(28)
        .height(28)
        .onClick(() => {
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column({ space: 0 })
        .height(16)

      CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })

      Column({ space: 0 })
        .height(12)

      CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })

      Column({ space: 0 })
        .height(12)

      CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CareLogItem {
  title: string = ''
  subtitle: string = ''
  isDone: boolean = false

  build() {
    Row({ space: 0 }) {
      Circle()
        .width(12)
        .height(12)
        .fill(this.isDone ? ZenGreen : '#E0E0E0')

      Column({ space: 0 })
        .width(16)

      Column({ space: 2 }) {
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
        SymbolGlyph($r('sys.symbol.checkmark'))
          .fontSize(20)
          .fontColor([ZenGreen])
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#F0F0F0', radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Row() {
      NavIconItem({ isSelected: true, iconRes: $r('sys.symbol.house_fill') })
      NavIconItem({ isSelected: false, iconRes: $r('sys.symbol.info_circle') })
      NavIconItem({ isSelected: false, iconRes: $r('sys.symbol.gearshape') })
    }
    .width('100%')
    .height(80)
    .backgroundColor(ZenWhite)
    .border({ width: { top: 1 }, color: '#F5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct NavIconItem {
  isSelected: boolean = false
  iconRes: Resource = $r('sys.symbol.house_fill')

  build() {
    Column({ space: 4 }) {
      SymbolGlyph(this.iconRes)
        .fontSize(28)
        .fontColor([this.isSelected ? ZenGreen : '#CFD8DC'])

      if (this.isSelected) {
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
  build() {
    Canvas(new RenderingContextSettings(true))
      .width(220)
      .height(220)
      .onReady((context: CanvasRenderingContext2D) => {
        this.drawBonsai(context)
      })
  }

  drawBonsai(ctx: CanvasRenderingContext2D) {
    const w = 220
    const h = 220

    // 1. Draw Pot
    const potWidth = w * 0.5
    const potHeight = h * 0.15
    const potTop = h * 0.85

    ctx.fillStyle = ZenBrown
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    // Pot Rim
    ctx.fillStyle = '#7A5C52'
    ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    // 2. Draw Trunk
    ctx.beginPath()
    ctx.moveTo(w * 0.5, potTop)
    ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    ctx.strokeStyle = '#5D4037'
    ctx.lineWidth = 25
    ctx.lineCap = 'round'
    ctx.stroke()

    // Secondary Branch
    ctx.beginPath()
    ctx.moveTo(w * 0.38, h * 0.55)
    ctx.lineTo(w * 0.25, h * 0.45)
    ctx.strokeStyle = '#5D4037'
    ctx.lineWidth = 15
    ctx.lineCap = 'round'
    ctx.stroke()

    // 3. Draw Leaves
    // Cluster 1 (Top Right)
    ctx.beginPath()
    ctx.arc(w * 0.6, h * 0.25, 45, 0, Math.PI * 2)
    ctx.fillStyle = ZenGreen
    ctx.fill()

    ctx.beginPath()
    ctx.arc(w * 0.68, h * 0.28, 35, 0, Math.PI * 2)
    ctx.fillStyle = '#5A7A5A'
    ctx.fill()

    ctx.beginPath()
    ctx.arc(w * 0.55, h * 0.22, 30, 0, Math.PI * 2)
    ctx.fillStyle = '#608060'
    ctx.fill()

    // Cluster 2 (Middle Left)
    ctx.beginPath()
    ctx.arc(w * 0.35, h * 0.5, 35, 0, Math.PI * 2)
    ctx.fillStyle = ZenGreen
    ctx.fill()

    ctx.beginPath()
    ctx.arc(w * 0.30, h * 0.45, 25, 0, Math.PI * 2)
    ctx.fillStyle = '#5A7A5A'
    ctx.fill()

    // Cluster 3 (Far Left Branch)
    ctx.beginPath()
    ctx.arc(w * 0.22, h * 0.42, 25, 0, Math.PI * 2)
    ctx.fillStyle = ZenGreen
    ctx.fill()
  }
}