// AppTokens.ets - Design tokens and theme configuration

export class AppTokens {
  static readonly Colors = {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFFCF2',
    surface: '#FFFFFF',
    surfaceVariant: '#F7EDE2',
    outline: '#E5D4B1',
    success: '#06D6A0',
    warning: '#FFA600',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  }

  static readonly Typography = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }
}

// RootScreen.ets - Main UI Component

@Entry
@Component
struct RootScreen {
  @State points: Array<any> = [] // Stores touch points {x, y}
  @State currentColor: string = AppTokens.Colors.primary

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area (Whiteboard)
      Column() {
        // Top App Bar
        Row() {
          Text('Retro Whiteboard')
            .fontSize(AppTokens.Typography.display.fontSize)
            .fontWeight(AppTokens.Typography.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .backgroundColor(AppTokens.Colors.background)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Canvas Area
        Stack() {
          // Drawn points
          ForEach(this.points, (point: any) => {
            Circle({ width: 20, height: 20 })
              .position({ x: point.x - 10, y: point.y - 10 })
              .fill(this.currentColor)
          }, (point: any, index: number) => index.toString())

          // Touch listener layer
          Column()
            .width('100%')
            .height('100%')
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Move || event.type === TouchType.Down) {
                const localX = event.touches[0].x
                const localY = event.touches[0].y
                // Add point to state
                this.points.push({ x: localX, y: localY })
              }
            })
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)

        // Bottom Bar
        Row() {
          Button('Red')
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.small)
            .onClick(() => { this.currentColor = AppTokens.Colors.primary })

          Button('Yellow')
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .borderRadius(AppTokens.Shapes.small)
            .onClick(() => { this.currentColor = AppTokens.Colors.secondary })

          Button('Green')
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onTertiary)
            .borderRadius(AppTokens.Shapes.small)
            .onClick(() => { this.currentColor = AppTokens.Colors.tertiary })
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
        .shadow({ radius: AppTokens.Spacing.xs, color: 'rgba(0,0,0,0.1)', offsetY: -2 })
      }
      .width('100%')
      .height('100%')

      // Floating Action Button (Clear)
      Button('Clear') {
        Text('Clear')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .width(80)
      .height(80)
      .borderRadius(40) // CircleShape
      .backgroundColor(AppTokens.Colors.secondary)
      .position({ x: '80%', y: '85%' }) // Positioned bottom right
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.2)', offsetY: 4 })
      .onClick(() => {
        this.points = []
      })
    }
    .width('100%')
    .height('100%')
  }
}