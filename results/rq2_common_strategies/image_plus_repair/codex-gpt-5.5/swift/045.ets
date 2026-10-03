interface ColorTokens {
  primary: string
  outline: string
  background: string
  surface: string
  surfaceVariant: string
  text: string
  success: string
}

interface SpacingTokens {
  sm: number
  md: number
  lg: number
  xl: number
}

const COLORS: ColorTokens = {
  primary: '#8E6BF2',
  outline: '#D1C4E9',
  background: '#F5F3FF',
  surface: '#FFFFFF',
  surfaceVariant: '#ECE6F8',
  text: '#2E1A47',
  success: '#4CAF50'
}

const SPACING: SpacingTokens = {
  sm: 12,
  md: 20,
  lg: 32,
  xl: 48
}

@Entry
@Component
struct AfterSaleServiceApp {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false
  @State orderFocused: boolean = false
  @State issueFocused: boolean = false

  build() {
    Column({ space: SPACING.lg }) {
      Text('After-Sale Service')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)
        .width('100%')
        .textAlign(TextAlign.Start)

      Column({ space: SPACING.md }) {
        Text('Order ID')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.text)
          .width('100%')
          .textAlign(TextAlign.Start)

        Stack({ alignContent: Alignment.TopStart }) {
          TextInput({
            text: this.orderId,
            placeholder: this.orderFocused ? '' : 'Enter order number'
          })
            .type(InputType.Normal)
            .fontSize(28)
            .fontColor(COLORS.text)
            .placeholderColor('#947FAD')
            .padding({ left: SPACING.md, right: SPACING.md })
            .height(114)
            .width('100%')
            .backgroundColor(COLORS.surfaceVariant)
            .border({
              width: 1,
              color: this.orderFocused ? COLORS.primary : COLORS.outline,
              radius: 14
            })
            .onChange((value: string) => {
              this.orderId = value
            })
            .onFocus(() => {
              this.orderFocused = true
            })
            .onBlur(() => {
              this.orderFocused = false
            })
        }
        .width('100%')

        Text('Issue Description')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.text)
          .width('100%')
          .textAlign(TextAlign.Start)

        Stack({ alignContent: Alignment.TopStart }) {
          TextArea({
            text: this.issue,
            placeholder: this.issueFocused ? '' : 'Describe your issue'
          })
            .fontSize(28)
            .fontColor(COLORS.text)
            .placeholderColor('#947FAD')
            .padding({ left: SPACING.md, right: SPACING.md, top: 20, bottom: 20 })
            .height(240)
            .width('100%')
            .backgroundColor(COLORS.surfaceVariant)
            .border({
              width: 1,
              color: this.issueFocused ? COLORS.primary : COLORS.outline,
              radius: 14
            })
            .textAlign(TextAlign.Start)
            .onChange((value: string) => {
              this.issue = value
            })
            .onFocus(() => {
              this.issueFocused = true
            })
            .onBlur(() => {
              this.issueFocused = false
            })
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 0, right: 0, top: 0, bottom: SPACING.lg })
      .backgroundColor(COLORS.surface)
      .borderRadius(20)
      .shadow({
        radius: 12,
        color: '#35D1C4E9',
        offsetX: 0,
        offsetY: 4
      })

      Button('Submit Request')
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .height(112)
        .width('100%')
        .backgroundColor(COLORS.primary)
        .borderRadius(20)
        .onClick(() => {
          this.submitted = true
        })

      if (this.submitted) {
        Text('Request submitted successfully!')
          .fontSize(28)
          .fontColor(COLORS.success)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding(SPACING.lg)
          .backgroundColor('#264CAF50')
          .borderRadius(14)
      }

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({
      left: SPACING.lg,
      right: SPACING.lg,
      top: 32,
      bottom: SPACING.lg
    })
    .backgroundColor(COLORS.background)
    .alignItems(HorizontalAlign.Center)
  }
}
