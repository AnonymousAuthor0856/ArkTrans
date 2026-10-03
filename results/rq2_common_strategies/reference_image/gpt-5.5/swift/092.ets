class Palette {
  static readonly zenGreen: string = '#6A8E6A'
  static readonly zenGreenLight: string = '#E8F5E9'
  static readonly zenBrown: string = '#8D6E63'
  static readonly zenTextPrimary: string = '#2C3E50'
  static readonly zenTextSecondary: string = '#7F8C8D'
  static readonly zenWhite: string = '#FFFFFF'
  static readonly statusItemBg: string = '#F7F9F9'
  static readonly statusItemBorder: string = '#ECEFF1'
  static readonly careLogBg: string = '#FAFAFA'
  static readonly careLogBorder: string = '#F0F0F0'
  static readonly careLogSubtitle: string = '#9E9E9E'
  static readonly navIconInactive: string = '#CFD8DC'
  static readonly bottomBarDivider: string = '#F5F5F5'
  static readonly lightGrayCircle: string = '#E0E0E0'
  static readonly trunkColor: string = '#5D4037'
  static readonly healthRed: string = '#E57373'
  static readonly waterBlue: string = '#64B5F6'
}

@Entry
@Component
struct ZenBonsaiAppView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          HeaderSection()

          Blank().height(32)

          BonsaiVisual()
            .width(220)
            .height(220)

          Blank().height(32)

          StatusRow()

          Blank().height(32)

          ActivityLogSection()
        }
        .width('100%')
        .padding({
          left: 24,
          right: 24,
          top: 24,
          bottom: 104
        })
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(Palette.zenWhite)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(Palette.zenWhite)

      SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Palette.zenWhite)
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Palette.zenTextSecondary)
        .letterSpacing(2)

      Blank().height(8)

      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Lighter)
        .fontColor(Palette.zenTextPrimary)
    }
    .width('100%')
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
        tint: Palette.healthRed,
        iconSize: 30
      })

      StatusItem({
        icon: '▦',
        label: 'Age',
        value: '4 Yrs',
        tint: Palette.zenBrown,
        iconSize: 28
      })

      StatusItem({
        icon: '✓',
        label: 'Water',
        value: '2 Days',
        tint: Palette.waterBlue,
        iconSize: 30
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
  tint: string = Palette.zenGreen
  iconSize: number = 28

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(50)
          .height(50)
          .fill(Palette.statusItemBg)
          .stroke(Palette.statusItemBorder)
          .strokeWidth(1)

        Text(this.icon)
          .fontSize(this.iconSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tint)
      }
      .width(50)
      .height(50)

      Blank().height(8)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Palette.zenTextPrimary)

      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Regular)
        .fontColor(Palette.zenTextSecondary)
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
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Palette.zenTextPrimary)

        Blank().layoutWeight(1)

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(28)
            .height(28)
            .fill(Palette.zenGreenLight)

          Text('+')
            .fontSize(28)
            .fontWeight(FontWeight.Regular)
            .fontColor(Palette.zenGreen)
            .translate({ y: -2 })
        }
        .width(28)
        .height(28)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank().height(16)

      CareLogItem({
        title: 'Watering',
        subtitle: 'Today, 8:00 AM',
        isDone: true
      })

      Blank().height(12)

      CareLogItem({
        title: 'Pruning',
        subtitle: 'Tomorrow',
        isDone: false
      })

      Blank().height(12)

      CareLogItem({
        title: 'Fertilizer',
        subtitle: 'In 5 days',
        isDone: false
      })
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
    Row() {
      Circle()
        .width(12)
        .height(12)
        .fill(this.isDone ? Palette.zenGreen : Palette.lightGrayCircle)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.isDone ? Palette.zenTextPrimary : Palette.zenTextSecondary)

        Text(this.subtitle)
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor(Palette.careLogSubtitle)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      if (this.isDone) {
        Text('✓')
          .fontSize(30)
          .fontWeight(FontWeight.Regular)
          .fontColor(Palette.zenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Palette.careLogBg)
    .border({
      width: 1,
      color: Palette.careLogBorder,
      radius: 12
    })
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Column() {
      Divider()
        .width('100%')
        .height(1)
        .color(Palette.bottomBarDivider)

      Row() {
        NavIcon({
          icon: '⌂',
          isSelected: true,
          iconSize: 42
        })

        NavIcon({
          icon: 'ℹ',
          isSelected: false,
          iconSize: 32
        })

        NavIcon({
          icon: '⚙',
          isSelected: false,
          iconSize: 42
        })
      }
      .width('100%')
      .height(80)
      .backgroundColor(Palette.zenWhite)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(Palette.zenWhite)
  }
}

@Component
struct NavIcon {
  icon: string = ''
  isSelected: boolean = false
  iconSize: number = 32

  build() {
    Column() {
      Text(this.icon)
        .fontSize(this.iconSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected ? Palette.zenGreen : Palette.navIconInactive)

      if (this.isSelected) {
        Blank().height(4)

        Circle()
          .width(4)
          .height(4)
          .fill(Palette.zenGreen)
      }
    }
    .layoutWeight(1)
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BonsaiVisual {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private fillCircle(x: number, y: number, radius: number, color: string): void {
    this.context.beginPath()
    this.context.fillStyle = color
    this.context.arc(x, y, radius, 0, Math.PI * 2)
    this.context.fill()
  }

  private draw(): void {
    const w: number = 220
    const h: number = 220
    const potWidth: number = w * 0.5
    const potHeight: number = h * 0.15
    const potTop: number = h * 0.85

    this.context.clearRect(0, 0, w, h)

    this.context.fillStyle = Palette.zenBrown
    this.context.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    this.context.fillStyle = 'rgba(141, 110, 99, 0.80)'
    this.context.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    this.context.beginPath()
    this.context.moveTo(w * 0.5, potTop)
    this.context.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    this.context.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    this.context.strokeStyle = Palette.trunkColor
    this.context.lineWidth = 25
    this.context.lineCap = 'round'
    this.context.stroke()

    this.context.beginPath()
    this.context.moveTo(w * 0.38, h * 0.55)
    this.context.lineTo(w * 0.25, h * 0.45)
    this.context.strokeStyle = Palette.trunkColor
    this.context.lineWidth = 15
    this.context.lineCap = 'round'
    this.context.stroke()

    this.fillCircle(w * 0.6, h * 0.25, 45, Palette.zenGreen)
    this.fillCircle(w * 0.68, h * 0.28, 35, 'rgba(106, 142, 106, 0.80)')
    this.fillCircle(w * 0.55, h * 0.22, 30, 'rgba(106, 142, 106, 0.90)')

    this.fillCircle(w * 0.35, h * 0.5, 35, Palette.zenGreen)
    this.fillCircle(w * 0.30, h * 0.45, 25, 'rgba(106, 142, 106, 0.80)')

    this.fillCircle(w * 0.22, h * 0.42, 25, Palette.zenGreen)
  }

  build() {
    Canvas(this.context)
      .width(220)
      .height(220)
      .onReady(() => {
        this.draw()
      })
  }
}