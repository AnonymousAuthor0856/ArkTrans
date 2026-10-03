const NAME = '059*AfterSale*en'
const UI_TYPE = 'ECommerce'
const STYLE_THEME = 'Clay Morph'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
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
    onSurface: '#2E1A47',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 14,
    large: 20,
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
  }

  static ElevationMapping = {
    level1: { elevation: 4, radius: 8, dy: 2, opacity: 0.18 },
    level2: { elevation: 8, radius: 12, dy: 4, opacity: 0.22 },
    level3: { elevation: 12, radius: 20, dy: 8, opacity: 0.26 },
  }
}

@Entry
@Component
struct RootScreen {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false

  build() {
    Column() {
      Text('After-Sale Service')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      Column() {
        Text('Order ID')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        TextInput({ text: this.orderId, placeholder: 'Enter order number' })
          .width('100%')
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .placeholderColor('#802E1A47')
          .margin({ top: AppTokens.Spacing.md })
          .onChange((value: string) => {
            this.orderId = value
          })

        Text('Issue Description')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.md })

        TextArea({ text: this.issue, placeholder: 'Describe your issue' })
          .width('100%')
          .height(120)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .placeholderColor('#802E1A47')
          .margin({ top: AppTokens.Spacing.md })
          .onChange((value: string) => {
            this.issue = value
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(142,107,242,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
      .margin({ top: AppTokens.Spacing.lg })

      Button('Submit Request')
        .type(ButtonType.Normal)
        .width('100%')
        .height(56)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .margin({ top: AppTokens.Spacing.lg })
        .onClick(() => {
          this.submitted = true
        })

      if (this.submitted) {
        Text('Request submitted successfully!')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.success)
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor('#264CAF50')
          .borderRadius(AppTokens.Shapes.medium)
          .textAlign(TextAlign.Center)
          .margin({ top: AppTokens.Spacing.lg })
      }
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}