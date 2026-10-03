class TeaColors {
  static primary: string = '#6D4C41';
  static secondary: string = '#A1887F';
  static surfaceVariant: string = '#FAFAFA';
  static outline: string = '#EEEEEE';
  static backgroundTint: string = '#F5F5F5';
  static teaLeafDetail: string = '#8D6E63';
  static favoriteTint: string = '#FFCDD2';
  static textSecondary: string = '#808080';
  static textPrimary: string = '#000000';
}

@Entry
@Component
struct TeaBrewingScreen {
  @Builder
  private HeaderSection() {
    Row() {
      Column({ space: 2 }) {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(TeaColors.textSecondary)
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button('⚙')
        .width(48)
        .height(48)
        .fontSize(24)
        .fontColor(TeaColors.textPrimary)
        .backgroundColor(TeaColors.backgroundTint)
        .borderRadius(24)
    }
    .width('100%')
  }

  @Builder
  private LeafIcon() {
    Stack() {
      Circle()
        .width(30)
        .height(30)
        .fill(Color.Transparent)
        .stroke(TeaColors.primary)
        .strokeWidth(2)
      Rect()
        .width(2)
        .height(16)
        .fill(TeaColors.primary)
        .radius(1)
    }
    .width(30)
    .height(30)
  }

  @Builder
  private TeaSelectionCard() {
    Row({ space: 16 }) {
      Stack() {
        Circle()
          .width(60)
          .height(60)
          .fill('#EFEBE9')
        this.LeafIcon()
      }
      .width(60)
      .height(60)

      Column({ space: 2 }) {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(TeaColors.teaLeafDetail)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('♥')
        .fontSize(24)
        .fontColor(TeaColors.favoriteTint)
    }
    .padding(20)
    .width('100%')
    .backgroundColor(TeaColors.surfaceVariant)
    .borderRadius(24)
    .border({ width: 1, color: TeaColors.outline })
  }

  @Builder
  private TimerDisplay(time: string) {
    Stack() {
      Circle()
        .width(220)
        .height(220)
        .fill(Color.Transparent)
        .stroke(TeaColors.backgroundTint)
        .strokeWidth(12)
      Progress({ value: 66, total: 100, type: ProgressType.Ring })
        .width(220)
        .height(220)
        .color(TeaColors.primary)
        .style({ strokeWidth: 12, scaleCount: 120, scaleWidth: 12 })
      Column({ space: 4 }) {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(TeaColors.textSecondary)
        Text(time)
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TeaColors.textPrimary)
      }
    }
    .width(220)
    .height(220)
  }

  @Builder
  private ControlButtons() {
    Row({ space: 24 }) {
      Button('↺')
        .width(60)
        .height(60)
        .fontSize(24)
        .fontColor('#808080')
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(30)
      Button('▶  Start')
        .width(120)
        .height(60)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .backgroundColor(TeaColors.primary)
        .borderRadius(24)
      Button('+')
        .width(60)
        .height(60)
        .fontSize(24)
        .fontColor('#808080')
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(30)
    }
  }

  @Builder
  private StepItem(step: string, text: string) {
    Row({ space: 12 }) {
      Text(step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(TeaColors.textPrimary)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor(TeaColors.backgroundTint)
        .borderRadius(12)
      Text(text)
        .fontSize(14)
        .fontColor('#808080')
      Blank()
      Text('✓')
        .fontSize(12)
        .fontColor(TeaColors.outline)
    }
    .padding({ top: 8, bottom: 8 })
    .width('100%')
  }

  @Builder
  private PreparationSteps() {
    Column({ space: 0 }) {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080CC')
        .padding({ bottom: 12 })
        .width('100%')
        .textAlign(TextAlign.Start)
      this.StepItem('1', 'Boil fresh water to 95°C')
      Divider().color(TeaColors.backgroundTint)
      this.StepItem('2', 'Add 1 tsp of loose leaf per cup')
      Divider().color(TeaColors.backgroundTint)
      this.StepItem('3', 'Pour water and wait for timer')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.HeaderSection()
          .padding({ top: 24, bottom: 32 })
        this.TeaSelectionCard()
          .padding({ bottom: 32 })
        this.TimerDisplay('02:00')
          .padding({ bottom: 40 })
        this.ControlButtons()
        Blank()
        this.PreparationSteps()
          .padding({ bottom: 24 })
      }
      .padding({ left: 24, right: 24 })
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
