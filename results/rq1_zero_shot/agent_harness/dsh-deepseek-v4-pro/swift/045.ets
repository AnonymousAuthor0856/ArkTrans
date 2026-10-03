// MARK: - AppTokens
// 定义应用程序的颜色、排版、形状、间距和阴影规范
interface ColorTokens { [key: string]: string }
interface FontToken { size: number; weight: FontWeight }
interface TypographyTokens { [key: string]: FontToken }
interface NumberTokens { [key: string]: number }
interface ShadowSpec { elevation: number; radius: number; dy: number; opacity: number }
interface ElevationTokens { [key: string]: ShadowSpec }

class AppTokens {
  static readonly Colors: ColorTokens = {
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

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: NumberTokens = {
    small: 8.0, medium: 14.0, large: 20.0
  }

  static readonly Spacing: NumberTokens = {
    sm: 6.0, md: 10.0, lg: 16.0, xl: 24.0
  }

  static readonly ElevationMapping: ElevationTokens = {
    level1: { elevation: 4.0, radius: 8.0, dy: 2.0, opacity: 0.18 },
    level2: { elevation: 8.0, radius: 12.0, dy: 4.0, opacity: 0.22 },
    level3: { elevation: 12.0, radius: 20.0, dy: 8.0, opacity: 0.26 }
  }
}

// MARK: - RootScreen
// 应用程序的主要 UI 视图
@Entry
@Component
struct Index {
  @State orderId: string = ''
  @State issue: string = ''
  @State submitted: boolean = false
  @State orderIdIsFocused: boolean = false
  @State issueIsFocused: boolean = false

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Text('After-Sale Service')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Card 区域
        Column({ space: AppTokens.Spacing.md }) {
          Text('Order ID')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          TextInput({ placeholder: 'Enter order number', text: this.orderId })
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor('rgba(46, 26, 71, 0.5)')
            .width('100%')
            .height(56)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: this.orderIdIsFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .onFocus(() => {
              this.orderIdIsFocused = true
            })
            .onBlur(() => {
              this.orderIdIsFocused = false
            })
            .onChange((v: string) => {
              this.orderId = v
            })

          Text('Issue Description')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          TextArea({ placeholder: 'Describe your issue', text: this.issue })
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor('rgba(46, 26, 71, 0.5)')
            .width('100%')
            .height(120)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm + 4, bottom: AppTokens.Spacing.sm + 4 })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: this.issueIsFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .onFocus(() => {
              this.issueIsFocused = true
            })
            .onBlur(() => {
              this.issueIsFocused = false
            })
            .onChange((v: string) => {
              this.issue = v
            })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        // CustomCardStyle：圆角、背景色和阴影
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: 'rgba(209, 196, 233, 0.22)',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        // 提交按钮
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

        // 提交成功消息
        if (this.submitted) {
          Text('Request submitted successfully!')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.success)
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor('rgba(76, 175, 80, 0.15)')
            .borderRadius(AppTokens.Shapes.medium)
            .textAlign(TextAlign.Center)
        }

        Blank()
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}
