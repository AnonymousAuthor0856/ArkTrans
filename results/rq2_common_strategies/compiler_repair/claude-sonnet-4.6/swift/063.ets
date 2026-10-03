import { curves } from '@kit.ArkUI';

// Design System Tokens - using classes instead of object literals
class AppColorsClass {
  primary: string = '#3B82F6';
  secondary: string = '#22C55E';
  background: string = '#F5F5F4';
  surface: string = '#FFFFFF';
  outline: string = '#D4D4D8';
  onPrimary: string = '#FFFFFF';
  onBackground: string = '#111827';
  onSurface: string = '#1F2937';
  accent: string = '#F59E0B';
}

class AppSpacingClass {
  sm: number = 6;
  md: number = 10;
  lg: number = 14;
  xl: number = 20;
  xxl: number = 40;
}

const AppColors: AppColorsClass = new AppColorsClass();
const AppSpacing: AppSpacingClass = new AppSpacingClass();

// Lightning Bolt Custom Shape
@Component
struct LightningBoltShape {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width(25)
      .height(40)
      .onReady(() => {
        const w: number = 25;
        const h: number = 40;
        const midX: number = w / 2;
        const minY: number = 0;
        const midY: number = h / 2;
        const maxY: number = h;

        this.context.fillStyle = AppColors.onPrimary;
        this.context.beginPath();
        this.context.moveTo(midX, minY + 5);
        this.context.lineTo(midX - 8, midY);
        this.context.lineTo(midX + 2, midY);
        this.context.lineTo(midX - 5, maxY - 5);
        this.context.lineTo(midX + 8, midY);
        this.context.lineTo(midX - 2, midY);
        this.context.closePath();
        this.context.fill();
      })
  }
}

// Battery Icon Component
@Component
struct BatteryIcon {
  @Prop progress: number = 0.45;

  build() {
    Stack() {
      Column() {
        // Battery top nub
        Row()
          .width(20)
          .height(10)
          .borderRadius(3)
          .backgroundColor(AppColors.primary)

        // Battery main body with lightning bolt
        Stack() {
          Column()
            .width(50)
            .height(90)
            .borderRadius(8)
            .backgroundColor(AppColors.primary)

          LightningBoltShape()
        }
        .width(50)
        .height(90)
      }
      .alignItems(HorizontalAlign.Center)
      .width(60)
      .height(110)
    }
    .width(60)
    .height(110)
  }
}

// Custom Progress Bar Component
@Component
struct CustomProgressBar {
  @Prop progress: number = 0.45;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track background
      Row()
        .width('100%')
        .height(12)
        .borderRadius(6)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: 6 })

      // Progress indicator
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

// Custom Top Bar Component
@Component
struct CustomTopBar {
  build() {
    Row() {
      // Electric car icon
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

      // Settings icon
      Text('⚙️')
        .fontSize(24)
        .fontColor(AppColors.accent)
        .margin({ right: 8 })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// Root Screen Component
@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Column() {
      // Top Bar
      CustomTopBar()

      // Content
      Column({ space: AppSpacing.lg }) {
        // Battery and percentage
        Column({ space: AppSpacing.md }) {
          BatteryIcon({ progress: this.progress })
            .margin({ top: AppSpacing.md })

          Text(`${Math.round(this.progress * 100)}%`)
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
        }
        .alignItems(HorizontalAlign.Center)
        .padding({ top: AppSpacing.md })

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

// Entry Point
@Entry
@Component
struct Index {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}