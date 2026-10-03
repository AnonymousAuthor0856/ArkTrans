class ZenColors {
  static green: string = '#6A8E6A';
  static greenLight: string = '#E8F5E9';
  static brown: string = '#8D6E63';
  static textPrimary: string = '#2C3E50';
  static textSecondary: string = '#7F8C8D';
  static white: string = '#FFFFFF';
  static accent: string = '#D4E157';
  static statusItemBg: string = '#F7F9F9';
  static statusItemBorder: string = '#ECEFF1';
  static careLogBg: string = '#FAFAFA';
  static careLogBorder: string = '#F0F0F0';
  static careLogSubtitle: string = '#9E9E9E';
  static navIconInactive: string = '#CFD8DC';
  static bottomBarDivider: string = '#F5F5F5';
  static lightGrayCircle: string = '#E0E0E0';
  static trunkColor: string = '#5D4037';
  static healthRed: string = '#E57373';
  static waterBlue: string = '#64B5F6';
}

@Entry
@Component
struct ZenBonsaiAppView {
  @Builder
  private HeaderSection() {
    Column({ space: 0 }) {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ZenColors.textSecondary)
      Blank().height(8)
      Text('Zen Garden')
        .fontSize(36)
        .fontWeight(FontWeight.Lighter)
        .fontColor(ZenColors.textPrimary)
    }
  }

  @Builder
  private BonsaiVisual() {
    Stack() {
      Rect()
        .width(110)
        .height(33)
        .fill(ZenColors.brown)
        .position({ x: '50%', y: '92%' })
      Rect()
        .width(130)
        .height(15)
        .fill('#8D6E63CC')
        .position({ x: '50%', y: '85%' })
      Rect()
        .width(25)
        .height(95)
        .fill(ZenColors.trunkColor)
        .radius(13)
        .rotate({ angle: -22 })
        .position({ x: '47%', y: '62%' })
      Rect()
        .width(15)
        .height(70)
        .fill(ZenColors.trunkColor)
        .radius(8)
        .rotate({ angle: 42 })
        .position({ x: '58%', y: '45%' })
      Rect()
        .width(15)
        .height(50)
        .fill(ZenColors.trunkColor)
        .radius(8)
        .rotate({ angle: -50 })
        .position({ x: '34%', y: '50%' })
      Circle()
        .width(90)
        .height(90)
        .fill(ZenColors.green)
        .position({ x: '60%', y: '25%' })
      Circle()
        .width(70)
        .height(70)
        .fill('#6A8E6ACC')
        .position({ x: '68%', y: '28%' })
      Circle()
        .width(60)
        .height(60)
        .fill('#6A8E6AE6')
        .position({ x: '55%', y: '22%' })
      Circle()
        .width(70)
        .height(70)
        .fill(ZenColors.green)
        .position({ x: '35%', y: '50%' })
      Circle()
        .width(50)
        .height(50)
        .fill('#6A8E6ACC')
        .position({ x: '30%', y: '45%' })
      Circle()
        .width(50)
        .height(50)
        .fill(ZenColors.green)
        .position({ x: '22%', y: '42%' })
    }
    .width(220)
    .height(220)
  }

  @Builder
  private StatusItem(icon: string, label: string, value: string, tint: string) {
    Column({ space: 0 }) {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill(ZenColors.statusItemBg)
          .stroke(ZenColors.statusItemBorder)
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
        .fontColor(ZenColors.textPrimary)
      Text(label)
        .fontSize(11)
        .fontColor(ZenColors.textSecondary)
    }
  }

  @Builder
  private StatusRow() {
    Row() {
      Blank()
      this.StatusItem('♥', 'Health', '98%', ZenColors.healthRed)
      Blank()
      this.StatusItem('□', 'Age', '4 Yrs', ZenColors.brown)
      Blank()
      this.StatusItem('✓', 'Water', '2 Days', ZenColors.waterBlue)
      Blank()
    }
    .width('100%')
  }

  @Builder
  private CareLogItem(title: string, subtitle: string, isDone: boolean) {
    Row({ space: 0 }) {
      Circle()
        .width(12)
        .height(12)
        .fill(isDone ? ZenColors.green : ZenColors.lightGrayCircle)
      Blank().width(16)
      Column({ space: 0 }) {
        Text(title)
          .fontSize(14)
          .fontColor(isDone ? ZenColors.textPrimary : ZenColors.textSecondary)
        Text(subtitle)
          .fontSize(11)
          .fontColor(ZenColors.careLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      if (isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor(ZenColors.green)
      }
    }
    .padding(16)
    .width('100%')
    .backgroundColor(ZenColors.careLogBg)
    .borderRadius(12)
    .border({ width: 1, color: ZenColors.careLogBorder })
  }

  @Builder
  private ActivityLogSection() {
    Column({ space: 0 }) {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(ZenColors.textPrimary)
        Blank()
        Text('+')
          .fontSize(20)
          .fontColor(ZenColors.green)
          .width(28)
          .height(28)
          .textAlign(TextAlign.Center)
          .backgroundColor(ZenColors.greenLight)
          .borderRadius(14)
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
  private NavIcon(icon: string, isSelected: boolean) {
    Column({ space: 0 }) {
      Text(icon)
        .fontSize(28)
        .fontColor(isSelected ? ZenColors.green : ZenColors.navIconInactive)
      if (isSelected) {
        Blank().height(4)
        Circle()
          .width(4)
          .height(4)
          .fill(ZenColors.green)
      }
    }
    .layoutWeight(1)
  }

  @Builder
  private SimpleBottomNav() {
    Column({ space: 0 }) {
      Rect()
        .width('100%')
        .height(1)
        .fill(ZenColors.bottomBarDivider)
      Row({ space: 0 }) {
        this.NavIcon('⌂', true)
        this.NavIcon('i', false)
        this.NavIcon('⚙', false)
      }
      .width('100%')
      .height(80)
      .backgroundColor(ZenColors.white)
    }
    .width('100%')
  }

  build() {
    Stack() {
      Scroll() {
        Column({ space: 0 }) {
          this.HeaderSection()
            .padding({ top: 24 })
          Blank().height(32)
          this.BonsaiVisual()
          Blank().height(32)
          this.StatusRow()
          Blank().height(32)
          this.ActivityLogSection()
            .padding({ bottom: 24 })
        }
        .padding({ left: 24, right: 24, bottom: 80 })
        .width('100%')
        .backgroundColor(ZenColors.white)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor(ZenColors.white)

      Column() {
        Blank()
        this.SimpleBottomNav()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenColors.white)
  }
}
