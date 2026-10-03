// 026MindMapen.ets
import { 
  EntryComponent, 
  Component, 
  State, 
  VNode, 
  BuilderContext 
} from '@kit.ArkUI';
import { Length, ResourceStr } from '@ohos.arkui.UIContext';

interface Point {
  x: number;
  y: number;
}

class AppTokens {
  static readonly Colors = {
    primary: '#FF00FFFF',
    secondary: '#FF00FF88',
    tertiary: '#FFBB86FC',
    background: '#FF0D0D0D',
    surface: '#FF1C1C1C',
    surfaceVariant: '#FF2E2E2E',
    outline: '#FF3F3F3F',
    success: '#FF00FFAA',
    warning: '#FFFFC107',
    error: '#FFFF1744',
    onPrimary: '#FF000000',
    onSecondary: '#FF000000',
    onTertiary: '#FF000000',
    onBackground: '#FFFFFFFF',
    onSurface: '#FFFFFFFF'
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
    xl: 24
  };

  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  @State private nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State private currentColor: string = AppTokens.Colors.primary;

  private addRandomNode() {
    const x = Math.floor(Math.random() * 501) + 100;
    const y = Math.floor(Math.random() * 601) + 200;
    this.nodes.push({ x, y });
  }

  private handleDrag(event: GestureEvent) {
    this.nodes.push({ x: event.x, y: event.y });
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Top App Bar
        Row() {
          Text('Neon Mind Map')
            .fontSize(AppTokens.TypographyTokens.display.fontSize)
            .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
            .fontColor(AppTokens.Colors.primary)
            .margin({ top: 40, bottom: 16 })
        }
        .width('100%')
        .height(96)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.background);

        // Canvas Area
        Stack() {
          // Draw connections and nodes
          ForEach(this.nodes, (node: Point, index: number) => {
            if (index > 0) {
              Line()
                .startPoint({ x: this.nodes[index - 1].x, y: this.nodes[index - 1].y })
                .endPoint({ x: node.x, y: node.y })
                .strokeWidth(6)
                .strokeColor(this.currentColor)
                .fillColor(this.currentColor)
                .opacity(1);
            }
            Circle({ width: 40, height: 40 })
              .fillColor(this.currentColor)
              .position({ x: node.x - 20, y: node.y - 20 });
          }, (node: Point, index: number) => `${index}`);
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.handleDrag(event);
            })
        );

        // Bottom Bar
        Row() {
          Button('Cyan')
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .onClick(() => { this.currentColor = AppTokens.Colors.primary; })
            .margin({ right: 8 });

          Button('Green')
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .onClick(() => { this.currentColor = AppTokens.Colors.secondary; })
            .margin({ right: 8 });

          Button('Purple')
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onTertiary)
            .onClick(() => { this.currentColor = AppTokens.Colors.tertiary; });
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .justifyContent(FlexAlign.SpaceEvenly)
        .backgroundColor(AppTokens.Colors.surfaceVariant);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background);

      // Floating Action Button
      Button('+')
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .position({ x: '85%', y: '85%' })
        .onClick(() => { this.addRandomNode(); });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}