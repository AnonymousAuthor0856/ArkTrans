import { window } from '@kit.ArkUI';

/**
 * AppTokens —— 颜色 / 字体 / 形状 / 间距设计令牌
 */
class AppColors {
  static readonly primary: string = '#3B82F6';
  static readonly secondary: string = '#06B6D4';
  static readonly tertiary: string = '#0EA5E9';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
  // 预乘透明度的派生色
  static readonly outline50: string = '#80CBD5E1';
  static readonly shadow10: string = '#1A000000';
  static readonly gradientStart: string = '#2606B6D4'; // secondary @ 15%
  static readonly gradientEnd: string = '#333B82F6';   // primary   @ 20%
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 18;
  static readonly xl: number = 26;
}

class AppShapes {
  static readonly smallCornerRadius: number = 8;
  static readonly mediumCornerRadius: number = 12;
  static readonly largeCornerRadius: number = 18;
}

/**
 * ModeButton —— 模式选择按钮（对应 SwiftUI 的 ModeButton）
 */
@Component
struct ModeButton {
  @Prop label: string;
  @Prop icon: Resource;
  @Prop currentMode: string;
  onSelect: (mode: string) => void = (mode: string) => {
  };

  private isSelected(): boolean {
    return this.label === this.currentMode;
  }

  build() {
    Column({ space: 6 }) {
      SymbolGlyph(this.icon)
        .fontSize(32)
        .fontColor([this.isSelected() ? AppColors.onPrimary : AppColors.onSurface])
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.isSelected() ? AppColors.onPrimary : AppColors.onSurface)
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.isSelected() ? AppColors.primary : AppColors.surfaceVariant)
    .borderRadius(50)
    .clip(true)
    .shadow({
      radius: 5,
      color: AppColors.shadow10,
      offsetX: 0,
      offsetY: 5
    })
    .onClick(() => {
      this.onSelect(this.label);
    })
  }
}

/**
 * RootScreen —— ThermoCurve 主界面
 */
@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';

  aboutToAppear(): void {
    // 全屏 + 隐藏状态栏 / 导航栏（对应 HostingController 的 prefersStatusBarHidden）
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: BusinessError) => {
        console.error(`setWindowLayoutFullScreen failed: ${err.code} ${err.message}`);
      });
  }

  @Builder
  AppBar() {
    Row() {
      SymbolGlyph($r('sys.symbol.thermometer_medium'))
        .fontSize(24)
        .fontColor([AppColors.primary])
        .margin({ left: AppSpacing.md })
        .onClick(() => {
          this.targetTemp += 1;
        })

      Blank()

      Text('ThermoCurve')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      Blank()

      SymbolGlyph($r('sys.symbol.sun_max_fill'))
        .fontSize(24)
        .fontColor([AppColors.secondary])
        .margin({ right: AppSpacing.md })
        .onClick(() => {
          this.targetTemp += 1;
        })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surfaceVariant)
  }

  @Builder
  TempStepperButton(symbol: string, enabled: boolean, action: () => void) {
    Button() {
      Text(symbol)
        .fontSize(20)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onPrimary)
    }
    .type(ButtonType.Normal)
    .width(60)
    .height(60)
    .backgroundColor(AppColors.primary)
    .borderRadius(AppShapes.smallCornerRadius)
    .opacity(enabled ? 1 : 0.4)
    .enabled(enabled)
    .onClick(action)
  }

  build() {
    Column() {
      this.AppBar()

      Column({ space: AppSpacing.xl }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Row({ space: AppSpacing.md }) {
          this.TempStepperButton('–', this.targetTemp > 10, () => {
            if (this.targetTemp > 10) {
              this.targetTemp -= 1;
            }
          })

          this.TempStepperButton('+', this.targetTemp < 35, () => {
            if (this.targetTemp < 35) {
              this.targetTemp += 1;
            }
          })
        }

        Divider()
          .width('80%')
          .strokeWidth(1)
          .color(AppColors.outline50)

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Row({ space: AppSpacing.lg }) {
          ModeButton({
            label: 'Cool',
            icon: $r('sys.symbol.wind'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            }
          })

          ModeButton({
            label: 'Heat',
            icon: $r('sys.symbol.sun_max_fill'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            }
          })
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.gradientStart, 0.0],
          [AppColors.gradientEnd, 1.0]
        ]
      })
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}