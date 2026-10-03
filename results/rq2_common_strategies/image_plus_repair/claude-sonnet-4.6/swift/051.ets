// AppTokens as classes to avoid untyped object literals

class AppColors {
  static primary: string = '#00FFFF';
  static secondary: string = '#00B4FF';
  static tertiary: string = '#8A2BE2';
  static background: string = '#0A0A1A';
  static surface: string = '#141436';
  static surfaceVariant: string = '#1E1E4A';
  static outline: string = '#2E2E5C';
  static success: string = '#00FFAA';
  static warning: string = '#FFCC00';
  static error: string = '#FF4444';
  static onPrimary: string = '#0A0A1A';
  static onSecondary: string = '#FFFFFF';
  static onBackground: string = '#FFFFFF';
  static onSurface: string = '#FFFFFF';
}

class AppSpacing {
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 36;
}

class AppShapes {
  static smallCornerRadius: number = 8;
  static mediumCornerRadius: number = 14;
  static largeCornerRadius: number = 22;
}

const bottomBarHeight: number = 56;
const fabSize: number = 56;

const stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F'];
const departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'];

@Entry
@Component
struct RootScreen {
  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  drawMetro(context: CanvasRenderingContext2D): void {
    const width: number = context.width;
    const height: number = context.height;
    const step: number = width / (stations.length - 1);

    // Draw gradient line
    const gradient: CanvasGradient = context.createLinearGradient(0, 0, width, 0);
    gradient.addColorStop(0, '#00B4FF');
    gradient.addColorStop(1, '#00FFFF');

    context.beginPath();
    context.strokeStyle = gradient;
    context.lineWidth = 6;

    for (let i: number = 0; i < stations.length; i++) {
      const x: number = i * step;
      const y: number = i % 2 === 0 ? height / 4 : height * 3 / 4;
      if (i === 0) {
        context.moveTo(x, y);
      } else {
        context.lineTo(x, y);
      }
    }
    context.stroke();

    // Draw station circles
    for (let i: number = 0; i < stations.length; i++) {
      const x: number = i * step;
      const y: number = i % 2 === 0 ? height / 4 : height * 3 / 4;

      // Outer circle
      context.beginPath();
      context.fillStyle = '#00FFFF';
      context.arc(x, y, 16, 0, Math.PI * 2);
      context.fill();

      // Inner circle
      context.beginPath();
      context.fillStyle = '#0A0A1A';
      context.arc(x, y, 6, 0, Math.PI * 2);
      context.fill();
    }
  }

  build() {
    Stack() {
      // Background gradient
      Column() {
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0A0A1A', 0.0], ['#1E1E4A', 0.5], ['#0A0A1A', 1.0]]
      })

      // Main content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // Title
          Text('Metro Planner')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

          // Canvas area
          Canvas(this.canvasContext)
            .width('100%')
            .height(260)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.largeCornerRadius)
            .margin({ left: AppSpacing.lg, right: AppSpacing.lg })
            .padding(AppSpacing.md)
            .onReady(() => {
              this.drawMetro(this.canvasContext);
            })

          // Next Departures Card
          Column({ space: AppSpacing.sm }) {
            Text('Next Departures')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)
              .width('100%')
              .textAlign(TextAlign.Start)

            ForEach(departures, (departure: string) => {
              Row() {
                Text(departure)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppColors.onSurface)

                Blank()

                Text('On Time')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.success)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            })
          }
          .padding(AppSpacing.lg)
          .width('100%')
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.largeCornerRadius)
          .shadow({
            color: '#4D2E2E5C',
            radius: 8,
            offsetX: 0,
            offsetY: 4
          })
          .margin({ left: AppSpacing.lg, right: AppSpacing.lg })
          .alignItems(HorizontalAlign.Start)

          // Spacer
          Column()
            .height(AppSpacing.md + bottomBarHeight + fabSize)
        }
        .padding({ top: AppSpacing.lg })
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)

      // FAB
      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .width(fabSize)
            .height(fabSize)
            .backgroundColor(AppColors.primary)
            .borderRadius(fabSize / 2)
            .margin({
              right: AppSpacing.lg,
              bottom: bottomBarHeight + AppSpacing.lg
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Column() {
        Blank()
        Row() {
          Text('Routes')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.secondary)

          Blank()

          Text('Planner')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)

          Blank()

          Text('Tickets')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)

          Blank()

          Text('Profile')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(bottomBarHeight)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .backgroundColor(AppColors.surface)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}