// MetroPlanner - Dark Neon Travel UI

class AppColors {
  primary: ResourceColor = '#00FFFF';
  secondary: ResourceColor = '#00B4FF';
  tertiary: ResourceColor = '#8A2BE2';
  background: ResourceColor = '#0A0A1A';
  surface: ResourceColor = '#141436';
  surfaceVariant: ResourceColor = '#1E1E4A';
  outline: ResourceColor = '#2E2E5C';
  success: ResourceColor = '#00FFAA';
  warning: ResourceColor = '#FFCC00';
  error: ResourceColor = '#FF4444';
  onPrimary: ResourceColor = '#0A0A1A';
  onSecondary: ResourceColor = '#FFFFFF';
  onBackground: ResourceColor = '#FFFFFF';
  onSurface: ResourceColor = '#FFFFFF';
}

class AppSpacing {
  sm: Length = 6;
  md: Length = 10;
  lg: Length = 16;
  xl: Length = 24;
  xxl: Length = 36;
}

const Colors = new AppColors();
const Spacing = new AppSpacing();

interface DepartureItem {
  time: string;
  status: string;
}

@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private departures: DepartureItem[] = [
    { time: '08:45 • Line 1', status: 'On Time' },
    { time: '09:10 • Line 2', status: 'On Time' },
    { time: '09:30 • Line 3', status: 'On Time' }
  ];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column() {
          // Title
          Text('Metro Planner')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.primary)
            .width('100%')
            .margin({ bottom: Spacing.lg });

          // Canvas for Metro Line
          Column() {
            MetroCanvas({ stations: this.stations })
          }
          .width('100%')
          .height(260)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(22)
          .padding(Spacing.md)
          .margin({ bottom: Spacing.lg });

          // Next Departures Card
          Column() {
            Text('Next Departures')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.secondary)
              .margin({ bottom: Spacing.sm });

            ForEach(this.departures, (item: DepartureItem) => {
              Row() {
                Text(item.time)
                  .fontSize(14)
                  .fontColor(Colors.onSurface);
                Text(item.status)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.success);
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ bottom: Spacing.sm });
            });
          }
          .width('100%')
          .padding(Spacing.lg)
          .backgroundColor(Colors.surface)
          .borderRadius(22)
          .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 });
        }
        .width('100%')
        .height('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.lg, bottom: 80 });
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [[Colors.background, 0.0], [Colors.surfaceVariant, 0.5], [Colors.background, 1.0]]
      });

      // Floating Action Button
      Button() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onPrimary);
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(Colors.primary)
      .margin({ right: Spacing.lg, bottom: 80 })
      .shadow({ radius: 8, color: '#66000000', offsetX: 0, offsetY: 4 });

      // Bottom App Bar
      Row() {
        Text('Routes')
          .fontSize(14)
          .fontColor(Colors.secondary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
        Text('Planner')
          .fontSize(14)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
        Text('Tickets')
          .fontSize(14)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
        Text('Profile')
          .fontSize(14)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
      }
      .width('100%')
      .height(56)
      .backgroundColor(Colors.surface)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .height('100%');
  }
}

@Component
struct MetroCanvas {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        const ctx = this.context;
        const w = ctx.width;
        const h = ctx.height;
        const step = w / (this.stations.length - 1);

        // Draw Path
        ctx.beginPath();
        for (let i = 0; i < this.stations.length; i++) {
          const x = i * step;
          const y = (i % 2 === 0) ? h / 4 : (h * 3) / 4;
          if (i === 0) {
            ctx.moveTo(x, y);
          } else {
            ctx.lineTo(x, y);
          }
        }
        
        const gradient = ctx.createLinearGradient(0, 0, w, 0);
        gradient.addColorStop(0, '#00B4FF');
        gradient.addColorStop(1, '#00FFFF');
        ctx.strokeStyle = gradient;
        ctx.lineWidth = 6;
        ctx.stroke();

        // Draw Circles
        for (let i = 0; i < this.stations.length; i++) {
          const x = i * step;
          const y = (i % 2 === 0) ? h / 4 : (h * 3) / 4;
          
          ctx.beginPath();
          ctx.arc(x, y, 16, 0, Math.PI * 2);
          ctx.fillStyle = '#00FFFF';
          ctx.fill();

          ctx.beginPath();
          ctx.arc(x, y, 6, 0, Math.PI * 2);
          ctx.fillStyle = '#0A0A1A';
          ctx.fill();
        }
      });
  }
}