// src/main/ets/view/LeaseWizard.ets

@Entry
@Component
struct LeaseWizard {
  @State currentStep: number = 1
  @State name: string = "Avery Tenant"
  @State contact: string = "avery@example.com"
  @State income: string = "$120k annual"

  // Design Tokens
  private readonly primaryColor: string = '#A07CFF'
  private readonly secondaryColor: string = '#F6B4D7'
  private readonly surfaceVariantColor: string = '#EFE7FF'
  private readonly backgroundColor: string = '#FDF8FF'
  private readonly textColor: string = '#24132C'
  private readonly subTextColor: string = '#5E4B6E' // Approximated alpha version of text color
  private readonly outlineColor: string = '#C9B4E6'

  build() {
    Column() {
      // === Header ===
      Row() {
        // Left Icon Placeholder
        Circle({ width: '30vp', height: '30vp' })
          .fill(this.surfaceVariantColor)

        Column() {
          Text('LeaseWizard')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.textColor)
          Text('Guided handoff')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.subTextColor)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        // Right Icon Placeholder
        Circle({ width: '30vp', height: '30vp' })
          .fill('#A07CFF') // Primary with alpha handled by opacity if needed, or use rgba string
          .opacity(0.3)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20, bottom: 10 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // === Scrollable Content ===
      Scroll() {
        Column() {
          // === Steps Card ===
          this.buildStepsCard()

          // === Form Card ===
          this.buildFormCard()

          // === Summary Card (Partial based on screenshot) ===
          this.buildSummaryCard()
        }
        .padding({ left: 20, right: 20, bottom: 40 })
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(this.backgroundColor)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }

  @Builder
  buildStepsCard() {
    Column() {
      Text('Steps')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .margin({ bottom: 16 })

      // Step 1
      this.buildStepRow(1, 'Profile', 'Tenant basics', true)
      // Connector
      Column().width(4).height(32).backgroundColor(this.surfaceVariantColor).margin({ left: 12, bottom: 12 })
      
      // Step 2
      this.buildStepRow(2, 'Income', 'Proof details', true)
      // Connector
      Column().width(4).height(32).backgroundColor(this.surfaceVariantColor).margin({ left: 12, bottom: 12 })

      // Step 3
      this.buildStepRow(3, 'References', 'Upload letters', false)
      // Connector
      Column().width(4).height(32).backgroundColor(this.surfaceVariantColor).margin({ left: 12, bottom: 12 })

      // Step 4
      this.buildStepRow(4, 'Summary', 'Confirm submission', false)

    }
    .padding(16)
    .borderRadius(24)
    .backgroundColor(this.surfaceVariantColor)
    .shadow({ radius: 8, color: '#1A000000', offsetY: 4 }) // Level 2 shadow approx
    .margin({ bottom: 16 })
  }

  @Builder
  buildStepRow(index: number, title: string, desc: string, isCompleted: boolean) {
    Row() {
      // Number Circle
      Column() {
        Circle({ width: '28vp', height: '28vp' })
          .fill(isCompleted ? this.primaryColor : this.surfaceVariantColor)
        
        Text(`${index}`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(isCompleted ? '#FFFFFF' : this.textColor)
          .textAlign(TextAlign.Center)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Text Info
      Column() {
        Text(title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textColor)
        Text(desc)
          .fontSize(13)
          .fontColor(this.subTextColor)
          .margin({ top: 2 })
      }
      .margin({ left: 16 })
      .layoutWeight(1)

      // Action Button
      Button(isCompleted ? 'Edit' : 'Go')
        .backgroundColor(this.secondaryColor)
        .fontColor('#2B0E1C')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .borderRadius(8)
        .height(36)
        .width(80)
        .onClick(() => {
          this.currentStep = index - 1
        })
    }
    .alignItems(VerticalAlign.Top)
    .margin({ bottom: 12 })
  }

  @Builder
  buildFormCard() {
    Column() {
      Text('Form')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .margin({ bottom: 16 })

      // Full Name Input
      TextInput({ placeholder: '' })
        .type(InputType.Normal)
        .backgroundColor(this.backgroundColor)
        .borderWidth(1)
        .borderColor(this.outlineColor)
        .borderRadius(14)
        .height(80)
        .padding({ left: 16, top: 24 })
        .onChange((value: string) => {
          this.name = value
        })
        .margin({ bottom: 16 })
        .overlay(
          Text('Full name')
            .fontSize(13)
            .fontColor(this.subTextColor)
            .position({ x: 16, y: 10 })
        )

      // Contact Input
      TextInput({ placeholder: '' })
        .type(InputType.Email)
        .backgroundColor(this.backgroundColor)
        .borderWidth(1)
        .borderColor(this.outlineColor)
        .borderRadius(14)
        .height(80)
        .padding({ left: 16, top: 24 })
        .onChange((value: string) => {
          this.contact = value
        })
        .margin({ bottom: 16 })
        .overlay(
          Text('Contact')
            .fontSize(13)
            .fontColor(this.subTextColor)
            .position({ x: 16, y: 10 })
        )

      // Income Input
      TextInput({ placeholder: '' })
        .type(InputType.Normal)
        .backgroundColor(this.backgroundColor)
        .borderWidth(1)
        .borderColor(this.outlineColor)
        .borderRadius(14)
        .height(80)
        .padding({ left: 16, top: 24 })
        .onChange((value: string) => {
          this.income = value
        })
        .margin({ bottom: 24 })
        .overlay(
          Text('Income')
            .fontSize(13)
            .fontColor(this.subTextColor)
            .position({ x: 16, y: 10 })
        )

      // Buttons
      Row() {
        Button('Back')
          .backgroundColor(this.surfaceVariantColor)
          .fontColor(this.textColor)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .borderRadius(14)
          .height(48)
          .layoutWeight(1)
          .margin({ right: 8 })
          .onClick(() => {
            if (this.currentStep > 0) this.currentStep--
          })

        Button(this.currentStep === 3 ? 'Submit' : 'Next')
          .backgroundColor(this.primaryColor)
          .fontColor('#1D0F33')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .borderRadius(14)
          .height(48)
          .layoutWeight(1)
          .margin({ left: 8 })
          .onClick(() => {
            if (this.currentStep < 3) this.currentStep++
          })
      }
    }
    .padding(16)
    .borderRadius(24)
    .backgroundColor(this.surfaceVariantColor)
    .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
    .margin({ bottom: 16 })
  }

  @Builder
  buildSummaryCard() {
    Column() {
      Text('Summary')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .margin({ bottom: 16 })

      // Summary Items
      this.buildSummaryItem('Lease start', 'Aug 12')
      this.buildSummaryItem('Monthly', '$2,450')
      this.buildSummaryItem('Deposit', '$2,450')
      this.buildSummaryItem('Pets', '2 approved')

      // Documents Section
      Text('Documents')
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .margin({ top: 16, bottom: 8 })

      this.buildDocItem('ID verification', 'Uploaded')
      this.buildDocItem('Employment letter', 'Pending')
      this.buildDocItem('Credit report', 'Synced')

    }
    .padding(16)
    .borderRadius(24)
    .backgroundColor(this.surfaceVariantColor)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }

  @Builder
  buildSummaryItem(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .layoutWeight(1)
      Text(value)
        .fontSize(13)
        .fontColor(this.textColor)
    }
    .width('100%')
    .padding(12)
    .borderRadius(14)
    .backgroundColor(this.backgroundColor) // Slightly lighter than card bg for contrast
    .margin({ bottom: 8 })
  }

  @Builder
  buildDocItem(label: string, status: string) {
    Row() {
      Text(label)
        .fontSize(13)
        .fontColor(this.textColor)
        .layoutWeight(1)
      Text(status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.secondaryColor)
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 4, bottom: 4 })
    .borderRadius(8)
    .backgroundColor('#EFE7FF') // SurfaceVariant with alpha approximated by hex if needed, or use Color.Rgb with opacity
    .opacity(0.8)
    .margin({ bottom: 4 })
  }
}