import { window } from '@kit.ArkUI'

interface AppColorsInterface {
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

const AppColors: AppColorsInterface = {
  primary: '#2563EB',
  secondary: '#38BDF8',
  tertiary: '#3B82F6',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#CBD5E1',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#0F172A',
  onTertiary: '#FFFFFF',
  onBackground: '#0F172A',
  onSurface: '#1E293B'
}

interface SpacingInterface {
  xs: number,
  sm: number,
  md: number,
  lg: number,
  xl: number,
  xxl: number
}

const Spacing: SpacingInterface = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 36
}

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Workout Plan")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Transparent)

      // Main Content Area
      Column() {
        Text("Sign In to Continue")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ bottom: Spacing.lg })

        // Workout Preview Box
        Row() {
          Text("Workout Preview")
            .fontSize(14)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppColors.surface)
        .borderWidth(1)
        .borderColor(AppColors.outline)
        .borderRadius(16)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: Spacing.lg })

        // Authenticate Button
        Button("Authenticate")
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(16)
          .width('80%')
          .height(52)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [
          ['rgba(56, 189, 248, 0.1)', 0],
          ['rgba(37, 99, 235, 0.15)', 1]
        ]
      })

      // Bottom Navigation Bar
      Row() {
        Text("Home")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
        
        Text("Plan")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        
        Text("Profile")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.14)', offsetY: 4 })

      // Floating Action Button (Absolute Positioning)
      Row() {
        Text("+")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppColors.primary)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .position({ x: 'calc(100% - 72vp)', y: 'calc(100% - 100vp)' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}