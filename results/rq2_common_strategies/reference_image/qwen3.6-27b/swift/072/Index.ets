// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct Index {
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  build() {
    Column() {
      // Global Background
      Column() {
        .width('100%')
        .height('100%')
        .backgroundColor('#FBF8F3')
      }
      .position({ x: 0, y: 0 })
      .zIndex(-1)

      Column() {
        // Header
        this.HeaderView()
          .padding({ top: 10, bottom: 20 })

        // Scrollable Content
        Scroll() {
          Column({ space: 24 }) {
            // Main Form Card
            this.ApplicantDetailsCard()

            // Summary Card
            this.SummaryCard()
          }
          .padding({ left: 16, right: 16, bottom: 40 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  HeaderView() {
    Row() {
      Circle()
        .fill('#EBE2D6')
        .width(48)
        .height(48)

      Flex().layoutWeight(1)

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

      Flex().layoutWeight(1)

      Circle()
        .fill('#EBE2D6')
        .width(48)
        .height(48)
    }
    .padding({ left: 24, right: 24 })
  }

  @Builder
  ApplicantDetailsCard() {
    Column({ space: 16 }) {
      Text('Applicant details')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3D352E')
        .alignSelf(ItemStart)
        .margin({ bottom: 4 })

      // Form Fields
      this.CustomTextField({ placeholder: 'Full name', value: $fullName, height: 18 })
      this.CustomTextField({ placeholder: 'Organization', value: $organization, height: 18 })
      this.CustomTextField({ placeholder: 'Contact', value: $contact, height: 18 })
      this.CustomTextField({ placeholder: 'Relief narrative', value: $narrative, height: 18, alignment: Alignment.TopStart })
        .margin({ bottom: 90 })

      // Navigation Buttons
      Row({ space: 2 }) {
        this.FormButton({ label: 'Back', isPrimary: false })
        Flex().layoutWeight(1)
        this.FormButton({ label: 'Next', isPrimary: true })
      }
      .margin({ top: 80 })
    }
    .padding(24)
    .backgroundColor('#F7F3EE')
    .borderRadius(32)
  }

  @Builder
  SummaryCard() {
    Column({ space: 16 }) {
      Text('Summary')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3D352E')
        .alignSelf(ItemStart)

      this.SummaryRow({ label: 'Requested', value: '$4,500' })
    }
    .padding(24)
    .backgroundColor('#F7F3EE')
    .borderRadius(32)
  }

  @Builder
  CustomTextField(params: { placeholder: string, value: string, height: number, alignment?: Alignment }) {
    TextInput({ placeholder: params.placeholder, text: params.value })
      .fontSize(16)
      .fontColor('#3D352E')
      .placeholderColor('#6D5F58')
      .padding({ left: 16, right: 16 })
      .height(params.height)
      .alignContent(params.alignment ?? Alignment.Start)
      .backgroundColor('#FBF8F3')
      .borderRadius(16)
      .border({ width: 1.5, color: '#C5B8A9', radius: 16 })
  }

  @Builder
  FormButton(params: { label: string, isPrimary: boolean }) {
    Button(params.label) {
      Text(params.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .type(ButtonType.Normal)
    .backgroundColor(params.isPrimary ? '#B58B5A' : '#EBE2D6')
    .borderRadius(16)
    .height(48)
    .layoutWeight(1)
  }

  @Builder
  SummaryRow(params: { label: string, value: string }) {
    Row() {
      Text(params.label)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3D352E')

      Flex().layoutWeight(1)

      Text(params.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .padding(20)
    .backgroundColor('#EBE2D6')
    .borderRadius(16)
  }
}