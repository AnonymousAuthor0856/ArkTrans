// AppTokens.ts
export const AppTokens = {
  Colors: {
    primary: '#A0C4FF',
    secondary: '#B7E4C7',
    tertiary: '#FFDDC1',
    background: '#F8F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F0F5',
    outline: '#D9D9E3',
    success: '#B4E4C7',
    warning: '#FFDDC1',
    error: '#FFB4AB',
    onPrimary: '#001D3D',
    onSecondary: '#003720',
    onTertiary: '#3E2800',
    onBackground: '#1B1B1F',
    onSurface: '#1B1B1F'
  },
  Typography: {
    display: { size: 45, weight: 700 },
    headline: { size: 24, weight: 600 },
    title: { size: 18, weight: 500 },
    body: { size: 14, weight: 400 },
    label: { size: 12, weight: 500 }
  },
  Shapes: {
    small: 4,
    medium: 8,
    large: 12,
    circle: 9999
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  },
  Elevation: {
    level1: { radius: 2, dy: 1, opacity: 0.08 },
    level2: { radius: 4, dy: 2, opacity: 0.10 },
    level3: { radius: 8, dy: 4, opacity: 0.12 }
  }
}

// AnnotationToolButton.ets
@Component
export struct AnnotationToolButton {
  @Prop icon: string
  @Prop toolName: string
  @Prop selectedTool: string
  @Link onClick: () => void

  build() {
    Column() {
      Text(this.icon)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.toolName === this.selectedTool ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    }
    .width(40)
    .height(40)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.toolName === this.selectedTool ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.circle)
    .onClick(() => {
      this.onClick()
    })
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon
        Button() {
          Circle()
            .fill(AppTokens.Colors.surfaceVariant)
            .width(24)
            .height(24)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)

        Flex({ justifyContent: FlexAlign.Center })
        Text('Document.pdf')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Flex({ justifyContent: FlexAlign.End })
        Button('Share')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      }
      .width('100%')
      .height(56)
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content
      Row() {
        // Left side: Page Grid
        GridContainer()
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('auto')
          .gap(AppTokens.Spacing.sm)
          .width(150)
          .padding(AppTokens.Spacing.sm)
          .forEach((_, index) => {
            let page = index + 1
            Button() {
              Text(page.toString())
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(this.selectedPage === page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            }
            .type(ButtonType.Normal)
            .backgroundColor(this.selectedPage === page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .aspectRatio(0.7)
            .border({ width: this.selectedPage === page ? 2 : 0, color: AppTokens.Colors.primary })
            .onClick(() => {
              this.selectedPage = page
            })
          }, 12)

        // Right side: Document View
        Stack() {
          // Main document card
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: AppTokens.Elevation.level1.radius, color: Color.Black.opacity(AppTokens.Elevation.level1.opacity), offsetY: AppTokens.Elevation.level1.dy })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .child(
              Text(`Page ${this.selectedPage}`)
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)
            )

          // Annotation tools column
          Column() {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'pen' }
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'highlighter' }
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'text' }
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'shape' }
            })
          }
          .padding(AppTokens.Spacing.sm)
          .backgroundColor(AppTokens.Colors.surface.opacity(0.8))
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .position({ x: AppTokens.Spacing.md, y: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}