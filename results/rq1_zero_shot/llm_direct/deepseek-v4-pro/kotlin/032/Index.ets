import { Component, View, Text, Button, Canvas, Column, Row, Stack, Progress, Shape, Circle, Rect, Path, Color, Font, Size, Position, EdgeInsets, Alignment, Length, Percentage, LinearGradient, GradientDirection, State, Prop, Builder, Preview } from '@ohos/arkui';

// AppTokens
class AppTokens {
  static readonly Colors = {
    primary: '#FFA500',
    secondary: '#FFC300',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
}

// RootScreen Component
@Component
struct RootScreen {
  @State markerPositionX: number = 200;
  @State markerPositionY: number = 400;
  @State progress: number = 0.4;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['#FFC300', 0.2],
            ['#FFFBF2', 0.5],
            ['#FFA500', 0.2]
          ]
        })

      // Canvas for circles
      Canvas()
        .width('100%')
        .height('100%')
        .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.xl })
        .onReady(() => {
          // Canvas drawing will be handled here
        })

      // Bottom content
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Transfer Progress')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Progress({ value: this.progress, total: 1.0, type: ProgressType.Linear })
          .width('80%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Row({ space: AppTokens.Spacing.md }) {
          Button('+')
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .onClick(() => {
              this.progress = Math.min(this.progress + 0.1, 1.0);
            })

          Button('-')
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .onClick(() => {
              this.progress = Math.max(this.progress - 0.1, 0.0);
            })
        }
      }
      .align(Alignment.Bottom)
      .padding({ bottom: AppTokens.Spacing.xxl })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// Main Entry Component
@Entry
@Component
struct TransferWizardApp {
  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Transfer Wizard')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content
      RootScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// Preview
@Preview
@Component
struct PreviewScreen {
  build() {
    TransferWizardApp()
  }
}