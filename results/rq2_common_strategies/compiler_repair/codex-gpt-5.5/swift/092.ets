@Entry
@Component
struct Index {
  private readonly zenGreen: string = '#6A8E6A'
  private readonly zenGreenLight: string = '#E8F5E9'
  private readonly zenBrown: string = '#8D6E63'
  private readonly zenTextPrimary: string = '#2C3E50'
  private readonly zenTextSecondary: string = '#7F8C8D'
  private readonly zenAccent: string = '#D4E157'
  private readonly statusItemBg: string = '#F7F9F9'
  private readonly statusItemBorder: string = '#ECEFF1'
  private readonly careLogBg: string = '#FAFAFA'
  private readonly careLogBorder: string = '#F0F0F0'
  private readonly careLogSubtitle: string = '#9E9E9E'
  private readonly navIconInactive: string = '#CFD8DC'
  private readonly bottomBarDivider: string = '#F5F5F5'
  private readonly lightGrayCircle: string = '#E0E0E0'
  private readonly trunkColor: string = '#5D4037'
  private readonly healthRed: string = '#E57373'
  private readonly waterBlue: string = '#64B5F6'

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
          Blank().height(104)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24 })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .scrollBar(BarState.Off)
      this.SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
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
  }

  @Builder
  BonsaiVisual() {
    Stack() {
      Rect()
        .width(110)
        .height(33)
        .fill(this.zenBrown)
        .offset({ y: 82 })
      Rect()
        .width(130)
        .height(15)
        .fill('#CC8D6E63')
        .offset({ y: 74 })
      Rect()
        .width(25)
        .height(95)
        .radius(13)
        .fill(this.trunkColor)
        .rotate({ angle: -28 })
        .offset({ x: -4, y: 36 })
      Rect()
        .width(18)
        .height(70)
        .radius(9)
        .fill(this.trunkColor)
        .rotate({ angle: 38 })
        .offset({ x: 22, y: -12 })
      Rect()
        .width(15)
        .height(45)
        .radius(8)
        .fill(this.trunkColor)
        .rotate({ angle: -55 })
        .offset({ x: -43, y: 14 })
      Circle()
        .width(90)
        .height(90)
        .fill(this.zenGreen)
        .offset({ x: 22, y: -56 })
      Circle()
        .width(70)
        .height(70)
        .fill('#CC6A8E6A')
        .offset({ x: 60, y: -48 })
      Circle()
        .width(60)
        .height(60)
        .fill('#E66A8E6A')
        .offset({ x: 12, y: -72 })
      Circle()
        .width(70)
        .height(70)
        .fill(this.zenGreen)
        .offset({ x: -30, y: 0 })
      Circle()
        .width(50)
        .height(50)
        .fill('#CC6A8E6A')
        .offset({ x: -45, y: -12 })
      Circle()
        .width(50)
        .height(50)
        .fill(this.zenGreen)
        .offset({ x: -62, y: -18 })
    }
    .width(220)
    .height(220)
  }

  @Builder
  StatusRow() {
    Row() {
      this.StatusItem('♥', 'Health', '98%', this.healthRed)
      Blank()
      this.StatusItem('▣', 'Age', '4 Yrs', this.zenBrown)
      Blank()
      this.StatusItem('✓', 'Water', '2 Days', this.waterBlue)
    }
    .width('100%')
  }

  @Builder
  StatusItem(icon: string, label: string, value: string, tint: string) {
    Column() {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill(this.statusItemBg)
          .stroke(this.statusItemBorder)
          .strokeWidth(1)
        Text(icon)
          .fontSize(24)
          .fontColor(tint)
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
  }

  @Builder
  ActivityLogSection() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.zenTextPrimary)
        Blank()
        Stack() {
          Circle()
            .width(28)
            .height(28)
            .fill(this.zenGreenLight)
          Text('+')
            .fontSize(20)
            .fontColor(this.zenGreen)
        }
        .width(28)
        .height(28)
      }
      .width('100%')
      Blank().height(16)
      this.CareLogItem('Watering', 'Today, 8:00 AM', true)
      Blank().height(12)
      this.CareLogItem('Pruning', 'Tomorrow', false)
      Blank().height(12)
      this.CareLogItem('Fertilizer', 'In 5 days', false)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CareLogItem(title: string, subtitle: string, isDone: boolean) {
    Row() {
      Circle()
        .width(12)
        .height(12)
        .fill(isDone ? this.zenGreen : this.lightGrayCircle)
      Column() {
        Text(title)
          .fontSize(14)
          .fontColor(isDone ? this.zenTextPrimary : this.zenTextSecondary)
        Text(subtitle)
          .fontSize(11)
          .fontColor(this.careLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })
      if (isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor(this.zenGreen)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.careLogBg)
    .borderRadius(12)
    .border({ width: 1, color: this.careLogBorder })
  }

  @Builder
  SimpleBottomNav() {
    Column() {
      Rect()
        .width('100%')
        .height(1)
        .fill(this.bottomBarDivider)
      Row() {
        this.NavIcon('⌂', true)
        this.NavIcon('i', false)
        this.NavIcon('⚙', false)
      }
      .width('100%')
      .height(80)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  NavIcon(icon: string, isSelected: boolean) {
    Column() {
      Text(icon)
        .fontSize(28)
        .fontColor(isSelected ? this.zenGreen : this.navIconInactive)
      if (isSelected) {
        Blank().height(4)
        Circle()
          .width(4)
          .height(4)
          .fill(this.zenGreen)
      }
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}