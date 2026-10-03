// ChargingProgressPage.ets
// ArkTS (HarmonyOS) port of the SwiftUI "Charging Progress" screen.
//
// Note on the status bar: SwiftUI used .statusBarHidden(true).
// In ArkTS that is a window-level concern — in EntryAbility.onWindowStageCreate():
//   windowStage.getMainWindow().then((win) => {
//     win.setWindowLayoutFullScreen(true);
//     win.setSpecificSystemBarEnabled('status', false);
//   });
// The page below additionally expands into the system safe area.

// MARK: - Design system tokens
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

// MARK: - Top bar
@Component
struct CustomTopBar {
  build() {
    Row() {
      // SF Symbol "bolt.car.fill" -> system symbol resource
      SymbolGlyph($r('sys.symbol.bolt_car_fill'))
        .fontSize(24)
        .fontColor([AppColors.primary])
        .margin({ left: 8 })

      Blank()

      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Blank()

      // SF Symbol "gearshape.fill"
      SymbolGlyph($r('sys.symbol.gearshape_fill'))
        .fontSize(24)
        .fontColor([AppColors.accent])
        .onClick(() => {
        })
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(AppColors.surface)
  }
}

// MARK: - Vertical battery icon with lightning bolt
@Component
struct BatteryIcon {
  @Prop progress: number = 0.45;

  build() {
    Column() {
      // Battery terminal / nub
      Row()
        .width(20)
        .height(10)
        .backgroundColor(AppColors.primary)
        .borderRadius({ topLeft: 3, topRight: 3 })

      // Battery body
      Stack() {
        Row()
          .width(50)
          .height(90)
          .backgroundColor(AppColors.primary)
          .borderRadius(8)

        // Lightning bolt, same polygon as the SwiftUI Path (25 x 40 box)
        Path()
          .commands('M12.5 5 L4.5 20 L14.5 20 L7.5 35 L20.5 20 L10.5 20 Z')
          .width(25)
          .height(40)
          .fill(AppColors.onPrimary)
      }
      .width(50)
      .height(90)
    }
    .width(60)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - Capsule progress bar
@Component
struct CustomProgressBar {
  @Prop progress: number = 0.45;

  private fraction(): number {
    return Math.min(Math.max(this.progress, 0), 1);
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height(12)
        .backgroundColor(AppColors.surface)
        .borderRadius(6)
        .border({ width: 1, color: AppColors.outline })

      // Indicator
      Row()
        .width(`${this.fraction() * 100}%`)
        .height(10)
        .margin({ left: 1 })
        .backgroundColor(AppColors.primary)
        .borderRadius(5)
    }
    .width('70%')
    .height(12)
  }
}

// MARK: - Root screen
@Entry
@Component
struct Index {
  @State progress: number = 0.45;

  private nextProgress(): number {
    const next: number = Math.round((this.progress + 0.1) * 100) / 100;
    return next > 1.0 ? 0.0 : next;
  }

  private simulateCharge(): void {
    animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
      this.progress = this.nextProgress();
    });
  }

  build() {
    Column() {
      CustomTopBar()

      Column() {
        BatteryIcon({ progress: this.progress })
          .margin({ top: AppSpacing.md })

        Text(`${Math.round(this.progress * 100)}%`)
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .margin({ top: AppSpacing.md })

        CustomProgressBar({ progress: this.progress })
          .margin({ top: AppSpacing.lg })

        Button('Simulate Charge', { type: ButtonType.Capsule })
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.secondary)
          .height(48)
          .padding({ left: 24, right: 24 })
          .margin({ top: AppSpacing.lg })
          .onClick(() => {
            this.simulateCharge();
          })

        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.progress < 1.0 ? AppColors.primary : AppColors.secondary)
          .margin({ top: AppSpacing.md })

        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}