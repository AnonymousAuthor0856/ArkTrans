import { curves } from '@kit.ArkUI';

// MARK: - Design System Tokens
class AppColors {
  static readonly primary: string = '#3B82F6';
  static readonly secondary: string = '#22C55E';
  static readonly background: string = '#F5F5F4';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#D4D4D8';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
  static readonly accent: string = '#F59E0B';
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 40;
}

// MARK: - Lightning Bolt Shape using Canvas
@Component
struct LightningBoltCanvas {
  build() {
    Canvas(new CanvasRenderingContext2D(new RenderingContextSettings(true)))
      .width(25)
      .height(40)
      .onReady((context: CanvasRenderingContext2D) => {
        const w = 25;
        const h = 40;
        const midX = w / 2;
        const minY = 0;
        const midY = h / 2;
        const maxY = h;

        context.fillStyle = AppColors.onPrimary;
        context.beginPath();
        context.moveTo(midX, minY + 5);
        context.lineTo(midX - 8, midY);
        context.lineTo(midX + 2, midY);
        context.lineTo(midX - 5, maxY - 5);
        context.lineTo(midX + 8, midY);
        context.lineTo(midX - 2, midY);
        context.closePath();
        context.fill();
      })
  }
}

// MARK: - Battery Icon Component
@Component
struct BatteryIcon {
  @Prop progress: number = 0.45;

  build() {
    Stack() {
      // Battery body
      Column() {
        // Battery top nub
        Row()
          .width(20)
          .height(10)
          .borderRadius(3)
          .backgroundColor(AppColors.primary)
          .margin({ bottom: 0 })

        // Battery main body
        Stack() {
          Column()
            .width(50)
            .height(90)
            .borderRadius(8)
            .backgroundColor(AppColors.primary)

          LightningBoltCanvas()
        }
        .width(50)
        .height(90)
      }
      .alignItems(HorizontalAlign.Center)
      .width(60)
      .height(100)
    }
    .width(60)
    .height(100)
  }
}

// MARK: - Custom Progress Bar
@Component
struct CustomProgressBar {
  @Prop progress: number = 0.45;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height(12)
        .borderRadius(6)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: 6 })

      // Indicator
      Row()
        .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
        .height(10)
        .borderRadius(5)
        .backgroundColor(AppColors.primary)
        .margin({ left: 1 })
    }
    .width('70%')
    .height(12)
    .borderRadius(6)
    .clip(true)
  }
}

// MARK: - Custom Top Bar
@Component
struct CustomTopBar {
  build() {
    Row() {
      // Navigation Icon (Electric Car / Bolt)
      Text('⚡')
        .fontSize(24)
        .fontColor(AppColors.primary)
        .margin({ left: 8 })

      Blank()

      // Title
      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Blank()

      // Action Icon (Settings)
      Text('⚙️')
        .fontSize(24)
        .fontColor(AppColors.accent)
        .margin({ right: 8 })
        .onClick(() => {})
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - Root Screen
@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Column() {
      // Top Bar
      CustomTopBar()

      // Content
      Column({ space: AppSpacing.lg }) {
        // Battery and percentage group
        Column({ space: AppSpacing.md }) {
          BatteryIcon({ progress: this.progress })
            .width(60)
            .height(100)

          Text(`${Math.round(this.progress * 100)}%`)
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
        }
        .alignItems(HorizontalAlign.Center)
        .margin({ top: AppSpacing.md })

        // Progress Bar
        CustomProgressBar({ progress: this.progress })
          .margin({ top: AppSpacing.lg })

        // Simulate Button
        Button('Simulate Charge')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor(AppColors.secondary)
          .borderRadius(50)
          .margin({ top: AppSpacing.lg })
          .onClick(() => {
            animateTo({ curve: curves.springMotion() }, () => {
              this.progress += 0.1;
              if (this.progress > 1.0) {
                this.progress = 0.0;
              }
            });
          })

        // Status Text
        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1.0 ? AppColors.primary : AppColors.secondary)
          .margin({ top: AppSpacing.md })

        Blank()
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

// MARK: - Entry Point
@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}