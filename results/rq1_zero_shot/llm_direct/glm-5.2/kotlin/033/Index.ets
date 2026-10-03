// Build configuration: ohpm install @ohos/hypium
// Entry: ets/pages/Index.ets

import { Length, ResourceColor } from '@ohos.arkui.arkui';

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors = {
    primary: '#FF06B6D4',
    secondary: '#FF3B82F6',
    tertiary: '#FF8B5CF6',
    background: '#FFF0F9FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE0F2FE',
    outline: '#FFBAE6FD',
    success: '#FF22C55E',
    warning: '#FFFACC15',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A',
  };
  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };
  static Shapes = {
    small: 6,
    medium: 12,
    large: 20,
  };
  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
  static ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  };
}

@Entry
@Component
struct RootScreen {
  @State spending: number = 500;
  private goal: number = 1000;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Bill Calendar')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .padding({ horizontal: AppTokens.Spacing.lg })

      // Content
      Scroll() {
        Column() {
          // Spending Card
          Column() {
            Text('Current Spending')
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .fontColor(AppTokens.Colors.primary)

            Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
              .fontSize(AppTokens.TypographyTokens.display.fontSize)
              .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ top: AppTokens.Spacing.sm })

            // Linear Progress Indicator
            Row() {
              Column()
                .width(`${(this.spending / this.goal) * 100}%`)
                .height(8)
                .backgroundColor(AppTokens.Colors.primary)
                .borderRadius(4)
            }
            .width('100%')
            .height(8)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(4)
            .margin({ top: AppTokens.Spacing.lg })
          }
          .width('100%')
          .height(160)
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })
          .justifyContent(FlexAlign.SpaceBetween)

          Text('Adjust Spending')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xl })

          // Slider
          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(AppTokens.Colors.secondary)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.spending = value;
            })

          // Reset Button
          Button('Reset')
            .width('100%')
            .height(48)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.medium)
            .margin({ top: AppTokens.Spacing.lg })
            .onClick(() => {
              this.spending = 0;
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.3],
          [AppTokens.Colors.background, 0.6],
          [AppTokens.Colors.primary, 0.2]
        ]
      })
    }
    .width('100%')
    .height('100%')
  }
}