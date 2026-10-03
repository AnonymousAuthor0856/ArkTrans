@Entry
@Component
struct ZenBonsaiPage {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          HeaderSection()
            .margin({ top: 24 })

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
            .margin({ bottom: 24 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 80 })
        .backgroundColor(Color.White)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .scrollBar(BarState.Off)

      SimpleBottomNav()
        .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - Color Constants
class ZenColors {
  static readonly zenGreen: ResourceColor = '#6A8E6A'
  static readonly zenGreenLight: ResourceColor = '#E8F5E9'
  static readonly zenBrown: ResourceColor = '#8D6E63'
  static readonly zenTextPrimary: ResourceColor = '#2C3E50'
  static readonly zenTextSecondary: ResourceColor = '#7F8C8D'
  static readonly zenWhite: ResourceColor = '#FFFFFF'
  static readonly zenAccent: ResourceColor = '#D4E157'
  static readonly statusItemBg: ResourceColor = '#F7F9F9'
  static readonly statusItemBorder: ResourceColor = '#ECEFF1'
  static readonly careLogBg: ResourceColor = '#FAFAFA'
  static readonly careLogBorder: ResourceColor = '#F0F0F0'
  static readonly careLogSubtitle: ResourceColor = '#9E9E9E'
  static readonly navIconInactive: ResourceColor = '#CFD8DC'
  static readonly bottomBarDivider: ResourceColor = '#F5F5F5'
  static readonly lightGrayCircle: ResourceColor = '#E0E0E0'
  static readonly trunkColor: ResourceColor = '#5D4037'
  static readonly healthRed: ResourceColor = '#E57373'
  static readonly waterBlue: ResourceColor = '#64B5F6'
}

// MARK: - HeaderSection
@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ZenColors.zenTextSecondary)
        .letterSpacing(2)

      Blank()
        .height(8)

      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Lighter)
        .fontColor(ZenColors.zenTextPrimary)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - StatusRow
@Component
struct StatusRow {
  build() {
    Row() {
      Blank()

      StatusItem({ iconName: 'heart', label: 'Health', value: '98%', tint: ZenColors.healthRed })

      Blank()

      StatusItem({ iconName: 'calendar', label: 'Age', value: '4 Yrs', tint: ZenColors.zenBrown })

      Blank()

      StatusItem({ iconName: 'check_circle', label: 'Water', value: '2 Days', tint: ZenColors.waterBlue })

      Blank()
    }
    .width('100%')
  }
}

// MARK: - StatusItem
@Component
struct StatusItem {
  @Prop iconName: string = ''
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop tint: ResourceColor = Color.Black

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 50, height: 50 })
          .fill(ZenColors.statusItemBg)
          .stroke({ color: ZenColors.statusItemBorder, width: 1 })

        Text($r('sys.symbol.' + this.iconName))
          .fontSize(24)
          .fontColor(this.tint)
      }
      .width(50)
      .height(50)

      Blank()
        .height(8)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZenColors.zenTextPrimary)

      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Normal)
        .fontColor(ZenColors.zenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - ActivityLogSection
@Component
struct ActivityLogSection {
  build() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ZenColors.zenTextPrimary)

        Blank()

        Text($r('sys.symbol.plus'))
          .fontSize(20)
          .fontColor(ZenColors.zenGreen)
          .padding(4)
          .backgroundColor(ZenColors.zenGreenLight)
          .borderRadius(14)
          .width(28)
          .height(28)
          .textAlign(TextAlign.Center)
          .onClick(() => {})
      }
      .width('100%')

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
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - CareLogItem
@Component
struct CareLogItem {
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop isDone: boolean = false

  build() {
    Row() {
      Circle({ width: 12, height: 12 })
        .fill(this.isDone ? ZenColors.zenGreen : ZenColors.lightGrayCircle)

      Blank()
        .width(16)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.isDone ? ZenColors.zenTextPrimary : ZenColors.zenTextSecondary)

        Text(this.subtitle)
          .fontSize(11)
          .fontColor(ZenColors.careLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor(ZenColors.zenGreen)
          .fontWeight(FontWeight.Bold)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ZenColors.careLogBg)
    .borderRadius(12)
    .border({ width: 1, color: ZenColors.careLogBorder, radius: 12 })
  }
}

