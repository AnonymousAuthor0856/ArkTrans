import window from '@ohos.window';

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
}

class AppTypography {
  static readonly displaySize: number = 26;
  static readonly headlineSize: number = 18;
  static readonly titleSize: number = 14;
  static readonly bodySize: number = 12;
}

class AppShapes {
  static readonly smallCornerRadius: number = 8;
  static readonly mediumCornerRadius: number = 12;
  static readonly largeCornerRadius: number = 18;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 18;
  static readonly xl: number = 26;
}

@Component
struct ModeButton {
  label: string = '';
  iconName: string = '';
  currentMode: string = '';
  onSelect: (mode: string) => void = () => {};

  private getIconText(): string {
    if (this.iconName === 'wind') {
      return '≋';
    }
    if (this.iconName === 'sun.max.fill') {
      return '☀';
    }
    return '●';
  }

  build() {
    Column({ space: AppSpacing.sm }) {
      Text(this.getIconText())
        .fontSize(32)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.label === this.currentMode ? AppColors.onPrimary : AppColors.onSurface)

      Text(this.label)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.label === this.currentMode ? AppColors.onPrimary : AppColors.onSurface)
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.label === this.currentMode ? AppColors.primary : AppColors.surfaceVariant)
    .borderRadius(50)
    .shadow({
      radius: 5,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 5
    })
    .onClick(() => {
      this.onSelect(this.label);
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private targetTemp: number = 22;
  @State private mode: string = 'Cool';

  aboutToAppear(): void {
    window.getLastWindow(getContext(this), (err, win) => {
      if (!err && win) {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      }
    });
  }

  build() {
    Column() {
      Row() {
        Text('🌡')
          .fontSize(24)
          .fontColor(AppColors.primary)
          .width(48)
          .height(56)
          .padding({ left: AppSpacing.md })
          .textAlign(TextAlign.Center)

        Blank()
          .layoutWeight(1)

        Text('ThermoCurve')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Blank()
          .layoutWeight(1)

        Text('☀')
          .fontSize(24)
          .fontColor(AppColors.secondary)
          .width(48)
          .height(56)
          .padding({ right: AppSpacing.md })
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.targetTemp += 1;
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surfaceVariant)

      Column({ space: AppSpacing.xl }) {
        Text('Target Temperature')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Row({ space: AppSpacing.md }) {
          Button() {
            Text('–')
              .fontSize(20)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onPrimary)
          }
          .width(60)
          .height(60)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.smallCornerRadius)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp -= 1;
            }
          })

          Button() {
            Text('+')
              .fontSize(20)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onPrimary)
          }
          .width(60)
          .height(60)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.smallCornerRadius)
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp += 1;
            }
          })
        }

        Divider()
          .width('80%')
          .height(1)
          .color('#80CBD5E1')

        Text('Mode')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Row({ space: AppSpacing.lg }) {
          ModeButton({
            label: 'Cool',
            iconName: 'wind',
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            }
          })

          ModeButton({
            label: 'Heat',
            iconName: 'sun.max.fill',
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            }
          })
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#2606B6D4', 0.0],
          ['#333B82F6', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}