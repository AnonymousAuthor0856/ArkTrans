@Entry
@Component
struct RootScreen {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false
  @State orderIdFocused: boolean = false
  @State issueFocused: boolean = false

  // Colors
  readonly colorPrimary: string = '#8E6BF2'
  readonly colorSecondary: string = '#D3C1FF'
  readonly colorTertiary: string = '#B39DDB'
  readonly colorBackground: string = '#F5F3FF'
  readonly colorSurface: string = '#FFFFFF'
  readonly colorSurfaceVariant: string = '#ECE6F8'
  readonly colorOutline: string = '#D1C4E9'
  readonly colorSuccess: string = '#4CAF50'
  readonly colorWarning: string = '#FFB300'
  readonly colorError: string = '#E53935'
  readonly colorOnPrimary: string = '#FFFFFF'
  readonly colorOnSecondary: string = '#2E1A47'
  readonly colorOnBackground: string = '#2E1A47'
  readonly colorOnSurface: string = '#2E1A47'

  // Spacing
  readonly spacingSm: number = 6
  readonly spacingMd: number = 10
  readonly spacingLg: number = 16
  readonly spacingXl: number = 24

  // Shapes
  readonly shapeSmall: number = 8
  readonly shapeMedium: number = 14
  readonly shapeLarge: number = 20

  build() {
    Stack() {
      Column({ space: this.spacingLg }) {
        // Title
        Text('After-Sale Service')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorOnBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Card area
        Column({ space: this.spacingMd }) {
          // Order ID label
          Text('Order ID')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Order ID input
          Stack({ alignContent: Alignment.TopStart }) {
            if (this.orderId === '' && !this.orderIdFocused) {
              Text('Enter order number')
                .fontSize(14)
                .fontColor('#802E1A47')
                .padding({
                  left: this.spacingMd,
                  right: this.spacingMd,
                  top: (56 - 14) / 2,
                  bottom: (56 - 14) / 2
                })
            }
            TextInput({ text: this.orderId, placeholder: '' })
              .fontSize(14)
              .fontColor(this.colorOnSurface)
              .padding({ left: this.spacingMd, right: this.spacingMd })
              .height(56)
              .width('100%')
              .backgroundColor(this.colorSurfaceVariant)
              .borderRadius(this.shapeMedium)
              .borderWidth(1)
              .borderColor(this.orderIdFocused ? this.colorPrimary : this.colorOutline)
              .onChange((value: string) => {
                this.orderId = value
              })
              .onFocus(() => {
                this.orderIdFocused = true
              })
              .onBlur(() => {
                this.orderIdFocused = false
              })
          }
          .width('100%')

          // Issue Description label
          Text('Issue Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Issue Description input
          Stack({ alignContent: Alignment.TopStart }) {
            if (this.issue === '' && !this.issueFocused) {
              Text('Describe your issue')
                .fontSize(14)
                .fontColor('#802E1A47')
                .padding({
                  left: this.spacingMd,
                  right: this.spacingMd,
                  top: this.spacingSm + 4,
                  bottom: this.spacingSm + 4
                })
            }
            TextArea({ text: this.issue, placeholder: '' })
              .fontSize(14)
              .fontColor(this.colorOnSurface)
              .padding({
                left: this.spacingMd,
                right: this.spacingMd,
                top: this.spacingSm + 4,
                bottom: this.spacingSm + 4
              })
              .height(120)
              .width('100%')
              .backgroundColor(this.colorSurfaceVariant)
              .borderRadius(this.shapeMedium)
              .borderWidth(1)
              .borderColor(this.issueFocused ? this.colorPrimary : this.colorOutline)
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
        .padding(this.spacingLg)
        .backgroundColor(this.colorSurface)
        .borderRadius(this.shapeLarge)
        .shadow({
          radius: 12,
          color: '#38D1C4E9',
          offsetX: 0,
          offsetY: 4
        })
        .alignItems(HorizontalAlign.Start)

        // Submit button
        Button('Submit Request')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colorOnPrimary)
          .width('100%')
          .height(56)
          .backgroundColor(this.colorPrimary)
          .borderRadius(this.shapeLarge)
          .onClick(() => {
            this.submitted = true
          })

        // Success message
        if (this.submitted) {
          Text('Request submitted successfully!')
            .fontSize(14)
            .fontColor(this.colorSuccess)
            .width('100%')
            .padding(this.spacingLg)
            .backgroundColor('#264CAF50')
            .borderRadius(this.shapeMedium)
            .textAlign(TextAlign.Center)
        }

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding(this.spacingLg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }
}