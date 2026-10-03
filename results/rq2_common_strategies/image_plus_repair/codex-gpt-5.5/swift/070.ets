interface ColorPalette {
  background: string
  card: string
  headerCircle: string
  purpleActive: string
  purpleInactive: string
  textDark: string
  textGray: string
  buttonPink: string
  buttonText: string
  border: string
}

const COLORS: ColorPalette = {
  background: '#FBFBFE',
  card: '#F5F3FD',
  headerCircle: '#EEE9FC',
  purpleActive: '#A07CFF',
  purpleInactive: '#EBE7F6',
  textDark: '#111827',
  textGray: '#6B7280',
  buttonPink: '#F4AECF',
  buttonText: '#2D0D1B',
  border: '#C4B5FD'
}

@Entry
@Component
struct LeaseWizardApp {
  build() {
    Column() {
      this.header()

      Scroll() {
        this.scrollContent()
      }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  private header() {
    Row() {
      Circle()
        .width(44)
        .height(44)
        .fill(COLORS.headerCircle)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('LeaseWizard')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Guided handoff')
          .fontSize(13)
          .fontColor(COLORS.textGray)
      }

      Blank()
        .layoutWeight(1)

      Circle()
        .width(44)
        .height(44)
        .fill(COLORS.headerCircle)
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
  }

  @Builder
  private scrollContent() {
    Column({ space: 24 }) {
      this.stepsCard()
      this.formCard()
    }
    .width('100%')
    .padding({ left: 16, right: 16, bottom: 40 })
  }

  @Builder
  private stepsCard() {
    Column({ space: 20 }) {
      Text('Steps')
        .width('100%')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.textDark)

      Column() {
        this.stepRow('1', 'Profile', 'Tenant basics', 'Edit', true, false)
        this.stepRow('2', 'Income', 'Proof details', 'Edit', true, false)
        this.stepRow('3', 'References', 'Upload letters', 'Go', false, false)
        this.stepRow('4', 'Summary', 'Confirm submission', 'Go', false, true)
      }
      .width('100%')
    }
    .width('100%')
    .padding(24)
    .backgroundColor(COLORS.card)
    .borderRadius(24)
  }

  @Builder
  private stepRow(
    step: string,
    title: string,
    subtitle: string,
    buttonText: string,
    active: boolean,
    last: boolean
  ) {
    Row({ space: 16 }) {
      Column() {
        Text(step)
          .width(32)
          .height(32)
          .textAlign(TextAlign.Center)
          .fontSize(14)
          .fontColor(active ? '#000000' : COLORS.textDark)
          .backgroundColor(active ? COLORS.purpleActive : COLORS.purpleInactive)
          .borderRadius(16)

        if (!last) {
          Divider()
            .vertical(true)
            .width(2)
            .height(40)
            .color(COLORS.headerCircle)
        }
      }
      .width(32)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.textDark)
          .margin({ top: 4 })
        Text(subtitle)
          .fontSize(15)
          .fontColor(COLORS.textGray)
        Blank()
          .height(24)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button(buttonText)
        .width(60)
        .height(36)
        .fontSize(14)
        .fontColor(COLORS.buttonText)
        .backgroundColor(COLORS.buttonPink)
        .borderRadius(8)
        .margin({ top: 2 })
        .onClick(() => {})
    }
    .width('100%')
  }

  @Builder
  private formCard() {
    Column({ space: 25 }) {
      Text('Form')
        .width('100%')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.textDark)

      this.floatingField('Full name', 'Avery Tenant')
      this.floatingField('Contact', 'avery@example.com')

      Blank()
        .height(10)
    }
    .width('100%')
    .padding(24)
    .backgroundColor(COLORS.card)
    .borderRadius(24)
  }

  @Builder
  private floatingField(label: string, value: string) {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        Text(value)
          .fontSize(18)
          .fontColor(COLORS.textDark)
          .layoutWeight(1)
      }
      .width('100%')
      .height(74)
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .border({
        width: 1,
        color: COLORS.border,
        radius: 12
      })

      Text(label)
        .fontSize(14)
        .fontColor(COLORS.textGray)
        .backgroundColor(COLORS.card)
        .padding({ left: 4, right: 4 })
        .margin({ left: 12, top: -10 })
    }
    .width('100%')
    .height(74)
  }
}
