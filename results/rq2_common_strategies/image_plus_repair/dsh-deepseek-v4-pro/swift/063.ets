// MARK: - Entry Point
@Entry
@Component
struct ChargingProgressApp {
  build() {
    // SwiftUI WindowGroup { ContentView() } maps to the single page root.
    // The root node of an @Entry build must be a built-in container component.
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Design System Tokens
class Colors {
  static readonly primary: string = '#3B82F6';
  static readonly secondary: string = '#22C55E';
  static readonly background: string = '#F5F5F4';
  static readonly surface: string = '#FFFFFFFF';
  static readonly outline: string = '#D4D4D8';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
  static readonly accent: string = '#F59E0B';
}

interface FontSpec {
  size: number;
  weight: FontWeight;
}

class Typography {
  static display(size: number = 24): FontSpec {
    return { size: size, weight: FontWeight.Bold };
  }
  // Swift .semibold -> closest ArkUI weight (Medium)
  static readonly headline: FontSpec = { size: 18, weight: FontWeight.Medium };
  static readonly title: FontSpec = { size: 14, weight: FontWeight.Medium };
  static readonly body: FontSpec = { size: 12, weight: FontWeight.Regular };
}

class Spacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 40;
}

// MARK: - Main Content View
@Component
struct ContentView {
  build() {
    // statusBarHidden(true) is a window-level property in ArkUI.
    RootScreen()
  }
}

@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.background)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

      Column({ space: 0 }) {
        // Top Bar
        CustomTopBar()

        // Content - 使用更紧凑的布局
        Column({ space: Spacing.lg }) {
          // 电池和百分比组合，紧贴顶部栏
          Column({ space: Spacing.md }) {
            // Custom Vertical Battery Icon
            BatteryIcon({ progress: this.progress })
              .width(60)
              .height(100)

            // Percentage Text
            Text(Math.round(this.progress * 100).toString() + '%')
              .font({ size: 36, weight: FontWeight.Bold })
              .fontColor(Colors.onBackground)
          }
          .padding({ top: Spacing.md })

          // Progress Bar
          CustomProgressBar({ progress: this.progress })
            .height(12)
            .width('70%')
            .padding({ top: Spacing.lg })

          // Simulate Button
          Button() {
            Text('Simulate Charge')
              .font(Typography.title)
              .fontColor(Colors.onPrimary)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          }
          .backgroundColor(Colors.secondary)
          .borderRadius(24)
          .padding({ top: Spacing.lg })
          .onClick(() => {
            animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
              this.progress += 0.1;
              if (this.progress > 1.0) {
                this.progress = 0.0;
              }
            });
          })

          // Status Text
          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
            .font(Typography.headline)
            .fontColor(this.progress < 1.0 ? Colors.primary : Colors.secondary)
            .padding({ top: Spacing.md })

          Blank()
        }
        .padding(Spacing.lg)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct CustomTopBar {
  build() {
    Row() {
      // Navigation Icon (Electric Car) - SF Symbol "bolt.car.fill"
      Text('⚡')
        .fontSize(24)
        .fontColor(Colors.primary)
        .padding({ left: 8 })

      Blank()

      // Title
      Text('Charging Progress')
        .font(Typography.display(24))
        .fontColor(Colors.onBackground)

      Blank()

      // Action Icon (Settings) - SF Symbol "gearshape.fill"
      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(Colors.accent)
      }
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        // no-op
      })
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(Colors.surface)
    .width('100%')
  }
}

@Component
struct BatteryIcon {
  @Prop progress: number = 0;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // 电池主体 - 全蓝色
      Rect({ width: 50, height: 90, radius: 8 })
        .fill(Colors.primary)

      // 电池顶部凸起
      Rect({ width: 20, height: 10, radius: 3 })
        .fill(Colors.primary)
        .offset({ y: -50 })

      // 自定义闪电形状 - 更接近原图
      Path({ width: 25, height: 40, commands: 'M12.5 5 L4.5 20 L14.5 20 L7.5 35 L20.5 20 L10.5 20 Z' })
        .fill(Colors.onPrimary)
    }
  }
}

@Component
struct CustomProgressBar {
  @Prop progress: number = 0;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Rect()
        .width('100%')
        .height('100%')
        .fill(Colors.surface)
        .stroke(Colors.outline)
        .strokeWidth(1)
        .radius(6)

      // Indicator
      Rect()
        .width((Math.min(Math.max(this.progress, 0), 1) * 100).toString() + '%')
        .height('100%')
        .fill(Colors.primary)
        .margin(1)
        .radius(5)
    }
    .width('100%')
    .height(12)
  }
}

// MARK: - Extensions
// Color(hex:) is represented by hex string colors ('#RRGGBB' / '#AARRGGBB') in ArkUI.
