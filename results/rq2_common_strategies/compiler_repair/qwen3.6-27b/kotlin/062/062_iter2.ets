import { window } from '@kit.ArkUI'
import { router } from '@kit.ArkUI'

interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface AppTokensConfig {
  Colors: ColorTokens;
  TypographyTokens: TypographyTokens;
  Spacing: SpacingTokens;
}

const AppTokens: AppTokensConfig = {
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
    onSurface: '#1E293B'
  },
  TypographyTokens: {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal }
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 18,
    xl: 26
  }
}

@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text('ThermoCurve')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Blank()

        // Heat Mode Icon Button (Top Right)
        Row() {
          Image($r('app.media.ic_sunny')) // Placeholder for WbSunny icon
            .width(24)
            .height(24)
            .fillColor(AppTokens.Colors.secondary)
        }
        .onClick(() => {
          this.targetTemp++
        })
        .padding({ right: 12 })
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .padding({ left: 16, right: 16 })

      // Main Content Area with Gradient Background
      Column() {
        Text('Target Temperature')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg })

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: 10 })

        // Temperature Controls
        Row() {
          Button('–')
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(20)
            .borderRadius(8)
            .width(60)
            .height(40)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp--
              }
            })

          Button('+')
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(20)
            .borderRadius(8)
            .width(60)
            .height(40)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp++
              }
            })
        }
        .justifyContent(FlexAlign.Center)
        .margin({ top: AppTokens.Spacing.xl })

        // Divider
        Divider()
          .color(AppTokens.Colors.outline)
          .opacity(0.5)
          .width('80%')
          .margin({ top: AppTokens.Spacing.xl })

        // Mode Selection
        Text('Mode')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xl })

        Row() {
          this.ModeButton('Cool', $r('app.media.ic_wind'), this.mode === 'Cool')
          this.ModeButton('Heat', $r('app.media.ic_sunny'), this.mode === 'Heat')
        }
        .justifyContent(FlexAlign.Center)
        .margin({ top: AppTokens.Spacing.lg })

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.secondary, 0.15],
          [AppTokens.Colors.primary, 0.2]
        ]
      })
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  ModeButton(label: string, iconResource: Resource, isSelected: boolean) {
    Column() {
      Image(iconResource)
        .width(32)
        .height(32)
        .fillColor(isSelected ? Color.White : AppTokens.Colors.onSurface)
      
      Text(label)
        .fontSize(12)
        .fontColor(isSelected ? Color.White : AppTokens.Colors.onSurface)
        .margin({ top: 4 })
    }
    .width(100)
    .height(100)
    .borderRadius(50) // CircleShape
    .backgroundColor(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.mode = label
    })
  }
}