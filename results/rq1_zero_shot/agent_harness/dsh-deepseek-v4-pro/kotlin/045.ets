const Colors = {
  primary: '#8E6BF2',
  secondary: '#D3C1FF',
  tertiary: '#B39DDB',
  background: '#F5F3FF',
  surface: '#FFFFFF',
  surfaceVariant: '#ECE6F8',
  outline: '#D1C4E9',
  success: '#4CAF50',
  warning: '#FFB300',
  error: '#E53935',
  onPrimary: '#FFFFFF',
  onSecondary: '#2E1A47',
  onBackground: '#2E1A47',
  onSurface: '#2E1A47'
}

const Shapes = {
  small: 8,
  medium: 14,
  large: 20
}

const Spacing = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24
}

@Entry
@Component
struct Index {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  build() {
    Scroll() {
      Column({ space: Spacing.lg }) {
        Text('After-Sale Service')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)

        Column({ space: Spacing.md }) {
          Text('Order ID')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          TextInput({ placeholder: 'Enter order number', text: this.orderId })
            .width('100%')
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(Shapes.medium)
            .placeholderColor('#802E1A47')
            .onChange((value: string) => {
              this.orderId = value
            })
          Text('Issue Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          TextArea({ placeholder: 'Describe your issue', text: this.issue })
            .width('100%')
            .height(120)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(Shapes.medium)
            .placeholderColor('#802E1A47')
            .onChange((value: string) => {
              this.issue = value
            })
        }
        .width('100%')
        .padding(Spacing.lg)
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.large)
        .shadow({ radius: 12, color: '#38000000', offsetY: 4 })

        Button('Submit Request', { type: ButtonType.Normal })
          .width('100%')
          .height(56)
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.submitted = true
          })

        if (this.submitted) {
          Row() {
            Text('Request submitted successfully!')
              .fontSize(14)
              .fontColor(Colors.success)
          }
          .width('100%')
          .padding(Spacing.lg)
          .backgroundColor('#264CAF50')
          .borderRadius(Shapes.medium)
          .justifyContent(FlexAlign.Center)
        }
      }
      .width('100%')
      .padding(Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
