// AppTokens - 应用程序设计令牌
class AppTokens {
  static class Colors {
    static readonly primary: string = '#3B82F6'
    static readonly secondary: string = '#06B6D4'
    static readonly tertiary: string = '#0EA5E9'
    static readonly background: string = '#F0F9FF'
    static readonly surface: string = '#FFFFFF'
    static readonly surfaceVariant: string = '#E0F2FE'
    static readonly outline: string = '#CBD5E1'
    static readonly onPrimary: string = '#FFFFFF'
    static readonly onBackground: string = '#0F172A'
    static readonly onSurface: string = '#1E293B'
  }

  static class Shapes {
    static readonly smallCornerRadius: number = 8
    static readonly mediumCornerRadius: number = 12
    static readonly largeCornerRadius: number = 18
  }

  static class Spacing {
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 18
    static readonly xl: number = 26
  }
}

// ModeButton - 模式选择圆形按钮组件
@Component
struct ModeButton {
  label: string = ''
  iconName: string = ''
  currentMode: string = ''
  onSelect: (mode: string) => void = () => {}

  build() {
    Button() {
      Column() {
        if (this.iconName === 'wind') {
          // Wind icon (cool mode)
          Text('〰')
            .fontSize(32)
            .fontColor(this.label === this.currentMode
              ? AppTokens.Colors.onPrimary
              : AppTokens.Colors.onSurface)
        } else {
          // Sun icon (heat mode)
          Text('☀')
            .fontSize(32)
            .fontColor(this.label === this.currentMode
              ? AppTokens.Colors.onPrimary
              : AppTokens.Colors.onSurface)
        }
        Text(this.label)
          .fontSize(12)
          .fontColor(this.label === this.currentMode
            ? AppTokens.Colors.onPrimary
            : AppTokens.Colors.onSurface)
          .margin({ top: 4 })
      }
      .width(100)
      .height(100)
      .justifyContent(FlexAlign.Center)
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.label === this.currentMode
      ? AppTokens.Colors.primary
      : AppTokens.Colors.surfaceVariant)
    .borderRadius(50)
    .shadow({
      radius: 5,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 5
    })
    .onClick(() => {
      this.onSelect(this.label)
    })
  }
}

// RootScreen - 主屏幕
@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Column() {
      // 顶部栏
      Row() {
        Text('🌡')
          .fontSize(24)
          .fontColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.md })

        Blank()

        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Button() {
          Text('☀')
            .fontSize(24)
            .fontColor(AppTokens.Colors.secondary)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .margin({ right: AppTokens.Spacing.md })
        .onClick(() => {
          this.targetTemp += 1
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surfaceVariant)

      // 主要内容区域
      Column() {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.md })

        // 温度控制按钮
        Row() {
          Button() {
            Text('−')
              .fontSize(20)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .type(ButtonType.Normal)
          .width(60)
          .height(60)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp -= 1
            }
          })

          Button() {
            Text('+')
              .fontSize(20)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .type(ButtonType.Normal)
          .width(60)
          .height(60)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
          .margin({ left: AppTokens.Spacing.md })
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp += 1
            }
          })
        }
        .margin({ top: AppTokens.Spacing.lg })

        // 分隔线
        Divider()
          .width('80%')
          .color('rgba(203, 213, 225, 0.5)')
          .strokeWidth(1)
          .margin({ top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.md })

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)

        // 模式选择按钮
        Row() {
          ModeButton({
            label: 'Cool',
            iconName: 'wind',
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode
            }
          })

          ModeButton({
            label: 'Heat',
            iconName: 'sun.max.fill',
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode
            }
          })
          .margin({ left: AppTokens.Spacing.lg })
        }
        .margin({ top: AppTokens.Spacing.md })

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.secondary, 0.15],
          [AppTokens.Colors.primary, 0.2]
        ]
      })
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
  }
}
