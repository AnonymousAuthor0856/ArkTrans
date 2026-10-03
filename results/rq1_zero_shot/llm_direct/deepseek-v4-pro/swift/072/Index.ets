@Entry
@Component
struct ReliefFundApp {
  build() {
    Stack() {
      // Global Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FBF8F3')

      Column({ space: 0 }) {
        // Header
        HeaderView()
          .padding({ top: 10, bottom: 20 })

        // Scrollable Content
        Scroll() {
          Column({ space: 24 }) {
            // Main Form Card
            ApplicantDetailsCard()

            // Summary Card
            SummaryCard()
          }
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderView {
  build() {
    Row() {
      Circle()
        .width(48)
        .height(48)
        .fill('#EBE2D6')

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('ReliefFund')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3D352E')
        Text('Civic support intake')
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor('#8A8A8E')
      }
      .alignItems(HorizontalAlign.Center)

      Blank()
        .layoutWeight(1)

      Circle()
        .width(48)
        .height(48)
        .fill('#EBE2D6')
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct ApplicantDetailsCard {
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  build() {
    Column({ space: 16 }) {
      Text('Applicant details')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3D352E')
        .padding({ bottom: 4 })

      // Form Fields
      CustomTextField({ placeholder: 'Full name', text: $fullName, height: 18 })
      CustomTextField({ placeholder: 'Organization', text: $organization, height: 18 })
      CustomTextField({ placeholder: 'Contact', text: $contact, height: 18 })

      // Relief narrative field
      CustomTextField({ placeholder: 'Relief narrative', text: $narrative, height: 18 })
        .padding({ bottom: 90 })

      // Navigation Buttons
      Row({ space: 2 }) {
        FormButton({ label: 'Back', isPrimary: false })
        Blank()
          .layoutWeight(1)
        FormButton({ label: 'Next', isPrimary: true })
      }
      .width('100%')
      .padding({ top: 80 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F7F3EE')
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SummaryCard {
  build() {
    Column({ space: 16 }) {
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3D352E')

      SummaryRow({ label: 'Requested', value: '$4,500' })
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F7F3EE')
    .borderRadius(32)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CustomTextField {
  @Prop placeholder: string = ''
  @Link text: string = ''
  @Prop height: number = 40

  build() {
    TextInput({ placeholder: this.placeholder, text: this.text })
      .fontSize(16)
      .fontColor('#3D352E')
      .padding({ left: 16, right: 16 })
      .height(this.height)
      .backgroundColor('#FBF8F3')
      .borderRadius(16)
      .border({ width: 1.5, color: '#C5B8A9' })
      .onChange((value: string) => {
        this.text = value
      })
  }
}

@Component
struct FormButton {
  @Prop label: string = ''
  @Prop isPrimary: boolean = false

  build() {
    Button(this.label) {
      // Button action
    }
    .fontSize(14)
    .fontWeight(FontWeight.Medium)
    .fontColor('#000000')
    .padding({ top: 48, bottom: 48 })
    .width('100%')
    .backgroundColor(this.isPrimary ? '#B58B5A' : '#EBE2D6')
    .borderRadius(16)
  }
}

@Component
struct SummaryRow {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Row() {
      Text(this.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3D352E')

      Blank()
        .layoutWeight(1)

      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#EBE2D6')
    .borderRadius(16)
  }
}