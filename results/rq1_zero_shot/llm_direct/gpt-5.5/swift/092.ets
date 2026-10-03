class AppColors {
  static readonly zenGreen: string = '#6A8E6A'
  static readonly zenGreenLight: string = '#E8F5E9'
  static readonly zenBrown: string = '#8D6E63'
  static readonly zenTextPrimary: string = '#2C3E50'
  static readonly zenTextSecondary: string = '#7F8C8D'
  static readonly zenWhite: string = '#FFFFFF'
  static readonly zenAccent: string = '#D4E157'

  static readonly statusItemBg: string = '#F7F9F9'
  static readonly statusItemBorder: string = '#ECEFF1'
  static readonly careLogBg: string = '#FAFAFA'
  static readonly careLogBorder: string = '#F0F0F0'
  static readonly careLogSubtitle: string = '#9E9E9E'
  static readonly navIconInactive: string = '#CFD8DC'
  static readonly bottomBarDivider: string = '#F5F5F5'
  static readonly lightGrayCircle: string = '#E0E0E0'
  static readonly trunkColor: string = '#5D4025'
  static readonly healthRed: string = '#E57373'
  static readonly waterBlue: string = '#64B5F6'
}

@Entry
@Component
struct ZenBonsaiApp {
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
        .backgroundColor(AppColors.zenWhite)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.zenWhite)
      .scrollBar(BarState.Off)

      SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.zenWhite)
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.zenTextSecondary)
        .letterSpacing(2)

      Blank().height(8)

      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Lighter)
        .fontColor(AppColors.zenTextPrimary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      Blank().layoutWeight(1)

      StatusItem({
        icon: '♥',
        label: 'Health',
        value: '98%',
        tint: AppColors.healthRed
      })

      Blank().layoutWeight(1)

      StatusItem({
        icon: '□',
        label: 'Age',
        value: '4 Yrs',
        tint: AppColors.zenBrown
      })

      Blank().layoutWeight(1)

      StatusItem({
        icon: '✓',
        label: 'Water',
        value: '2 Days',
        tint: AppColors.waterBlue
      })

      Blank().layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct StatusItem {
  icon: string = ''
  label: string = ''
  value: string = ''
  tint: string = AppColors.zenGreen

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 50, height: 50 })
          .fill(AppColors.statusItemBg)
          .stroke(AppColors.statusItemBorder)
          .strokeWidth(1)

        Text(this.icon)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tint)
      }
      .width(50)
      .height(50)

      Blank().height(8)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.zenTextPrimary)

      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.zenTextSecondary)
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
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.zenTextPrimary)

        Blank().layoutWeight(1)

        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 28, height: 28 })
            .fill(AppColors.zenGreenLight)

          Text('+')
            .fontSize(22)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.zenGreen)
            .offset({ y: -1 })
        }
        .width(28)
        .height(28)
        .onClick(() => {
        })
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
      Circle({ width: 12, height: 12 })
        .fill(this.isDone ? AppColors.zenGreen : AppColors.lightGrayCircle)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.isDone ? AppColors.zenTextPrimary : AppColors.zenTextSecondary)

        Text(this.subtitle)
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.careLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Text('✓')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.zenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.careLogBg)
    .borderRadius(12)
    .border({
      width: 1,
      color: AppColors.careLogBorder,
      radius: 12
    })
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Column() {
      Divider()
        .color(AppColors.bottomBarDivider)
        .height(1)

      Row() {
        NavIcon({
          icon: '⌂',
          isSelected: true
        })

        NavIcon({
          icon: 'ℹ',
          isSelected: false
        })

        NavIcon({
          icon: '⚙',
          isSelected: false
        })
      }
      .width('100%')
      .height(80)
      .backgroundColor(AppColors.zenWhite)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(AppColors.zenWhite)
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
        .fontColor(this.isSelected ? AppColors.zenGreen : AppColors.navIconInactive)

      if (this.isSelected) {
        Blank().height(4)

        Circle({ width: 4, height: 4 })
          .fill(AppColors.zenGreen)
      }
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct BonsaiVisual {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawCircle(cx: number, cy: number, r: number, color: string): void {
    this.context.beginPath()
    this.context.fillStyle = color
    this.context.arc(cx, cy, r, 0, Math.PI * 2)
    this.context.fill()
  }

  private draw(w: number, h: number): void {
    this.context.clearRect(0, 0, w, h)

    const potWidth: number = w * 0.5
    const potHeight: number = h * 0.15
    const potTop: number = h * 0.85

    this.context.fillStyle = AppColors.zenBrown
    this.context.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    this.context.fillStyle = 'rgba(141,110,99,0.8)'
    this.context.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    this.context.beginPath()
    this.context.moveTo(w * 0.5, potTop)
    this.context.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    this.context.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    this.context.strokeStyle = AppColors.trunkColor
    this.context.lineWidth = 25
    this.context.lineCap = 'round'
    this.context.stroke()

    this.context.beginPath()
    this.context.moveTo(w * 0.38, h * 0.55)
    this.context.lineTo(w * 0.25, h * 0.45)
    this.context.strokeStyle = AppColors.trunkColor
    this.context.lineWidth = 15
    this.context.lineCap = 'round'
    this.context.stroke()

    this.drawCircle(w * 0.6, h * 0.25, 45, AppColors.zenGreen)
    this.drawCircle(w * 0.68, h * 0.28, 35, 'rgba(106,142,106,0.8)')
    this.drawCircle(w * 0.55, h * 0.22, 30, 'rgba(106,142,106,0.9)')

    this.drawCircle(w * 0.35, h * 0.5, 35, AppColors.zenGreen)
    this.drawCircle(w * 0.30, h * 0.45, 25, 'rgba(106,142,106,0.8)')

    this.drawCircle(w * 0.22, h * 0.42, 25, AppColors.zenGreen)
  }

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.draw(220, 220)
      })
  }
}