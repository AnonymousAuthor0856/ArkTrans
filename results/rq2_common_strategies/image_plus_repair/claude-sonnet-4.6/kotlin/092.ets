@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Column() {
      // Main content
      Column({ space: 0 }) {
        // Header
        HeaderSection()

        Blank().height(32)

        // Bonsai Visual
        BonsaiVisual()

        Blank().height(32)

        // Status Row
        StatusRow()

        Blank().height(32)

        // Activity Log
        ActivityLogSection()
      }
      .width('100%')
      .layoutWeight(1)
      .padding(24)
      .alignItems(HorizontalAlign.Center)

      // Bottom Nav
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
    Column({ space: 8 }) {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontColor('#7F8C8D')
        .letterSpacing(2)

      Text('Zen Garden')
        .fontSize(36)
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
      StatusItem({ iconText: '♥', label: 'Health', value: '98%', iconColor: '#E57373' })
      StatusItem({ iconText: '📅', label: 'Age', value: '4 Yrs', iconColor: '#8D6E63' })
      StatusItem({ iconText: '✓', label: 'Water', value: '2 Days', iconColor: '#64B5F6' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Component
struct StatusItem {
  iconText: string = ''
  label: string = ''
  value: string = ''
  iconColor: string = '#000000'

  build() {
    Column({ space: 8 }) {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill('#F7F9F9')
          .stroke('#ECEFF1')
          .strokeWidth(1)

        Text(this.iconText)
          .fontSize(20)
          .fontColor(this.iconColor)
      }
      .width(50)
      .height(50)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2C3E50')

      Text(this.label)
        .fontSize(11)
        .fontColor('#7F8C8D')
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
          .fontColor('#2C3E50')

        Stack() {
          Circle()
            .width(28)
            .height(28)
            .fill('#E8F5E9')

          Text('+')
            .fontSize(18)
            .fontColor('#6A8E6A')
        }
        .width(28)
        .height(28)
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
        .fill(this.isDone ? '#6A8E6A' : '#E0E0E0')

      Blank().width(16)

      Column({ space: 2 }) {
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
          .fontSize(16)
          .fontColor('#6A8E6A')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#F0F0F0' })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Row() {
      NavIcon({ iconText: '⌂', isSelected: true })
      NavIcon({ iconText: 'ℹ', isSelected: false })
      NavIcon({ iconText: '⚙', isSelected: false })
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFF')
    .border({ width: { top: 1 }, color: '#F5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct NavIcon {
  iconText: string = ''
  isSelected: boolean = false

  build() {
    Column({ space: 4 }) {
      Text(this.iconText)
        .fontSize(24)
        .fontColor(this.isSelected ? '#6A8E6A' : '#CFD8DC')

      if (this.isSelected) {
        Circle()
          .width(4)
          .height(4)
          .fill('#6A8E6A')
      }
    }
    .alignItems(HorizontalAlign.Center)
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
        this.drawBonsai()
      })
  }

  drawBonsai() {
    const ctx = this.context
    const w = 220
    const h = 220

    ctx.clearRect(0, 0, w, h)

    // 1. Draw Pot
    const potWidth = w * 0.5
    const potHeight = h * 0.15
    const potTop = h * 0.85

    // Pot body
    ctx.fillStyle = '#8D6E63'
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    // Pot rim
    ctx.fillStyle = 'rgba(141,110,99,0.8)'
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

    // Cluster 2 (Middle Left)
    ctx.fillStyle = '#6A8E6A'
    ctx.beginPath()
    ctx.arc(w * 0.35, h * 0.5, 35, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = 'rgba(106,142,106,0.8)'
    ctx.beginPath()
    ctx.arc(w * 0.30, h * 0.45, 25, 0, Math.PI * 2)
    ctx.fill()

    // Cluster 3 (Far Left Branch)
    ctx.fillStyle = '#6A8E6A'
    ctx.beginPath()
    ctx.arc(w * 0.22, h * 0.42, 25, 0, Math.PI * 2)
    ctx.fill()
  }
}