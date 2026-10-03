// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
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

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 12,
    large: 20,
  };

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
}

export class Marker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// Pages.ets
import { AppTokens, Marker } from './AppTokens';

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ];
  @State scanning: boolean = false;

  private canvasWidth: number = 0;
  private canvasHeight: number = 0;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Invoice Scanner')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center);

      // Content Area
      Scroll() {
        Column() {
          // Canvas Card
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Canvas(this)
                .width('100%')
                .height('100%')
                .padding(AppTokens.Spacing.md)
                .onAreaChange((oldValue, newValue) => {
                  this.canvasWidth = newValue.width as number;
                  this.canvasHeight = newValue.height as number;
                })
                .onReady(() => {
                  this.drawCanvas();
                });
            }
            .width('100%')
            .height(400)
          }
          .width('100%')
          .padding(0)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: 4 });

          // Scanning Active Row
          Row() {
            Text('Scanning Active')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onSurface);

            Toggle({ type: ToggleType.Switch, isOn: this.scanning })
              .selectedColor(AppTokens.Colors.secondary)
              .onChange((isOn: boolean) => {
                this.scanning = isOn;
              });
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg })
          .justifyContent(FlexAlign.SpaceBetween);

          // Add Marker Button
          Button('Add Marker')
            .width('100%')
            .height(48)
            .margin({ top: AppTokens.Spacing.lg })
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              if (this.scanning) {
                const newMarker = new Marker(
                  Math.floor(Math.random() * (580 - 80 + 1)) + 80,
                  Math.floor(Math.random() * (650 - 150 + 1)) + 150,
                  `N${this.markers.length + 1}`
                );
                this.markers.push(newMarker);
                this.drawCanvas();
              }
            });
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg);
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.3],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.3]
        ]
      });
    }
    .width('100%')
    .height('100%');
  }

  private drawCanvas() {
    const canvas = this.$refs.canvas as CanvasComponent;
    const ctx = canvas.getContext('2d');
    
    // Clear canvas
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw background circle
    const centerX = this.canvasWidth / 2;
    const centerY = this.canvasHeight / 2;
    const radius = Math.min(this.canvasWidth, this.canvasHeight) / 2.5;
    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.fill();

    // Draw markers
    this.markers.forEach((marker) => {
      ctx.fillStyle = AppTokens.Colors.primary;
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 12, 0, Math.PI * 2);
      ctx.fill();
    });
  }
}