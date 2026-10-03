class AppTokens {
  static readonly Colors = {
    primary: '#FF8E6BF2',
    secondary: '#FFD3C1FF',
    tertiary: '#FFB39DDB',
    background: '#FFF5F3FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFECE6F8',
    outline: '#FFD1C4E9',
    success: '#FF4CAF50',
    warning: '#FFFFB300',
    error: '#FFE53935',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF2E1A47',
    onBackground: '#FF2E1A47',
    onSurface: '#FF2E1A47',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 20,
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
  }
}

@Entry
@Component
struct RootScreen {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false
  @State orderIdFocused: boolean = false
  @State issueFocused: boolean = false

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('After-Sale Service')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')

        Column({ space: AppTokens.Spacing.md }) {
          Text('Order ID')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          TextInput({ placeholder: 'Enter order number', text: this.orderId })
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor('#802E1A47')
            .width('100%')
            .height(56)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: this.orderIdFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .onFocus(() => {
              this.orderIdFocused = true
            })
            .onBlur(() => {
              this.orderIdFocused = false
            })
            .onChange((value: string) => {
              this.orderId = value
            })

          Text('Issue Description')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          TextArea({ placeholder: 'Describe your issue', text: this.issue })
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor('#802E1A47')
            .width('100%')
            .height(120)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm + 4, bottom: AppTokens.Spacing.sm + 4 })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: this.issueFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .onFocus(() => {
              this.issueFocused = true
            })
            .onBlur(() => {
              this.issueFocused = false
            })
            .onChange((value: string) => {
              this.issue = value
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 12, color: '#38D1C4E9', offsetY: 4 })

        Button('Submit Request')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            this.submitted = true
          })

        if (this.submitted) {
          Text('Request submitted successfully!')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.success)
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding(AppTokens.Spacing.lg)
            .backgroundColor('#264CAF50')
            .borderRadius(AppTokens.Shapes.medium)
        }
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}