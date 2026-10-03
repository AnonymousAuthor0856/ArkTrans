// AppTokens - Colors, Typography, Shapes, Spacing
class AppColorsClass {
  primary: string = '#3B82F6';
  secondary: string = '#06B6D4';
  tertiary: string = '#0EA5E9';
  background: string = '#F0F9FF';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E0F2FE';
  outline: string = '#CBD5E1';
  onPrimary: string = '#FFFFFF';
  onBackground: string = '#0F172A';
  onSurface: string = '#1E293B';
}

class AppSpacingClass {
  sm: number = 8;
  md: number = 12;
  lg: number = 18;
  xl: number = 26;
}

class AppShapesClass {
  smallCornerRadius: number = 8;
  mediumCornerRadius: number = 12;
  largeCornerRadius: number = 18;
}

const AppColors = new AppColorsClass();
const AppSpacing = new AppSpacingClass();
const AppShapes = new AppShapesClass();

// ModeButton Component
@Component
struct ModeButton {
  label: string = '';
  iconName: Resource = $r('sys.symbol.thermometer');
  @Link currentMode: string;
  onSelect: (mode: string) => void = () => {};

  build() {
    Button() {
      Column({ space: 6 }) {
        Image(this.iconName)
          .width(32)
          .height(32)
          .fillColor(this.label === this.currentMode ? AppColors.onPrimary : AppColors.onSurface)

        Text(this.label)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.label === this.currentMode ? AppColors.onPrimary : AppColors.onSurface)
      }
      .width(100)
      .height(100)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(100)
    .borderRadius(50)
    .backgroundColor(this.label === this.currentMode ? AppColors.primary : AppColors.surfaceVariant)
    .shadow({ radius: 5, color: '#1A000000', offsetX: 0, offsetY: 5 })
    .onClick(() => {
      this.onSelect(this.label);
    })
  }
}

// RootScreen
@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';

  build() {
    Column() {
      // Top App Bar
      Row() {
        Image($r('sys.symbol.thermometer'))
          .width(24)
          .height(24)
          .fillColor(AppColors.primary)
          .margin({ left: AppSpacing.md })

        Blank()

        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Blank()

        Button() {
          Image($r('sys.symbol.sun_max'))
            .width(24)
            .height(24)
            .fillColor(AppColors.secondary)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
        .margin({ right: AppSpacing.md })
        .onClick(() => {
          this.targetTemp += 1;
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surfaceVariant)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Scroll() {
        Column({ space: AppSpacing.xl }) {
          Text('Target Temperature')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text(`${this.targetTemp}°C`)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)

          // Temperature Control Buttons
          Row({ space: AppSpacing.md }) {
            Button('–')
              .fontSize(20)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onPrimary)
              .width(60)
              .height(60)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.smallCornerRadius)
              .onClick(() => {
                if (this.targetTemp > 10) {
                  this.targetTemp -= 1;
                }
              })

            Button('+')
              .fontSize(20)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onPrimary)
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
          .justifyContent(FlexAlign.Center)

          // Divider
          Divider()
            .width('80%')
            .strokeWidth(1)
            .color(AppColors.outline)
            .opacity(0.5)

          Text('Mode')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          // Mode Buttons
          Row({ space: AppSpacing.lg }) {
            ModeButton({
              label: 'Cool',
              iconName: $r('sys.symbol.wind'),
              currentMode: $currentMode,
              onSelect: (selectedMode: string) => {
                this.mode = selectedMode;
              }
            })

            ModeButton({
              label: 'Heat',
              iconName: $r('sys.symbol.sun_max'),
              currentMode: $currentMode,
              onSelect: (selectedMode: string) => {
                this.mode = selectedMode;
              }
            })
          }
          .justifyContent(FlexAlign.Center)

          Text(`Current Mode: ${this.mode}`)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#2606B6D4', 0.0],
          ['#330EA5E9', 1.0]
        ]
      })
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}