// MARK: - SimpleBottomNav
@Component
struct SimpleBottomNav {
  @State selectedIndex: number = 0

  build() {
    Column() {
      Divider()
        .color(ZenColors.bottomBarDivider)
        .strokeWidth(1)

      Row() {
        NavIcon({ iconName: 'home', isSelected: this.selectedIndex === 0 })
          .layoutWeight(1)
          .onClick(() => { this.selectedIndex = 0 })

        NavIcon({ iconName: 'info', isSelected: this.selectedIndex === 1 })
          .layoutWeight(1)
          .onClick(() => { this.selectedIndex = 1 })

        NavIcon({ iconName: 'settings', isSelected: this.selectedIndex === 2 })
          .layoutWeight(1)
          .onClick(() => { this.selectedIndex = 2 })
      }
      .width('100%')
      .height(80)
      .backgroundColor(Color.White)
    }
    .width('100%')
  }
}

// MARK: - NavIcon
@Component
struct NavIcon {
  @Prop iconName: string = ''
  @Prop isSelected: boolean = false

  build() {
    Column() {
      Text($r('sys.symbol.' + this.iconName))
        .fontSize(28)
        .fontColor(this.isSelected ? ZenColors.zenGreen : ZenColors.navIconInactive)

      if (this.isSelected) {
        Blank()
          .height(4)

        Circle({ width: 4, height: 4 })
          .fill(ZenColors.zenGreen)
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

// MARK: - BonsaiVisual
@Component
struct BonsaiVisual {
  build() {
    Canvas(this.bonsaiSettings)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawBonsai()
      })
  }

  private bonsaiSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  private drawBonsai() {
    const ctx = this.bonsaiSettings
    const w = 220
    const h = 220

    // 1. Draw pot
    const potWidth = w * 0.5
    const potHeight = h * 0.15
    const potTop = h * 0.85

    // Pot body
    ctx.fillStyle = '#8D6E63'
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    // Pot rim
    ctx.fillStyle = 'rgba(141, 110, 99, 0.8)'
    ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    // 2. Draw trunk (bezier curves)
    ctx.strokeStyle = '#5D4037'
    ctx.lineWidth = 25
    ctx.lineCap = 'round'
    ctx.beginPath()
    ctx.moveTo(w * 0.5, potTop)
    ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    ctx.stroke()

    // Secondary branch
    ctx.lineWidth = 15
    ctx.beginPath()
    ctx.moveTo(w * 0.38, h * 0.55)
    ctx.lineTo(w * 0.25, h * 0.45)
    ctx.stroke()

    // 3. Draw foliage clusters (circles)
    // Leaf cluster 1 (top-right)
    ctx.fillStyle = '#6A8E6A'
    ctx.beginPath()
    ctx.ellipse(w * 0.6, h * 0.25, 45, 45, 0, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = 'rgba(106, 142, 106, 0.8)'
    ctx.beginPath()
    ctx.ellipse(w * 0.68, h * 0.28, 35, 35, 0, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = 'rgba(106, 142, 106, 0.9)'
    ctx.beginPath()
    ctx.ellipse(w * 0.55, h * 0.22, 30, 30, 0, 0, Math.PI * 2)
    ctx.fill()

    // Leaf cluster 2 (middle-left)
    ctx.fillStyle = '#6A8E6A'
    ctx.beginPath()
    ctx.ellipse(w * 0.35, h * 0.5, 35, 35, 0, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = 'rgba(106, 142, 106, 0.8)'
    ctx.beginPath()
    ctx.ellipse(w * 0.30, h * 0.45, 25, 25, 0, 0, Math.PI * 2)
    ctx.fill()

    // Leaf cluster 3 (far-left branch)
    ctx.fillStyle = '#6A8E6A'
    ctx.beginPath()
    ctx.ellipse(w * 0.22, h * 0.42, 25, 25, 0, 0, Math.PI * 2)
    ctx.fill()
  }
}
