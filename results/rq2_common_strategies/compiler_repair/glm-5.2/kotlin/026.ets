// Index.ets

const NAME: string = '027*DocReader*en';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Glassmorphic';
const LANG: string = 'en';
const BASELINE_SIZE: string = '750x1334';

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppTokens {
  static primary: string = '#38BDF8';
  static secondary: string = '#A78BFA';
  static tertiary: string = '#7DD3FC';
  static background: string = '#F1F5F9';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E2E8F0';
  static outline: string = '#CBD5E1';
  static success: string = '#22C55E';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E1E1E';
  static onTertiary: string = '#1E1E1E';
  static onBackground: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';

  static displayFontSize: number = 28;
  static titleFontSize: number = 18;
  static bodyFontSize: number = 14;
  static labelFontSize: number = 12;

  static smallRadius: number = 6;
  static mediumRadius: number = 12;
  static largeRadius: number = 20;

  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;

  static level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

@Entry
@Component
struct RootScreen {
  @State scrollOffsetY: number = 0;

  handlePanUpdate(event: GestureEvent): void {
    this.scrollOffsetY += event.offsetY;
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Background Gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.surfaceVariant, 0.8],
            [AppTokens.background, 1.0],
            [AppTokens.surfaceVariant, 0.8]
          ]
        });

      // Glassmorphic Surface
      Column() {
        Text('Document Reader')
          .fontSize(AppTokens.titleFontSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.primary)
          .margin({ bottom: AppTokens.md });

        ForEach([1, 2, 3, 4, 5, 6, 7, 8], (item: number) => {
          Text(`This is a sample line of text content number ${item}.`)
            .fontSize(AppTokens.bodyFontSize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.onSurface)
            .margin({ bottom: AppTokens.md });
        }, (item: number) => item.toString());
      }
      .width('90%')
      .height(400)
      .padding(AppTokens.lg)
      .backgroundColor(AppTokens.surface)
      .opacity(0.7)
      .borderRadius(AppTokens.largeRadius)
      .shadow({
        radius: AppTokens.level2.radius,
        color: `rgba(0,0,0,${AppTokens.level2.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.level2.dy
      })
      .offset({ y: this.scrollOffsetY / 5 })
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
    .gesture(
      PanGesture()
        .onActionUpdate(this.handlePanUpdate.bind(this))
    );
  }
}