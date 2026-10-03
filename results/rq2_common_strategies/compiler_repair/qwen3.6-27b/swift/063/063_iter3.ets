import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

// MARK: - Design System Tokens

interface ColorTokens {
  primary: string;
  secondary: string;
  background: string;
  surface: string;
  outline: string;
  onPrimary: string;
  onBackground: string;
  onSurface: string;
  accent: string;
}

interface TypographyConfig {
  fontSize: number;
  fontWeight: FontWeight;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static Colors: ColorTokens = {
    primary: '#3B82F6',
    secondary: '#22C55E',
    background: '#F5F5F4',
    surface: '#FFFFFF',
    outline: '#D4D4D8',
    onPrimary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937',
    accent: '#F59E0B'
  };

  static Typography = {
    display: (size: number = 24): TypographyConfig => ({ fontSize: size, fontWeight: FontWeight.Bold }),
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Regular }
  };

  static Spacing: SpacingTokens = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 40
  };
}

@Entry
@Component
struct ChargingProgressApp {
  @State progress: number = 0.45;

  aboutToAppear() {
    // Hide status bar or set style if needed, ArkTS handles this via window manager usually
    // For simplicity in UI code, we just build the layout.
  }

  build() {
    Column() {
      CustomTopBar()

      Column({ space: AppTokens.Spacing.lg }) {
        // Battery and Percentage
        Column({ space: AppTokens.Spacing.md })
          .padding({ top: AppTokens.Spacing.md }) {
          BatteryIcon({ progress: this.progress })
            .width(60)
            .height(100)

          Text(`${Math.floor(this.progress * 100)}%`)
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground)
        }

        // Progress Bar
        CustomProgressBar({ progress: this.progress })
          .height(12)
          .width('70%')
          .padding({ top: AppTokens.Spacing.lg })

        // Simulate Button
        Button('Simulate Charge')
          .type(ButtonType.Capsule)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('auto')
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .onClick(() => {
            this.progress += 0.1;
            if (this.progress > 1.0) {
              this.progress = 0.0;
            }
          })
          .margin({ top: AppTokens.Spacing.lg })

        // Status Text
        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(AppTokens.Typography.headline.fontSize)
          .fontWeight(AppTokens.Typography.headline.fontWeight)
          .fontColor(this.progress < 1.0 ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
          .margin({ top: AppTokens.Spacing.md })

        Blank()
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
    }
    .backgroundColor(AppTokens.Colors.background)
    .height('100%')
    .width('100%')
  }
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      // Navigation Icon (Electric Car) - Using a generic symbol as SF Symbols aren't directly available
      SymbolGlyph($r('sys.symbol.bolt_car_fill'))
        .fontSize(24)
        .fontColor(AppTokens.Colors.primary)
        .margin({ left: 8 })

      Blank()

      Text('Charging Progress')
        .fontSize(AppTokens.Typography.display().fontSize)
        .fontWeight(AppTokens.Typography.display().fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      // Action Icon (Settings)
      Button() {
        SymbolGlyph($r('sys.symbol.gearshape_fill'))
          .fontSize(24)
          .fontColor(AppTokens.Colors.accent)
      }
      .type(ButtonType.Circle)
      .backgroundColor(Color.Transparent)
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppTokens.Colors.surface)
    .width('100%')
  }
}

@Component
struct BatteryIcon {
  progress: number = 0;

  build() {
    Stack() {
      // Battery Body
      Rect()
        .fill(AppTokens.Colors.primary)
        .borderWidth(0)
        .cornerRadius(8)
        .width(50)
        .height(90)

      // Battery Top Cap
      Rect()
        .fill(AppTokens.Colors.primary)
        .cornerRadius(3)
        .width(20)
        .height(10)
        .position({ x: 25, y: -50 })

      // Lightning Bolt
      new LightningBoltShape()
        .fill(AppTokens.Colors.onPrimary)
        .width(25)
        .height(40)
    }
  }
}

class LightningBoltShape extends Shape {
  draw(context: CanvasRenderingContext2D, width: number, height: number): void {
    context.beginPath();
    const midX = width / 2;
    const minY = 0;
    const maxY = height;
    const midY = height / 2;

    // Path logic adapted from SwiftUI
    context.moveTo(midX, minY + 5);
    context.lineTo(midX - 8, midY);
    context.lineTo(midX + 2, midY);
    context.lineTo(midX - 5, maxY - 5);
    context.lineTo(midX + 8, midY);
    context.lineTo(midX - 2, midY);
    context.closePath();
    context.fill();
  }
}

@Component
struct CustomProgressBar {
  progress: number = 0;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Capsule()
        .fill(AppTokens.Colors.surface)
        .border({ width: 1, color: AppTokens.Colors.outline })

      // Indicator
      Capsule()
        .fill(AppTokens.Colors.primary)
        .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
        .margin({ left: 1, right: 1, top: 1, bottom: 1 })
    }
    .clip(Capsule())
  }
}