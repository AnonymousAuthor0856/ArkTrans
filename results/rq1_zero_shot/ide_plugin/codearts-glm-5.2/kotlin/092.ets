class AppTokens {
  static readonly Colors = {
    zenGreen: '#FF6A8E6A',
    zenGreen80: '#CC6A8E6A',
    zenGreen90: '#E66A8E6A',
    zenGreenLight: '#FFE8F5E9',
    zenBrown: '#FF8D6E63',
    zenBrown80: '#CC8D6E63',
    zenTextPrimary: '#FF2C3E50',
    zenTextSecondary: '#FF7F8C8D',
    zenWhite: '#FFFFFFFF',
    zenAccent: '#FFD4E157',
    healthRed: '#FFE57373',
    waterBlue: '#FF64B5F6',
    statusBg: '#FFF7F9F9',
    statusBorder: '#FFECEFF1',
    logBg: '#FFFAFAFA',
    logBorder: '#FFF0F0F0',
    logDot: '#FFE0E0E0',
    logSubtitle: '#FF9E9E9E',
    navBorder: '#FFF5F5F5',
    navInactive: '#FFCFD8DC',
    trunk: '#FF5D4037'
  }
}

@Entry
@Component
struct ZenBonsaiApp {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      Column() {
        Column() {
          Text('JUNIPER · #04')
            .fontSize(12)
            .fontColor(AppTokens.Colors.zenTextSecondary)
            .letterSpacing(2)
          Text('Zen Garden')
            .fontSize(32)
            .fontWeight(FontWeight.Light)
            .fontColor(AppTokens.Colors.zenTextPrimary)
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Center)

        Canvas(this.context)
          .width(220)
          .height(220)
          .onReady(() => {
            let ctx = this.context
            let w = 220
            let h = 220

            let potWidth = w * 0.5
            let potHeight = h * 0.15
            let potTop = h * 0.85

            ctx.fillStyle = AppTokens.Colors.zenBrown
            ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

            ctx.fillStyle = AppTokens.Colors.zenBrown80
            ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

            ctx.strokeStyle = AppTokens.Colors.trunk
            ctx.lineWidth = 25
            ctx.lineCap = 'round'
            ctx.beginPath()
            ctx.moveTo(w * 0.5, potTop)
            ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
            ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
            ctx.stroke()

            ctx.strokeStyle = AppTokens.Colors.trunk
            ctx.lineWidth = 15
            ctx.lineCap = 'round'
            ctx.beginPath()
            ctx.moveTo(w * 0.38, h * 0.55)
            ctx.lineTo(w * 0.25, h * 0.45)
            ctx.stroke()

            ctx.fillStyle = AppTokens.Colors.zenGreen
            ctx.beginPath()
            ctx.arc(w * 0.6, h * 0.25, 45, 0, Math.PI * 2)
            ctx.fill()

            ctx.fillStyle = AppTokens.Colors.zenGreen80
            ctx.beginPath()
            ctx.arc(w * 0.68, h * 0.28, 35, 0, Math.PI * 2)
            ctx.fill()

            ctx.fillStyle = AppTokens.Colors.zenGreen90
            ctx.beginPath()
            ctx.arc(w * 0.55, h * 0.22, 30, 0, Math.PI * 2)
            ctx.fill()

            ctx.fillStyle = AppTokens.Colors.zenGreen
            ctx.beginPath()
            ctx.arc(w * 0.35, h * 0.5, 35, 0, Math.PI * 2)
            ctx.fill()

            ctx.fillStyle = AppTokens.Colors.zenGreen80
            ctx.beginPath()
            ctx.arc(w * 0.30, h * 0.45, 25, 0, Math.PI * 2)
            ctx.fill()

            ctx.fillStyle = AppTokens.Colors.zenGreen
            ctx.beginPath()
            ctx.arc(w * 0.22, h * 0.42, 25, 0, Math.PI * 2)
            ctx.fill()
          })
          .margin({ top: 32 })

        Row() {
          StatusItem({ icon: '♥', label: 'Health', value: '98%', tint: AppTokens.Colors.healthRed })
          StatusItem({ icon: '▦', label: 'Age', value: '4 Yrs', tint: AppTokens.Colors.zenBrown })
          StatusItem({ icon: '✓', label: 'Water', value: '2 Days', tint: AppTokens.Colors.waterBlue })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 32 })

        Column() {
          Row() {
            Text('Care Schedule')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.zenTextPrimary)
            Row() {
              Text('+')
                .fontSize(16)
                .fontColor(AppTokens.Colors.zenGreen)
            }
            .width(28)
            .height(28)
            .borderRadius(14)
            .backgroundColor(AppTokens.Colors.zenGreenLight)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })
          CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })
            .margin({ top: 12 })
          CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
            .margin({ top: 12 })
        }
        .width('100%')
        .margin({ top: 32 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(24)
      .alignItems(HorizontalAlign.Center)

      Row() {
        NavIcon({ icon: '⌂', isSelected: true })
        NavIcon({ icon: 'ℹ', isSelected: false })
        NavIcon({ icon: '⚙', isSelected: false })
      }
      .width('100%')
      .height(80)
      .backgroundColor(AppTokens.Colors.zenWhite)
      .border({ width: 1, color: AppTokens.Colors.navBorder })
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.zenWhite)
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
      Row() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(this.tint)
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .backgroundColor(AppTokens.Colors.statusBg)
      .border({ width: 1, color: AppTokens.Colors.statusBorder })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.zenTextPrimary)
        .margin({ top: 8 })
      Text(this.label)
        .fontSize(10)
        .fontColor(AppTokens.Colors.zenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct CareLogItem {
  @Prop title: string
  @Prop subtitle: string
  @Prop isDone: boolean

  build() {
    Row() {
      Row()
        .width(12)
        .height(12)
        .borderRadius(6)
        .backgroundColor(this.isDone ? AppTokens.Colors.zenGreen : AppTokens.Colors.logDot)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontColor(this.isDone ? AppTokens.Colors.zenTextPrimary : AppTokens.Colors.zenTextSecondary)
        Text(this.subtitle)
          .fontSize(10)
          .fontColor(AppTokens.Colors.logSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
      .layoutWeight(1)

      if (this.isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor(AppTokens.Colors.zenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .backgroundColor(AppTokens.Colors.logBg)
    .border({ width: 1, color: AppTokens.Colors.logBorder })
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
        .fontColor(this.isSelected ? AppTokens.Colors.zenGreen : AppTokens.Colors.navInactive)
      if (this.isSelected) {
        Row()
          .width(4)
          .height(4)
          .borderRadius(2)
          .backgroundColor(AppTokens.Colors.zenGreen)
          .margin({ top: 4 })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}