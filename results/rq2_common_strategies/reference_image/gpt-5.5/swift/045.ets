class AppColors {
  static readonly primary: string = '#8E6BF2'
  static readonly secondary: string = '#D3C1FF'
  static readonly tertiary: string = '#B39DDB'
  static readonly background: string = '#F5F3FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#ECE6F8'
  static readonly outline: string = '#D1C4E9'
  static readonly success: string = '#4CAF50'
  static readonly warning: string = '#FFB300'
  static readonly error: string = '#E53935'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#2E1A47'
  static readonly onBackground: string = '#2E1A47'
  static readonly onSurface: string = '#2E1A47'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 20
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(4, 8, 2, 0.18)
  static readonly level2: ShadowSpec = new ShadowSpec(8, 12, 4, 0.22)
  static readonly level3: ShadowSpec = new ShadowSpec(12, 20, 8, 0.26)
}

@Entry
@Component
struct RootScreen {
  @State private orderId: string = ''
  @State private issue: string = ''
  @State private submitted: boolean = false
  @State private orderIdIsFocused: boolean = false
  @State private issueIsFocused: boolean = false

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('After-Sale Service')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      Column({ space: AppSpacing.md }) {
        Text('Order ID')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        TextInput({
          placeholder: 'Enter order number',
          text: this.orderId
        })
          .width('100%')
          .height(56)
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md
          })
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .placeholderColor('rgba(46, 26, 71, 0.5)')
          .placeholderFont({
            size: AppTypography.bodySize,
            weight: FontWeight.Normal
          })
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .border({
            width: 1,
            color: this.orderIdIsFocused ? AppColors.primary : AppColors.outline,
            radius: AppShapes.medium
          })
          .onFocus(() => {
            this.orderIdIsFocused = true
          })
          .onBlur(() => {
            this.orderIdIsFocused = false
          })
          .onChange((value: string) => {
            this.orderId = value
          })

        Text('Issue Description')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        TextArea({
          placeholder: 'Describe your issue',
          text: this.issue
        })
          .width('100%')
          .height(120)
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.sm + 4,
            bottom: AppSpacing.sm + 4
          })
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .placeholderColor('rgba(46, 26, 71, 0.5)')
          .placeholderFont({
            size: AppTypography.bodySize,
            weight: FontWeight.Normal
          })
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .border({
            width: 1,
            color: this.issueIsFocused ? AppColors.primary : AppColors.outline,
            radius: AppShapes.medium
          })
          .onFocus(() => {
            this.issueIsFocused = true
          })
          .onBlur(() => {
            this.issueIsFocused = false
          })
          .onChange((value: string) => {
            this.issue = value
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.large)
      .shadow({
        radius: AppElevation.level2.radius,
        color: 'rgba(209, 196, 233, 0.22)',
        offsetX: 0,
        offsetY: AppElevation.level2.dy
      })

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Submit Request')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.large)
      .onClick(() => {
        this.submitted = true
      })

      if (this.submitted) {
        Text('Request submitted successfully!')
          .width('100%')
          .padding(AppSpacing.lg)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.success)
          .textAlign(TextAlign.Center)
          .backgroundColor('rgba(76, 175, 80, 0.15)')
          .borderRadius(AppShapes.medium)
      }

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background)
    .alignItems(HorizontalAlign.Start)
  }
}