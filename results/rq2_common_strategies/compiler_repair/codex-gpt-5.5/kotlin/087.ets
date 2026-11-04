class StepData {
  step: string
  text: string

  constructor(step: string, text: string) {
    this.step = step
    this.text = text
  }
}

@Entry
@Component
struct Index {
  private steps: StepData[] = [
    new StepData('1', 'Boil fresh water to 95°C'),
    new StepData('2', 'Add 1 tsp of loose leaf per cup'),
    new StepData('3', 'Pour water and wait for timer')
  ]

  build() {
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
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(Color.Gray)
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('⚙')
        .fontSize(24)
        .fontColor(Color.Black)
        .backgroundColor('#F5F5F5')
        .borderRadius(24)
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TeaSelectionCard() {
    Row() {
      Stack() {
        Circle()
          .width(60)
          .height(60)
          .fill('#EFEBE9')
        Circle()
          .width(30)
          .height(30)
          .fill(Color.Transparent)
          .stroke('#6D4C41')
          .strokeWidth(2)
        Rect()
          .width(2)
          .height(22)
          .fill('#6D4C41')
      }
      .width(60)
      .height(60)

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Black Tea • 95°C')
          .fontSize(13)
          .fontColor('#8D6E63')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Text('♥')
        .fontSize(24)
        .fontColor('#FFCDD2')
    }
    .width('100%')
    .padding(20)
    .border({ width: 1, color: '#EEEEEE', radius: 24 })
    .backgroundColor('#FAFAFA')
    .alignItems(VerticalAlign.Center)
    .margin({ top: 32 })
  }

  @Builder
  TimerDisplay(time: string) {
    Stack() {
      Circle()
        .width(220)
        .height(220)
        .fill(Color.Transparent)
        .stroke('#F5F5F5')
        .strokeWidth(12)
      Circle()
        .width(184)
        .height(184)
        .fill(Color.Transparent)
        .stroke('#6D4C41')
        .strokeWidth(12)
      Column() {
        Text('Steeping')
          .fontSize(13)
          .fontColor(Color.Gray)
        Text(time)
          .fontSize(48)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
    .margin({ top: 32 })
  }

  @Builder
  ControlButtons() {
    Row() {
      Button('↻')
        .fontSize(24)
        .fontColor(Color.Gray)
        .width(60)
        .height(60)
        .borderRadius(30)
        .border({ width: 1, color: '#E0E0E0' })
        .backgroundColor(Color.Transparent)
        .padding(0)

      Button() {
        Row() {
          Text('▶')
            .fontSize(18)
            .fontColor(Color.White)
          Text('Start')
            .fontSize(15)
            .fontColor(Color.White)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor('#6D4C41')
      .margin({ left: 24, right: 24 })

      Button('+')
        .fontSize(24)
        .fontColor(Color.Gray)
        .width(60)
        .height(60)
        .borderRadius(30)
        .border({ width: 1, color: '#E0E0E0' })
        .backgroundColor(Color.Transparent)
        .padding(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 40 })
  }

  @Builder
  PreparationSteps() {
    Column() {
      Text('PREPARATION')
        .width('100%')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#CFCFCF')
        .margin({ bottom: 12 })
      ForEach(this.steps, (item: StepData) => {
        this.StepItem(item)
      })
    }
    .width('100%')
  }

  @Builder
  StepItem(item: StepData) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill('#F5F5F5')
          Text(item.step)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        Text(item.text)
          .fontSize(14)
          .fontColor('#444444')
          .layoutWeight(1)
          .margin({ left: 12 })
        Text('✓')
          .fontSize(16)
          .fontColor('#EEEEEE')
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ top: 8, bottom: 8 })
      Divider()
        .color('#FAFAFA')
    }
    .width('100%')
  }
}
