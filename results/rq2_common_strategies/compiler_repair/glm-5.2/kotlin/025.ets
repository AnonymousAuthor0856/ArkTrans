// Index.ets

const NAME: string = "026MindMapen";
const UI_TYPE: string = "Productivity";
const STYLE_THEME: string = "Dark Neon";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  primary: ResourceColor = "#FF00FFFF";
  secondary: ResourceColor = "#FF00FF88";
  tertiary: ResourceColor = "#FFBB86FC";
  background: ResourceColor = "#FF0D0D0D";
  surface: ResourceColor = "#FF1C1C1C";
  surfaceVariant: ResourceColor = "#FF2E2E2E";
  outline: ResourceColor = "#FF3F3F3F";
  success: ResourceColor = "#FF00FFAA";
  warning: ResourceColor = "#FFFFC107";
  error: ResourceColor = "#FFFF1744";
  onPrimary: ResourceColor = "#FF000000";
  onSecondary: ResourceColor = "#FF000000";
  onTertiary: ResourceColor = "#FF000000";
  onBackground: ResourceColor = "#FFFFFFFF";
  onSurface: ResourceColor = "#FFFFFFFF";
}

class AppSpacing {
  sm: Length = 8;
  md: Length = 12;
  lg: Length = 16;
  xl: Length = 24;
}

class ShadowSpec {
  elevation: Length;
  radius: Length;
  dy: Length;
  opacity: number;

  constructor(elevation: Length, radius: Length, dy: Length, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevationMapping {
  level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static Spacing: AppSpacing = new AppSpacing();
  static ElevationMapping: AppElevationMapping = new AppElevationMapping();
}

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State nodes: Point[] = [
    { x: 200, y: 400 } as Point,
    { x: 500, y: 700 } as Point,
    { x: 350, y: 250 } as Point
  ];
  @State currentColor: ResourceColor = AppTokens.Colors.primary;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private randomFloat(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column() {
        // Top App Bar
        Row() {
          Text("Neon Mind Map")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

        // Canvas Area
        Stack({ alignContent: Alignment.TopStart }) {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.context.strokeStyle = this.currentColor as string;
              this.context.fillStyle = this.currentColor as string;
              this.context.lineWidth = 6;

              for (let i = 1; i < this.nodes.length; i++) {
                let prev: Point = this.nodes[i - 1];
                let curr: Point = this.nodes[i];
                this.context.beginPath();
                this.context.moveTo(prev.x, prev.y);
                this.context.lineTo(curr.x, curr.y);
                this.context.stroke();
              }

              this.nodes.forEach((pt: Point) => {
                this.context.beginPath();
                this.context.arc(pt.x, pt.y, 20, 0, Math.PI * 2);
                this.context.fill();
              });
            })
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  const x: number = event.fingerList[0].localX;
                  const y: number = event.fingerList[0].localY;
                  this.nodes.push({ x: x, y: y } as Point);
                })
                .onActionUpdate((event: GestureEvent) => {
                  const x: number = event.fingerList[0].localX;
                  const y: number = event.fingerList[0].localY;
                  this.nodes.push({ x: x, y: y } as Point);
                })
            )
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)

        // Bottom Bar
        Row() {
          Button("Cyan")
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.primary;
            })
            .margin({ right: 8 })

          Button("Green")
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.secondary;
            })
            .margin({ right: 8 })

          Button("Purple")
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onTertiary)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.tertiary;
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Button("+")
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .position({ x: '80%', y: '85%' })
        .onClick(() => {
          const x: number = this.randomFloat(100, 600);
          const y: number = this.randomFloat(200, 800);
          this.nodes.push({ x: x, y: y } as Point);
        })
    }
    .width('100%')
    .height('100%')
  }
}