@Entry
@Component
struct Index {
  private readonly primary: string = '#6D4C41'
  private readonly secondary: string = '#A1887F'
  private readonly surfaceVariant: string = '#FAFAFA'
  private readonly lineColor: string = '#EEEEEE'
  private readonly backgroundTint: string = '#F5F5F5'
  private readonly teaLeafDetail: string = '#8D6E63'
  private readonly favoriteTint: string = '#FFCDD2'
  private readonly textSecondary: string = '#808080'
  private readonly textPrimary: string = '#000000'
  private readonly ringSize: number = 220

  build() {
    Stack() {
      Column() {
        this.HeaderSection()
        this.TeaSelectionCard()
        this.TimerDisplay('02:00')
        this.ControlButtons()
        Blank()
        this.PreparationSteps()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(this.textSecondary)
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)
      .height(52)
      .justifyContent(FlexAlign.Center)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(23)
          .fontColor(this.textPrimary)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(this.backgroundTint)
    }
    .width('100%')
    .padding({ bottom: 32 })
  }

  @Builder
  TeaSelectionCard() {
    Row() {
      Stack() {
        Circle()
          .width(60)
          .height(60)
          .fill('#EFEBE9')
        this.CustomLeafIcon()
      }
      .width(60)
      .height(60)

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(this.teaLeafDetail)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      Text('♥')
        .fontSize(26)
        .fontColor(this.favoriteTint)
    }
    .width('100%')
    .padding(20)
    .borderRadius(24)
    .backgroundColor(this.surfaceVariant)
    .border({ width: 1, color: this.lineColor })
    .margin({ bottom: 32 })
  }

  @Builder
  CustomLeafIcon() {
    Stack() {
      Circle()
        .width(30)
        .height(30)
        .fill(Color.Transparent)
        .stroke(this.primary)
        .strokeWidth(2)
      Rect()
        .width(2)
        .height(16)
        .radius(1)
        .fill(this.primary)
    }
    .width(30)
    .height(30)
  }

  @Builder
  TimerDisplay(time: string) {
    Stack() {
      Circle()
        .width(this.ringSize)
        .height(this.ringSize)
        .fill(Color.Transparent)
        .stroke(this.backgroundTint)
        .strokeWidth(12)
      Progress({ value: 66, total: 100, type: ProgressType.Ring })
        .width(this.ringSize)
        .height(this.ringSize)
        .color(this.primary)
        .backgroundColor(this.backgroundTint)
        .style({ strokeWidth: 12 })
      Column() {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textSecondary)
          .letterSpacing(2)
        Text(time)
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.textPrimary)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(this.ringSize)
    .height(this.ringSize)
    .margin({ bottom: 40 })
  }

  @Builder
  ControlButtons() {
    Row() {
      this.IconCircleButton('↺')
      Button() {
        Row() {
          Text('▶')
            .fontSize(18)
            .fontColor(Color.White)
          Text('Start')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor(this.primary)
      .margin({ left: 24, right: 24 })
      this.IconCircleButton('+')
    }
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  IconCircleButton(label: string) {
    Button() {
      Text(label)
        .fontSize(24)
        .fontColor('#808080')
    }
    .width(60)
    .height(60)
    .borderRadius(30)
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#E0E0E0' })
  }

  @Builder
  PreparationSteps() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#999999')
        .margin({ bottom: 12 })
      this.StepItem('1', 'Boil fresh water to 95°C')
      Divider().color(this.backgroundTint)
      this.StepItem('2', 'Add 1 tsp of loose leaf per cup')
      Divider().color(this.backgroundTint)
      this.StepItem('3', 'Pour water and wait for timer')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ bottom: 24 })
  }

  @Builder
  StepItem(step: string, text: string) {
    Row() {
      Text(step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textPrimary)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor(this.backgroundTint)
        .borderRadius(12)
      Text(text)
        .fontSize(14)
        .fontColor('#808080')
        .margin({ left: 12 })
        .layoutWeight(1)
      Text('✓')
        .fontSize(12)
        .fontColor(this.lineColor)
    }
    .width('100%')
    .height(40)
  }
}