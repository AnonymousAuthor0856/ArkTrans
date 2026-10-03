@Entry
@Component
struct Index {
  build() {
    Column() {
      HeaderSection()
      Blank().height(32)
      TeaSelectionCard()
      Blank().height(32)
      TimerDisplay({ time: '02:00' })
      Blank().height(40)
      ControlButtons()
      Blank().layoutWeight(1)
      PreparationSteps()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Good Morning,').fontSize(14).fontColor('#888888')
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      Button({ type: ButtonType.Circle }) {
        Text('⚙').fontSize(24).fontColor('#000000')
      }
      .width(48).height(48)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row() {
      Stack() {
        Text('🍃').fontSize(30).fontColor('#6D4C41')
      }
      .width(60).height(60)
      .borderRadius(30)
      .backgroundColor('#EFEBE9')
      .alignContent(Alignment.Center)

      Blank().width(16)

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor('#8D6E63')
      }
      .layoutWeight(1)

      Text('♥').fontSize(24).fontColor('#FFCDD2')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TimerDisplay {
  @Prop time: string = ''

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Progress({ value: 67, total: 100, type: ProgressType.Ring })
        .width(220).height(220)
        .color('#6D4C41')
        .backgroundColor('#F5F5F5')
        .style({ strokeWidth: 12 })

      Column() {
        Text('Steeping')
          .fontSize(12)
          .fontColor('#888888')
          .letterSpacing(2)
        Text(this.time)
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220).height(220)
  }
}

@Component
struct ControlButtons {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Text('↻').fontSize(24).fontColor('#888888')
      }
      .width(60).height(60)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E0E0E0' })

      Blank().width(24)

      Button({ type: ButtonType.Normal }) {
        Row() {
          Text('▶').fontSize(20).fontColor('#FFFFFF').margin({ right: 8 })
          Text('Start').fontSize(16).fontColor('#FFFFFF')
        }
      }
      .width(120).height(60)
      .backgroundColor('#6D4C41')
      .borderRadius(24)

      Blank().width(24)

      Button({ type: ButtonType.Circle }) {
        Text('+').fontSize(24).fontColor('#888888')
      }
      .width(60).height(60)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E0E0E0' })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#CCCCCC')
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .width('100%')
  }
}

@Component
struct StepItem {
  @Prop step: string = ''
  @Prop text: string = ''

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.step)
            .fontSize(11)
            .fontColor('#000000')
            .fontWeight(FontWeight.Bold)
        }
        .width(24).height(24)
        .borderRadius(12)
        .backgroundColor('#F5F5F5')
        .alignContent(Alignment.Center)

        Blank().width(12)

        Text(this.text)
          .fontSize(14)
          .fontColor('#444444')

        Blank().layoutWeight(1)

        Text('✓').fontSize(16).fontColor('#EEEEEE')
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      Divider().color('#FAFAFA').strokeWidth(1)
    }
  }
}
