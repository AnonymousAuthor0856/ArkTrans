import { display } from '@kit.ArkUI';

// MARK: - AppTokens
const AppTokens = {
  Colors: {
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
  },
  Typography: {
    displaySize: 26,
    headlineSize: 18,
    titleSize: 14,
    bodySize: 12,
  },
  Shapes: {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 18,
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 18,
    xl: 26,
  },
};

// MARK: - ModeButton Component
@Component
struct ModeButton {
  label: string = '';
  iconName: Resource = $r('app.media.startIcon');
  @Prop currentMode: string = '';
  onSelect: (mode: string) => void = () => {};

  build() {
    let isSelected = this.label === this.currentMode;
    Button() {
      Column({ space: 4 }) {
        Image(this.iconName)
          .width(32)
          .height(32)
          .fillColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        Text(this.label)
          .fontSize(AppTokens.Typography.bodySize)
          .fontColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Regular)
      }
      .width(100)
      .height(100)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(100)
    .borderRadius(50)
    .backgroundColor(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .shadow({
      radius: 5,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 5,
    })
    .onClick(() => {
      this.onSelect(this.label);
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';
  @State screenWidth: number = 0;

  aboutToAppear() {
    let displayInfo = display.getDefaultDisplaySync();
    this.screenWidth = px2vp(displayInfo.width);
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.md })

        Blank()

        Text('ThermoCurve')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(AppTokens.Colors.secondary)
        }
        .backgroundColor(Color.Transparent)
        .margin({ right: AppTokens.Spacing.md })
        .onClick(() => {
          this.targetTemp += 1;
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content Area
      Column({ space: AppTokens.Spacing.xl }) {
        Text('Target Temperature')
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)

        // Temperature Control Buttons
        Row({ space: AppTokens.Spacing.md }) {
          Button('–')
            .fontSize(20)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(60)
            .height(60)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1;
              }
            })

          Button('+')
            .fontSize(20)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(60)
            .height(60)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1;
              }
            })
        }

        // Divider
        Divider()
          .width(this.screenWidth * 0.8)
          .strokeWidth(1)
          .color(AppTokens.Colors.outline)
          .opacity(0.5)

        Text('Mode')
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        // Mode Selection Buttons
        Row({ space: AppTokens.Spacing.lg }) {
          ModeButton({
            label: 'Cool',
            iconName: $r('app.media.startIcon'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            },
          })
          ModeButton({
            label: 'Heat',
            iconName: $r('app.media.startIcon'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            },
          })
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [`${AppTokens.Colors.secondary}26`, 0.0],
          [`${AppTokens.Colors.primary}33`, 1.0],
        ],
      })
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}