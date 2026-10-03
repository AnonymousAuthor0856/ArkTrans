import { window } from '@kit.ArkUI'

// Token Definitions
interface AppTokenColors {
  primary: string,
  secondary: string,
  tertiary: string,
  background: string,
  surface: string,
  surfaceVariant: string,
  outline: string,
  success: string,
  warning: string,
  error: string,
  onPrimary: string,
  onSecondary: string,
  onTertiary: string,
  onBackground: string,
  onSurface: string
}

interface AppTokenSpacing {
  sm: number,
  md: number,
  lg: number,
  xl: number,
  xxl: number
}

const AppTokens = {
  Colors: {
    primary: '#38BDF8',
    secondary: '#A78BFA',
    tertiary: '#7DD3FC',
    background: '#F1F5F9',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  } as AppTokenColors,
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  } as AppTokenSpacing
}

@Entry
@Component
struct RootScreen {
  @State scrollOffsetY: number = 0

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Glass Doc Reader')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Stack({ alignContent: Alignment.Center }) {
        // Background Gradient Simulation (ArkTS doesn't support complex vertical gradients easily in Modifier.background without custom drawing, 
        // so we use a solid color close to the middle or a simple linear gradient if supported by specific version. 
        // For maximum compatibility and visual match, we use the base background color).
        Column()
          .width('100%')
          .layoutWeight(1)
          .backgroundColor(AppTokens.Colors.background)

        // Draggable Glass Card
        Column() {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)
            .margin({ bottom: AppTokens.Spacing.md })

          // Sample Lines
          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (index: number) => {
            Text(`This is a sample line of text content number ${index}.`)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: index === 8 ? 0 : AppTokens.Spacing.md })
          })
        }
        .width('90%')
        .height(400)
        .padding(AppTokens.Spacing.lg)
        .borderRadius(20)
        .backgroundColor(Color.White.withAlpha(0.7))
        .shadow({ radius: 8, color: Color.Black.withAlpha(0.18), offsetY: 4 })
        .translate({ y: this.scrollOffsetY / 5 })
        .gesture(
          PanGesture()
            .onActionUpdate((event?: GestureEvent) => {
              if (event) {
                this.scrollOffsetY += event.offsetY
              }
            })
        )
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}