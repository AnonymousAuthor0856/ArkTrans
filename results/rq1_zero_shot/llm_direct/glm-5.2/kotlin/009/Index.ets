// 003VideoPlayeren.ets

interface VideoState {
  title: string;
  currentTime: number;
  totalTime: number;
  playing: boolean;
  fullscreen: boolean;
}

interface AppTokensColors {
  primary: string;
  secondary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  error: string;
  onPrimary: string;
  onBackground: string;
  onSurface: string;
}

interface AppTokensSpacing {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static Colors: AppTokensColors = {
    primary: '#1E3A8A',
    secondary: '#3B82F6',
    background: '#0F172A',
    surface: '#1E293B',
    surfaceVariant: '#334155',
    outline: '#475569',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onBackground: '#F8FAFC',
    onSurface: '#E2E8F0',
  };

  static Spacing: AppTokensSpacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
}

function formatTime(sec: number): string {
  const total = Math.max(0, Math.floor(sec));
  const m = Math.floor(total / 60);
  const s = total % 60;
  return `${m}:${s < 10 ? '0' + s : s}`;
}

@Entry
@Component
struct RootScreen {
  @State state: VideoState = {
    title: 'Journey through the Skies',
    currentTime: 95,
    totalTime: 240,
    playing: false,
    fullscreen: false,
  };

  build() {
    Column() {
      if (!this.state.fullscreen) {
        Text('Video Player')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding(16)
          .backgroundColor(AppTokens.Colors.background);
      }

      Column() {
        // Video Surface
        Row() {
          Text('Video Surface')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: AppTokens.Spacing.xl });

        // Controls Column
        Column() {
          Text(this.state.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md });

          // Slider
          Row() {
            Slider({
              value: this.state.currentTime / this.state.totalTime,
              min: 0,
              max: 1,
              style: SliderStyle.OutSet,
            })
              .selectedColor(AppTokens.Colors.primary)
              .trackColor(AppTokens.Colors.outline)
              .blockColor(AppTokens.Colors.primary)
              .width('100%')
              .onChange((value: number, mode: SliderChangeMode) => {
                this.state.currentTime = value * this.state.totalTime;
              });
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.sm });

          // Time Row
          Row() {
            Text(formatTime(this.state.currentTime))
              .fontSize(12)
              .fontColor(AppTokens.Colors.onSurface)
              .opacity(0.7);
            Blank();
            Text(formatTime(this.state.totalTime))
              .fontSize(12)
              .fontColor(AppTokens.Colors.onSurface)
              .opacity(0.7);
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg });

          // Buttons Row
          Row() {
            Button('-10s')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .fontColor(AppTokens.Colors.onSurface)
              .borderRadius(12)
              .onClick(() => {
                this.state.currentTime = Math.max(0, this.state.currentTime - 10);
              });

            Button(this.state.playing ? 'II' : '▶')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .width(72)
              .height(72)
              .borderRadius(36)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .onClick(() => {
                this.state.playing = !this.state.playing;
              });

            Button('+30s')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .fontColor(AppTokens.Colors.onSurface)
              .borderRadius(12)
              .onClick(() => {
                this.state.currentTime = Math.min(this.state.totalTime, this.state.currentTime + 30);
              });
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: AppTokens.Spacing.lg });

          // Fullscreen Toggle
          Row() {
            Button(this.state.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .backgroundColor(this.state.fullscreen ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
              .fontColor(AppTokens.Colors.onSurface)
              .borderRadius(12)
              .opacity(this.state.fullscreen ? 0.5 : 1.0)
              .onClick(() => {
                this.state.fullscreen = !this.state.fullscreen;
              });
          }
          .width('100%')
          .justifyContent(FlexAlign.Center);
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.xl });
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}