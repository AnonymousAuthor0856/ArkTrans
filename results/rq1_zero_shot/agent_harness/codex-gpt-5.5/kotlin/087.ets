@Entry
@Component
struct MainActivity {
  private steps: string[] = ['Boil fresh water to 95°C', 'Add 1 tsp of loose leaf per cup', 'Pour water and wait for timer'];

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor('#808080')
        Text('Tea Master')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Text('⚙')
        .fontSize(24)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(48)
        .height(48)
        .lineHeight(48)
        .backgroundColor('#F5F5F5')
        .borderRadius(24)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TeaSelectionCard() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle().width(60).height(60).fill('#EFEBE9')
        Circle().width(30).height(30).fill(Color.Transparent).stroke('#6D4C41').strokeWidth(2)
        Blank().width(2).height(18).backgroundColor('#6D4C41').borderRadius(1)
      }
      .width(60)
      .height(60)

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
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      Text('♥')
        .fontSize(24)
        .fontColor('#FFCDD2')
    }
    .width('100%')
    .padding(20)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: 1, color: '#EEEEEE' })
  }

  @Builder
  TimerDisplay() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(220)
        .height(220)
        .fill(Color.Transparent)
        .stroke('#F5F5F5')
        .strokeWidth(12)
      Circle()
        .width(196)
        .height(196)
        .fill(Color.Transparent)
        .stroke('#6D4C41')
        .strokeWidth(12)
      Column() {
        Text('Steeping')
          .fontSize(12)
          .fontColor('#808080')
        Text('02:00')
          .fontSize(44)
          .fontWeight(FontWeight.Light)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }

  @Builder
  ControlButtons() {
    Row() {
      Text('↻')
        .fontSize(24)
        .fontColor('#808080')
        .textAlign(TextAlign.Center)
        .width(60)
        .height(60)
        .lineHeight(60)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(30)

      Button('▶  Start')
        .fontSize(14)
        .fontColor('#FFFFFF')
        .width(120)
        .height(60)
        .backgroundColor('#6D4C41')
        .borderRadius(24)
        .margin({ left: 24, right: 24 })

      Text('+')
        .fontSize(24)
        .fontColor('#808080')
        .textAlign(TextAlign.Center)
        .width(60)
        .height(60)
        .lineHeight(60)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(30)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StepItem(step: string, text: string) {
    Row() {
      Text(step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(24)
        .height(24)
        .lineHeight(24)
        .backgroundColor('#F5F5F5')
        .borderRadius(12)
      Text(text)
        .fontSize(14)
        .fontColor('#444444')
        .layoutWeight(1)
        .margin({ left: 12 })
      Text('✓')
        .fontSize(16)
        .fontColor('#EEEEEE')
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  PreparationSteps() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3')
        .width('100%')
        .margin({ bottom: 12 })
      ForEach(this.steps, (text: string, index: number) => {
        this.StepItem(`${index + 1}`, text)
        Divider().color('#FAFAFA')
      })
    }
    .width('100%')
  }

  build() {
    Column() {
      this.HeaderSection()
      Blank().height(32)
      this.TeaSelectionCard()
      Blank().height(32)
      this.TimerDisplay()
      Blank().height(40)
      this.ControlButtons()
      Blank().layoutWeight(1)
      this.PreparationSteps()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}
