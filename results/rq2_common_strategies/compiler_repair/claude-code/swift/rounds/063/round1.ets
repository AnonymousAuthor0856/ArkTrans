// Charging Progress App - ArkTS Conversion
// Design System Tokens
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

// Lightning Bolt Path commands
function getLightningBoltPath(w: number, h: number): string {
  const mx = w / 2;
  let d = `M ${mx} ${5} `;
  d += `L ${mx - 8} ${h / 2} `;
  d += `L ${mx + 2} ${h / 2} `;
  d += `L ${mx - 5} ${h - 5} `;
  d += `L ${mx + 8} ${h / 2} `;
  d += `L ${mx - 2} ${h / 2} `;
  d += 'Z';
  return d;
}

// Custom Top Bar Component
@Component
struct CustomTopBar {
  build() {
    Row() {
      Text('⚡')
        .fontSize(24)
        .fontColor(AppColors.primary)
        .padding({ left: 8 })

      Blank()

      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Blank()

      Text('⚙')
        .fontSize(24)
        .fontColor(AppColors.accent)
        .padding({ right: 8 })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppColors.surface)
  }
}

// Battery Icon Component
@Component
struct BatteryIcon {
  @Prop progress: number = 0;

  build() {
    Stack() {
      // Battery body
      Row()
        .width(50)
        .height(90)
        .borderRadius(8)
        .backgroundColor(AppColors.primary)

      // Battery top nub
      Row()
        .width(20)
        .height(10)
        .borderRadius(3)
        .backgroundColor(AppColors.primary)
        .translate({ y: -50 })

      // Lightning bolt
      Path()
        .commands(getLightningBoltPath(25, 40))
        .fill(AppColors.onPrimary)
        .width(25)
        .height(40)
    }
    .width(60)
    .height(100)
  }
}

// Custom Progress Bar Component
@Component
struct CustomProgressBar {
  @Prop progress: number = 0;

  aboutToAppear() {
    // Clamp progress
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height('100%')
        .borderRadius(999)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline })

      // Indicator
      Row()
        .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
        .height('100%')
        .borderRadius(999)
        .backgroundColor(AppColors.primary)
        .padding(1)
    }
    .width('100%')
    .height(12)
    .clip(true)
    .borderRadius(999)
  }
}

// Root Screen
@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      Column() {
        // Top Bar
        CustomTopBar()

        Column({ space: AppSpacing.lg }) {
          // Battery and percentage
          Column({ space: AppSpacing.md }) {
            BatteryIcon({ progress: this.progress })

            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onBackground)
          }
          .margin({ top: AppSpacing.md })

          // Progress Bar
          CustomProgressBar({ progress: this.progress })
            .width('70%')
            .margin({ top: AppSpacing.lg })

          // Simulate Button
          Button('Simulate Charge')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(999)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .margin({ top: AppSpacing.lg })
            .onClick(() => {
              animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
                this.progress += 0.1;
                if (this.progress > 1.0) {
                  this.progress = 0.0;
                }
              })
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
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
