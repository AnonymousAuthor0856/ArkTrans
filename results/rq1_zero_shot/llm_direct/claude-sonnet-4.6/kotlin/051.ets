import { drawing } from '@kit.ArkGraphics2D';

// Color tokens
const Colors = {
  primary: '#00FFFF',
  secondary: '#00B4FF',
  tertiary: '#8A2BE2',
  background: '#0A0A1A',
  surface: '#141436',
  surfaceVariant: '#1E1E4A',
  outline: '#2E2E5C',
  success: '#00FFAA',
  warning: '#FFCC00',
  error: '#FF4444',
  onPrimary: '#0A0A1A',
  onSecondary: '#FFFFFF',
  onBackground: '#FFFFFF',
  onSurface: '#FFFFFF',
};

const Spacing = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24,
  xxl: 36,
};

const stations = ['A', 'B', 'C', 'D', 'E', 'F'];

const departures = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'];

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main content
      Column() {
        // Background gradient simulation
        Column() {
          // Title
          Text('Metro Planner')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.primary)
            .margin({ bottom: Spacing.lg })

          // Metro Map Canvas
          MetroMapCanvas()
            .width('100%')
            .height(260)
            .margin({ bottom: Spacing.lg })

          // Next Departures Card
          DeparturesCard()

          Blank().height(Spacing.md)
        }
        .width('100%')
        .padding(Spacing.lg)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [0xFF0A0A1A, 0.0],
          [0xFF1E1E4A, 0.5],
          [0xFF0A0A1A, 1.0],
        ]
      })

      // Bottom Bar
      BottomBar()

      // FAB
      FABButton()
        .offset({ x: -16, y: -80 })
        .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}

@Component
struct MetroMapCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height(260)
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(22)
      .padding(10)
      .onReady(() => {
        this.drawMetroMap();
      })
  }

  drawMetroMap() {
    const w = this.ctx.width;
    const h = this.ctx.height;
    const count = stations.length;
    const step = w / (count - 1);

    // Draw path
    const gradient = this.ctx.createLinearGradient(0, 0, w, 0);
    gradient.addColorStop(0, Colors.secondary);
    gradient.addColorStop(1, Colors.primary);

    this.ctx.beginPath();
    this.ctx.strokeStyle = gradient;
    this.ctx.lineWidth = 6;
    this.ctx.lineJoin = 'round';
    this.ctx.lineCap = 'round';

    stations.forEach((_, i) => {
      const x = i * step;
      const y = i % 2 === 0 ? h / 4 : (h * 3) / 4;
      if (i === 0) {
        this.ctx.moveTo(x, y);
      } else {
        this.ctx.lineTo(x, y);
      }
    });
    this.ctx.stroke();

    // Draw station circles
    stations.forEach((_, i) => {
      const x = i * step;
      const y = i % 2 === 0 ? h / 4 : (h * 3) / 4;

      // Outer circle
      this.ctx.beginPath();
      this.ctx.arc(x, y, 16, 0, Math.PI * 2);
      this.ctx.fillStyle = Colors.primary;
      this.ctx.fill();

      // Inner circle
      this.ctx.beginPath();
      this.ctx.arc(x, y, 6, 0, Math.PI * 2);
      this.ctx.fillStyle = Colors.background;
      this.ctx.fill();
    });

    // Draw station labels
    this.ctx.fillStyle = Colors.onBackground;
    this.ctx.font = '12px sans-serif';
    this.ctx.textAlign = 'center';
    stations.forEach((label, i) => {
      const x = i * step;
      const y = i % 2 === 0 ? h / 4 : (h * 3) / 4;
      const labelY = i % 2 === 0 ? y - 26 : y + 36;
      this.ctx.fillText(label, x, labelY);
    });
  }
}

@Component
struct DeparturesCard {
  build() {
    Column({ space: Spacing.sm }) {
      Text('Next Departures')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.secondary)
        .margin({ bottom: Spacing.sm })

      ForEach(departures, (item: string) => {
        Row() {
          Text(item)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(Colors.onSurface)

          Text('On Time')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.success)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      })
    }
    .width('100%')
    .padding(Spacing.lg)
    .backgroundColor(Colors.surface)
    .borderRadius(22)
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 4,
    })
  }
}

@Component
struct BottomBar {
  build() {
    Row() {
      Text('Routes')
        .fontSize(14)
        .fontColor(Colors.secondary)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Planner')
        .fontSize(14)
        .fontColor(Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Tickets')
        .fontSize(14)
        .fontColor(Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Profile')
        .fontSize(14)
        .fontColor(Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(64)
    .backgroundColor(Colors.surface)
    .padding({ left: Spacing.lg, right: Spacing.lg })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct FABButton {
  build() {
    Button('+')
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(Colors.primary)
      .fontColor(Colors.onPrimary)
      .fontSize(24)
      .fontWeight(FontWeight.Medium)
      .shadow({
        radius: 12,
        color: '#4000FFFF',
        offsetX: 0,
        offsetY: 4,
      })
      .onClick(() => {})
  }
}