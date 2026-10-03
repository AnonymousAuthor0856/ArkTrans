class AppColors {
  static readonly primary: string = '#8E6BF2'
  static readonly secondary: string = '#D3C1FF'
  static readonly tertiary: string = '#B39DDB'
  static readonly background: string = '#F5F3FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#ECE6F8'
  static readonly outline: string = '#D1C4E9'
  static readonly success: string = '#4CAF50'
  static readonly successContainer: string = '#264CAF50'
  static readonly warning: string = '#FFB300'
  static readonly error: string = '#E53935'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#2E1A47'
  static readonly onBackground: string = '#2E1A47'
  static readonly onSurface: string = '#2E1A47'
  static readonly placeholder: string = '#802E1A47'
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class AppRadius {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 20
}

@Entry
@Component
struct AfterSaleServicePage {
  @State private orderId: string = ''
  @State private issue: string = ''
  @State private submitted: boolean = false

  @Builder
  private LabelText(value: string) {
    Text(value)
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .lineHeight(24)
  }

  @Builder
  private SingleLineField() {
    Column() {
      TextInput({
        placeholder: 'Enter order number',
        text: this.orderId
      })
        .width('100%')
        .height(56)
        .fontSize(16)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.placeholder)
        .placeholderFont({
          size: 16,
          weight: FontWeight.Regular
        })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppRadius.medium)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg
        })
        .caretColor(AppColors.primary)
        .onChange((value: string) => {
          this.orderId = value
        })

      Divider()
        .width('100%')
        .strokeWidth(1)
        .color(AppColors.outline)
    }
    .width('100%')
  }

  @Builder
  private MultiLineField() {
    Column() {
      TextArea({
        placeholder: 'Describe your issue',
        text: this.issue
      })
        .width('100%')
        .height(120)
        .fontSize(16)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.placeholder)
        .placeholderFont({
          size: 16,
          weight: FontWeight.Regular
        })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppRadius.medium)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
        .caretColor(AppColors.primary)
        .onChange((value: string) => {
          this.issue = value
        })

      Divider()
        .width('100%')
        .strokeWidth(1)
        .color(AppColors.outline)
    }
    .width('100%')
  }

  build() {
    Column() {
      Text('After-Sale Service')
        .width('100%')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .lineHeight(36)

      Column() {
        this.LabelText('Order ID')
          .margin({ bottom: AppSpacing.md })

        this.SingleLineField()
          .margin({ bottom: AppSpacing.md })

        this.LabelText('Issue Description')
          .margin({ bottom: AppSpacing.md })

        this.MultiLineField()
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppRadius.large)
      .shadow({
        radius: 12,
        color: '#38D3C1FF',
        offsetX: 0,
        offsetY: 4
      })
      .margin({ top: AppSpacing.lg })

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Submit Request')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppRadius.large)
      .margin({ top: AppSpacing.lg })
      .onClick(() => {
        this.submitted = true
      })

      if (this.submitted) {
        Row() {
          Text('Request submitted successfully!')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.success)
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppColors.successContainer)
        .borderRadius(AppRadius.medium)
        .margin({ top: AppSpacing.lg })
      }
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.background)
  }
}