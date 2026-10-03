import { Component, View, Text, Button, Canvas, Column, Row, Box, Stack, Shape, Circle, Rect, Path, Line, Point, Color, Font, FontWeight, TextStyle, Border, BorderRadius, Padding, Margin, Size, Position, Offset, Gesture, DragGesture, TapGesture, PanGesture, SwipeGesture, PinchGesture, RotationGesture, LongPressGesture, Animation, Transition, State, Prop, Builder, Provide, Consume, Watch, Entry, Preview, LocalStorage, globalThis } from '@ohos/arkui';

// AppTokens
class AppTokens {
  static Colors = {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFFCF2',
    surface: '#FFF8E1',
    surfaceVariant: '#FCE7E7',
    outline: '#BDBDBD',
    success: '#06D6A0',
    warning: '#FFA600',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#1F1F1F',
    onTertiary: '#1F1F1F',
    onBackground: '#1F1F1F',
    onSurface: '#1F1F1F'
  };

  static TypographyTokens = {
    display: { fontSize: 30, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static Shapes = {
    small: 6,
    medium: 12,
    large: 16
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
}

// AppTheme wrapper
@Component
struct AppTheme {
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content();
    }
    .backgroundColor(AppTokens.Colors.background)
  }
}

// RootScreen
@Component
struct RootScreen {
  @State knobPositionX: number = 300;
  @State knobPositionY: number = 300;
  @State knobCenterX: number = 140;
  @State knobCenterY: number = 140;

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Retro Music Player')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .padding({ left: 16, right: 16 })

      // Main content
      Column() {
        // Knob area
        Stack() {
          // Outer circle
          Canvas(this.knobCanvasContext)
            .width(280)
            .height(280)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 3, color: AppTokens.Colors.outline })
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  this.knobPositionX = event.offsetX;
                  this.knobPositionY = event.offsetY;
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.knobPositionX = event.offsetX;
                  this.knobPositionY = event.offsetY;
                })
            )
        }
        .width(280)
        .height(280)
        .align(Alignment.Center)

        // Track title
        Text('Track: Summer Nights')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 24 })

        // Buttons row
        Row() {
          Button('Play')
            .width(120)
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .borderRadius(AppTokens.Shapes.medium)
            .margin({ right: 8 })

          Button('Pause')
            .width(120)
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .borderRadius(AppTokens.Shapes.medium)
            .margin({ left: 8 })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 24 })

        // Knob position text
        Text(`Knob X:${Math.round(this.knobPositionX)} Y:${Math.round(this.knobPositionY)}`)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.tertiary)
          .margin({ top: 16 })

        // Spacer
        Row()
          .height(AppTokens.Spacing.xxl)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  knobCanvasContext(context: CanvasRenderingContext2D) {
    // Draw outer circle
    context.beginPath();
    context.arc(140, 140, 120, 0, Math.PI * 2);
    context.strokeStyle = AppTokens.Colors.secondary;
    context.lineWidth = 12;
    context.stroke();

    // Draw knob
    context.beginPath();
    context.arc(this.knobPositionX, this.knobPositionY, 20, 0, Math.PI * 2);
    context.fillStyle = AppTokens.Colors.primary;
    context.fill();
  }
}

// Main entry
@Entry
@Component
struct MusicPlayerApp {
  build() {
    AppTheme() {
      RootScreen()
    }
  }
}