import { router } from '@kit.ArkUI';

// Design tokens
const AppColors = {
  primary: '#3B82F6',
  secondary: '#06B6D4',
  tertiary: '#0EA5E9',
  background: '#F0F9FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E0F2FE',
  outline: '#CBD5E1',
  onPrimary: '#FFFFFF',
  onBackground: '#0F172A',
  onSurface: '#1E293B',
};

const AppSpacing = {
  sm: 8,
  md: 12,
  lg: 18,
  xl: 26,
};

@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('🌡')
          .fontSize(24)
          .fontColor(AppColors.primary)
          .margin({ left: 12 })

        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button({ type: ButtonType.Circle }) {
          Text('☀️')
            .fontSize(20)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
        .margin({ right: 8 })
        .onClick(() => {
          this.targetTemp++;
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surfaceVariant)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column() {
        // Target Temperature Label
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ bottom: AppSpacing.xl })

        // Temperature Display
        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .margin({ bottom: AppSpacing.xl })

        // +/- Buttons
        Row() {
          Button('–')
            .fontSize(20)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(8)
            .width(80)
            .height(44)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp--;
              }
            })

          Button('+')
            .fontSize(20)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(8)
            .width(80)
            .height(44)
            .margin({ left: AppSpacing.md })
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp++;
              }
            })
        }
        .margin({ bottom: AppSpacing.xl })

        // Divider
        Divider()
          .width('80%')
          .color(AppColors.outline)
          .opacity(0.5)
          .strokeWidth(1)
          .margin({ bottom: AppSpacing.xl })

        // Mode Label
        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ bottom: AppSpacing.lg })

        // Mode Buttons
        Row() {
          ModeButton({
            label: 'Cool',
            icon: '💨',
            currentMode: this.mode,
            onSelect: (selected: string) => {
              this.mode = selected;
            }
          })

          ModeButton({
            label: 'Heat',
            icon: '☀️',
            currentMode: this.mode,
            onSelect: (selected: string) => {
              this.mode = selected;
            }
          })
            .margin({ left: AppSpacing.lg })
        }
        .margin({ bottom: AppSpacing.xl })

        // Current Mode Display
        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#1806B6D4', 0.0],
          ['#333B82F6', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct ModeButton {
  label: string = '';
  icon: string = '';
  currentMode: string = '';
  onSelect: (label: string) => void = () => {};

  build() {
    Button({ type: ButtonType.Circle }) {
      Column() {
        Text(this.icon)
          .fontSize(32)
          .margin({ bottom: 4 })

        Text(this.label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.label === this.currentMode ? AppColors.onPrimary : AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(100)
    .height(100)
    .backgroundColor(this.label === this.currentMode ? AppColors.primary : AppColors.surfaceVariant)
    .shadow({
      radius: 6,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 2
    })
    .onClick(() => {
      this.onSelect(this.label);
    })
  }
}