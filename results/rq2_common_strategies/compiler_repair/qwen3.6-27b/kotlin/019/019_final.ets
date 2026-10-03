import { window } from '@kit.ArkUI'

// Token Definitions matching the Kotlin AppTokens
interface ColorMap {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

const COLORS: ColorMap = {
  primary: '#8B5CF6',
  secondary: '#D946EF',
  tertiary: '#3B82F6',
  background: '#F9F5FF',
  surface: '#FFFFFF',
  surfaceVariant: '#F1E9FE',
  outline: '#E3D7FE',
  success: '#22C55E',
  warning: '#FACC15',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#1E1E1E',
  onSurface: '#1E1E1E'
};

interface SpacingMap {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

const SPACING: SpacingMap = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
};

@Component
struct RootScreen {
  @State fontSize: number = 24;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // Top Bar Area (Simulating Scaffold TopBar)
      Row() {
        Text("Subtitle Editor")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: SPACING.lg, bottom: SPACING.md })

      // Main Content Container
      Column() {
        // Subtitle Preview Surface
        Row() {
          Text("Sample Subtitle Line")
            .fontSize(this.fontSize)
            .fontColor(COLORS.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(COLORS.surface)
        .borderRadius(22)
        .shadow({ radius: 12, color: 'rgba(0,0,0,0.18)', offsetY: 6 })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Font Size Label
        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(14)
          .fontColor(COLORS.onSurface)
          .margin({ top: SPACING.lg })

        // Slider for Font Size
        Slider({ value: this.fontSize, min: 16, max: 48 })
          .width('100%')
          .blockColor(COLORS.primary)
          .trackColor(COLORS.surfaceVariant)
          .selectedColor(COLORS.secondary)
          .onChange((value: number) => {
            this.fontSize = value;
          })
          .margin({ top: SPACING.sm })

        // Sync Progress Label
        Text("Sync Progress")
          .fontSize(14)
          .fontColor(COLORS.onSurface)
          .margin({ top: SPACING.lg })

        // Linear Progress Indicator
        Progress({ value: this.syncProgress, total: 1.0, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(COLORS.primary)
          .backgroundColor(COLORS.surfaceVariant)
          .margin({ top: SPACING.sm })

        // Action Buttons
        Row() {
          Button("Sync +")
            .type(ButtonType.Normal)
            .backgroundColor(COLORS.primary)
            .fontColor(COLORS.onPrimary)
            .borderRadius(14)
            .height(48)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            })

          Button("Sync -")
            .type(ButtonType.Normal)
            .backgroundColor(COLORS.secondary)
            .fontColor(COLORS.onSecondary)
            .borderRadius(14)
            .height(48)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            })
        }
        .width('100%')
        .margin({ top: SPACING.lg })
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding(SPACING.lg)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#F1E9FE', 0], ['#F9F5FF', 0.5], ['#FFFFFF', 1]]
    })
  }
}

@Entry
@Component
struct MainEntry {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}