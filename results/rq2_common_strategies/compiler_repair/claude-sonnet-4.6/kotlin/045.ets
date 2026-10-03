@Entry
@Component
struct RootScreen {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  // Colors
  readonly colorPrimary: string = '#8E6BF2'
  readonly colorSecondary: string = '#D3C1FF'
  readonly colorTertiary: string = '#B39DDB'
  readonly colorBackground: string = '#F5F3FF'
  readonly colorSurface: string = '#FFFFFF'
  readonly colorSurfaceVariant: string = '#ECE6F8'
  readonly colorOutline: string = '#D1C4E9'
  readonly colorSuccess: string = '#4CAF50'
  readonly colorSuccessBg: string = '#264CAF50'
  readonly colorWarning: string = '#FFB300'
  readonly colorError: string = '#E53935'
  readonly colorOnPrimary: string = '#FFFFFF'
  readonly colorOnSecondary: string = '#2E1A47'
  readonly colorOnBackground: string = '#2E1A47'
  readonly colorOnSurface: string = '#2E1A47'
  readonly colorOnSurfaceHint: string = '#802E1A47'

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('After-Sale Service')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorOnBackground)
          .width('100%')

        Column({ space: 10 }) {
          Text('Order ID')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnSurface)
            .width('100%')

          TextInput({ placeholder: 'Enter order number', text: this.orderId })
            .placeholderColor(this.colorOnSurfaceHint)
            .backgroundColor(this.colorSurfaceVariant)
            .borderRadius(14)
            .width('100%')
            .height(48)
            .fontColor(this.colorOnSurface)
            .caretColor(this.colorPrimary)
            .onChange((value: string) => {
              this.orderId = value
            })

          Text('Issue Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnSurface)
            .width('100%')

          TextArea({ placeholder: 'Describe your issue', text: this.issue })
            .placeholderColor(this.colorOnSurfaceHint)
            .backgroundColor(this.colorSurfaceVariant)
            .borderRadius(14)
            .width('100%')
            .height(120)
            .fontColor(this.colorOnSurface)
            .caretColor(this.colorPrimary)
            .onChange((value: string) => {
              this.issue = value
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor(this.colorSurface)
        .borderRadius(20)
        .shadow({
          radius: 12,
          color: '#40D3C1FF',
          offsetX: 0,
          offsetY: 4
        })

        Button('Submit Request')
          .width('100%')
          .height(56)
          .backgroundColor(this.colorPrimary)
          .fontColor(this.colorOnPrimary)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(20)
          .onClick(() => {
            this.submitted = true
          })

        if (this.submitted) {
          Row() {
            Text('Request submitted successfully!')
              .fontColor(this.colorSuccess)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#264CAF50')
          .borderRadius(14)
          .justifyContent(FlexAlign.Center)
        }
      }
      .width('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F3FF')
  }
}