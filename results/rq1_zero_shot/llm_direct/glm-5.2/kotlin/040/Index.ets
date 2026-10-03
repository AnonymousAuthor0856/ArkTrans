// AppTokens.ets - Design tokens equivalent
class AppTokens {
  static readonly Colors = {
    primary: '#FF7B00',
    secondary: '#FFD166',
    background: '#FFF6E5',
    surface: '#FFFFFF',
    surfaceVariant: '#FFF0C1',
    outline: '#E0C080',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723',
  };

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
  };
}

// Model equivalent
class ResultItem {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

// RootScreen equivalent
@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State knobX: number = 160;
  @State knobY: number = 120;
  private results: ResultItem[] = Array.from({ length: 6 }, (_, i) => new ResultItem(i, `Result ${i + 1}`));
  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium'];

  build() {
    Column() {
      // Main Content Column
      Column() {
        Text('Retro Filter Search')
          .fontColor(AppTokens.Colors.onBackground)
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .margin({ bottom: AppTokens.Spacing.md });

        // Search Field
        TextInput({ text: this.query, placeholder: 'Search products' })
          .onChange((value) => this.query = value)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .borderWidth({ bottom: 1 })
          .borderColor(AppTokens.Colors.outline)
          .height(50)
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.md });

        // Filter Buttons Row
        Row({ space: AppTokens.Spacing.sm }) {
          ForEach(this.filters, (filter: string) => {
            Button(filter)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .height(36)
              .borderRadius(AppTokens.Shapes.small)
              .onClick(() => {});
          })
        }
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.md });

        // Canvas Box
        Stack() {
          Canvas(this)
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)
            .onReady(() => this.invalidate())
            .gesture(
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  this.knobX = event.fingerList[0].localX;
                  this.knobY = event.fingerList[0].localY;
                  this.invalidate();
                })
            )
        }
        .width('100%')
        .height(180)
        .margin({ bottom: AppTokens.Spacing.md });

        // Grid List
        List({ space: AppTokens.Spacing.lg }) {
          ForEach(this.results, (item: ResultItem) => {
            ListItem() {
              Column() {
                Box()
                  .width(96)
                  .height(96)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(AppTokens.Shapes.medium)
                  .margin({ bottom: AppTokens.Spacing.sm });

                Text(item.title)
                  .fontSize(AppTokens.Typography.title.fontSize)
                  .fontWeight(AppTokens.Typography.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ bottom: AppTokens.Spacing.sm });

                Button('Add')
                  .backgroundColor(AppTokens.Colors.primary)
                  .fontColor(AppTokens.Colors.onPrimary)
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .width('100%')
                  .borderRadius(AppTokens.Shapes.medium)
                  .onClick(() => {});
              }
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: 8, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 4 })
              .width('100%')
              .alignItems(HorizontalAlign.Center);
            }
          })
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ bottom: 24 });
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background);
    }
  }

  // Canvas drawing logic
  onDraw(context: CanvasRenderingContext2D) {
    const width = context.canvas.width;
    const height = context.canvas.height;
    
    // Draw Background Box
    context.fillStyle = AppTokens.Colors.surfaceVariant;
    context.fillRect(0, 0, width, height);

    // Draw Radial Gradient Circle
    const gradient = context.createRadialGradient(width / 2, height / 2, 0, width / 2, height / 2, 80);
    gradient.addColorStop(0, AppTokens.Colors.secondary);
    gradient.addColorStop(1, AppTokens.Colors.primary);
    context.fillStyle = gradient;
    context.beginPath();
    context.arc(width / 2, height / 2, 80, 0, Math.PI * 2);
    context.fill();

    // Draw Knob
    context.fillStyle = AppTokens.Colors.primary;
    context.beginPath();
    context.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    context.fill();
  }
}