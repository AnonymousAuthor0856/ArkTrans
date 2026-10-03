@Entry
@Component
struct ZenBonsaiAppView {
  private zenGreen: string = '#6A8E6A'
  private zenGreenLight: string = '#E8F5E9'
  private zenBrown: string = '#8D6E63'
  private zenTextPrimary: string = '#2C3E50'
  private zenTextSecondary: string = '#7F8C8D'
  private zenWhite: string = '#FFFFFF'
  private statusItemBg: string = '#F7F9F9'
  private statusItemBorder: string = '#ECEFF1'
  private careLogBg: string = '#FAFAFA'
  private careLogBorder: string = '#F0F0F0'
  private careLogSubtitle: string = '#9E9E9E'
  private navIconInactive: string = '#CFD8DC'
  private bottomBarDivider: string = '#F5F5F5'
  private lightGrayCircle: string = '#E0E0E0'
  private trunkColor: string = '#5D4037'
  private healthRed: string = '#E57373'
  private waterBlue: string = '#64B5F6'
  private bonsaiCanvas: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          this.HeaderSection()
          Blank().height(32)
          this.BonsaiVisual()
          Blank().height(32)
          this.StatusRow()
          Blank().height(32)
          this.ActivityLogSection()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 104 })
        .backgroundColor(this.zenWhite)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.zenWhite)
      .scrollBar(BarState.Off)

      this.SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.zenWhite)
  }

  @Builder
  private HeaderSection() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.zenTextSecondary)
        .letterSpacing(2)
      Blank().height(8)
      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Lighter)
        .fontColor(this.zenTextPrimary)
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
  }

  @Builder
  private StatusRow() {
    Row() {
      this.StatusItem('heart', 'Health', '98%', this.healthRed)
      this.StatusItem('calendar', 'Age', '4 Yrs', this.zenBrown)
      this.StatusItem('water', 'Water', '2 Days', this.waterBlue)
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .width('100%')
  }

  @Builder
  private StatusItem(kind: string, label: string, value: string, tint: string) {
    Column() {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill(this.statusItemBg)
          .stroke(this.statusItemBorder)
          .strokeWidth(1)
        if (kind === 'heart') {
          Text('♥')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(tint)
            .height(34)
        } else if (kind === 'calendar') {
          this.CalendarIcon(tint)
        } else {
          Circle()
            .width(32)
            .height(32)
            .fill(tint)
          Text('✓')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.zenWhite)
            .translate({ y: -1 })
        }
      }
      .width(50)
      .height(50)

      Blank().height(8)
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.zenTextPrimary)
      Text(label)
        .fontSize(11)
        .fontColor(this.zenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
    .width(86)
  }

  @Builder
  private CalendarIcon(tint: string) {
    Column() {
      Stack()
        .width(28)
        .height(6)
        .backgroundColor(tint)
        .borderRadius({ topLeft: 4, topRight: 4 })
      Grid() {
        ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8], (item: number) => {
          GridItem() {
            Circle().width(3).height(3).fill(tint)
          }
        }, (item: number) => item.toString())
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .columnsGap(4)
      .rowsGap(3)
      .width(22)
      .height(18)
      .padding({ top: 3 })
    }
    .width(28)
    .height(28)
    .alignItems(HorizontalAlign.Center)
    .border({ width: 2, color: tint })
    .borderRadius(4)
  }

  @Builder
  private ActivityLogSection() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.zenTextPrimary)
        Blank().layoutWeight(1)
        Stack() {
          Circle().width(28).height(28).fill(this.zenGreenLight)
          Text('+')
            .fontSize(30)
            .fontWeight(FontWeight.Regular)
            .fontColor(this.zenGreen)
            .translate({ y: -2 })
        }
        .width(28)
        .height(28)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank().height(16)
      this.CareLogItem('Watering', 'Today, 8:00 AM', true)
      Blank().height(12)
      this.CareLogItem('Pruning', 'Tomorrow', false)
      Blank().height(12)
      this.CareLogItem('Fertilizer', 'In 5 days', false)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  private CareLogItem(title: string, subtitle: string, isDone: boolean) {
    Row() {
      Circle()
        .width(12)
        .height(12)
        .fill(isDone ? this.zenGreen : this.lightGrayCircle)
      Blank().width(16)
      Column() {
        Text(title)
          .fontSize(14)
          .fontColor(isDone ? this.zenTextPrimary : this.zenTextSecondary)
        Text(subtitle)
          .fontSize(11)
          .fontColor(this.careLogSubtitle)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      if (isDone) {
        Text('✓')
          .fontSize(36)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.zenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.careLogBg)
    .border({ width: 1, color: this.careLogBorder })
    .borderRadius(12)
  }

  @Builder
  private SimpleBottomNav() {
    Column() {
      Divider()
        .height(1)
        .color(this.bottomBarDivider)
      Row() {
        this.NavIcon('home', true)
        this.NavIcon('info', false)
        this.NavIcon('gear', false)
      }
      .width('100%')
      .height(80)
      .backgroundColor(this.zenWhite)
    }
    .width('100%')
    .backgroundColor(this.zenWhite)
  }

  @Builder
  private NavIcon(kind: string, isSelected: boolean) {
    Column() {
      if (kind === 'home') {
        this.HomeIcon(isSelected ? this.zenGreen : this.navIconInactive)
      } else if (kind === 'info') {
        this.InfoIcon(isSelected ? this.zenGreen : this.navIconInactive)
      } else {
        this.GearIcon(isSelected ? this.zenGreen : this.navIconInactive)
      }
      if (isSelected) {
        Blank().height(4)
        Circle().width(4).height(4).fill(this.zenGreen)
      }
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
    .height(80)
  }

  @Builder
  private HomeIcon(color: string) {
    Stack() {
      Text('⌂')
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)
    }
    .width(32)
    .height(32)
  }

  @Builder
  private InfoIcon(color: string) {
    Stack() {
      Circle().width(28).height(28).fill(color)
      Text('i')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.zenWhite)
        .translate({ y: 1 })
    }
    .width(32)
    .height(32)
  }

  @Builder
  private GearIcon(color: string) {
    Text('⚙')
      .fontSize(34)
      .fontColor(color)
      .width(32)
      .height(32)
      .textAlign(TextAlign.Center)
  }

  @Builder
  private BonsaiVisual() {
    Canvas(this.bonsaiCanvas)
      .width(220)
      .height(220)
      .onReady(() => {
        this.drawBonsai()
      })
  }

  private drawBonsai(): void {
    const ctx = this.bonsaiCanvas
    const w = 220
    const h = 220
    const potWidth = w * 0.5
    const potHeight = h * 0.15
    const potTop = h * 0.85

    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = this.zenBrown
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)
    ctx.fillStyle = 'rgba(141, 110, 99, 0.8)'
    ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)

    ctx.beginPath()
    ctx.moveTo(w * 0.5, potTop)
    ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    ctx.strokeStyle = this.trunkColor
    ctx.lineWidth = 25
    ctx.lineCap = 'round'
    ctx.stroke()

    ctx.beginPath()
    ctx.moveTo(w * 0.38, h * 0.55)
    ctx.lineTo(w * 0.25, h * 0.45)
    ctx.strokeStyle = this.trunkColor
    ctx.lineWidth = 15
    ctx.lineCap = 'round'
    ctx.stroke()

    this.fillCircle(ctx, w * 0.6, h * 0.25, 45, this.zenGreen)
    this.fillCircle(ctx, w * 0.68, h * 0.28, 35, 'rgba(106, 142, 106, 0.8)')
    this.fillCircle(ctx, w * 0.55, h * 0.22, 30, 'rgba(106, 142, 106, 0.9)')
    this.fillCircle(ctx, w * 0.35, h * 0.5, 35, this.zenGreen)
    this.fillCircle(ctx, w * 0.3, h * 0.45, 25, 'rgba(106, 142, 106, 0.8)')
    this.fillCircle(ctx, w * 0.22, h * 0.42, 25, this.zenGreen)
  }

  private fillCircle(ctx: CanvasRenderingContext2D, x: number, y: number, radius: number, color: string): void {
    ctx.beginPath()
    ctx.arc(x, y, radius, 0, Math.PI * 2)
    ctx.closePath()
    ctx.fillStyle = color
    ctx.fill()
  }
}
