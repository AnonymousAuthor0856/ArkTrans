import { Component, View, Text, Canvas, Button, Switch, Column, Row, Stack, Shape, Colors, Font, FontWeight, BorderRadius, LinearGradient, GradientDirection, Alignment, EdgeInsets, Size, Offset, Color, State, Random } from '@ohos/arkui';

// AppTokens
class AppTokens {
  static Colors = {
    primary: '#06B6D4',
    secondary: '#3B82F6',
    tertiary: '#8B5CF6',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  };

  static Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static Shapes = {
    small: 6,
    medium: 12,
    large: 20
  };

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static Elevation = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };
}

// Marker data class
class Marker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// RootScreen component
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ];
  @State scanning: boolean = false;

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Invoice Scanner')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
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
        // Scanner surface
        Stack() {
          Canvas()
            .width('100%')
            .height('100%')
            .onReady((canvas: CanvasRenderingContext2D) => {
              const width = canvas.width;
              const height = canvas.height;
              const centerX = width / 2;
              const centerY = height / 2;
              const radius = Math.min(width, height) / 2.5;

              // Draw background circle
              canvas.fillStyle = AppTokens.Colors.surfaceVariant;
              canvas.beginPath();
              canvas.arc(centerX, centerY, radius, 0, 2 * Math.PI);
              canvas.fill();

              // Draw markers
              this.markers.forEach((marker: Marker) => {
                canvas.fillStyle = AppTokens.Colors.primary;
                canvas.beginPath();
                canvas.arc(marker.x, marker.y, 12, 0, 2 * Math.PI);
                canvas.fill();
              });
            })
        }
        .width('100%')
        .height(400)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: AppTokens.Elevation.level2.radius, color: 'rgba(0,0,0,0.18)', offsetY: AppTokens.Elevation.level2.dy })
        .padding(AppTokens.Spacing.md)

        // Scanning toggle row
        Row() {
          Text('Scanning Active')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)

          Switch(this.scanning)
            .selectedColor(AppTokens.Colors.secondary)
            .onChange((value: boolean) => {
              this.scanning = value;
            })
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg })

        // Add marker button
        Button('Add Marker')
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ top: AppTokens.Spacing.lg })
          .onClick(() => {
            if (this.scanning) {
              const newX = Math.floor(Math.random() * (580 - 80 + 1)) + 80;
              const newY = Math.floor(Math.random() * (650 - 150 + 1)) + 150;
              this.markers.push(new Marker(newX, newY, `N${this.markers.length + 1}`));
            }
          })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#3B82F6', 0.3],
          [AppTokens.Colors.background, 1.0],
          ['#06B6D4', 0.3]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// Main entry
@Entry
@Component
struct MainPage {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}