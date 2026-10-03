// 003VideoPlayeren - Media - Modern Blue - en - 720x1280

interface AppColors {
  primary: number;
  secondary: number;
  background: number;
  surface: number;
  surfaceVariant: number;
  outline: number;
  error: number;
  onPrimary: number;
  onBackground: number;
  onSurface: number;
}

interface AppSpacing {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static Colors: AppColors = {
    primary: 0xFF1E3A8A,
    secondary: 0xFF3B82F6,
    background: 0xFF0F172A,
    surface: 0xFF1E293B,
    surfaceVariant: 0xFF334155,
    outline: 0xFF475569,
    error: 0xFFEF4444,
    onPrimary: 0xFFFFFFFF,
    onBackground: 0xFFF8FAFC,
    onSurface: 0xFFE2E8F0,
  };

  static Spacing: AppSpacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
}

interface VideoState {
  title: string;
  currentTime: number;
  totalTime: number;
  playing: boolean;
  fullscreen: boolean;
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

  private seekBackward(): void {
    this.state.currentTime = Math.max(0, this.state.currentTime - 10);
  }

  private togglePlay(): void {
    this.state.playing = !this.state.playing;
  }

  private seekForward(): void {
    this.state.currentTime = Math.min(this.state.totalTime, this.state.currentTime + 30);
  }

  private toggleFullscreen(): void {
    this.state.fullscreen = !this.state.fullscreen;
  }

  private onSliderChange(value: number): void {
    this.state.currentTime = value * this.state.totalTime;
  }

  build() {
    Column() {
      if (!this.state.fullscreen) {
        Text('Video Player')
          .fontSize(16)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding(16);
      }

      Column() {
        Column() {
          Text('Video Surface')
            .fontSize(16)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(12)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center);
        }
        .layoutWeight(1)
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.xl });

        Column({ space: AppTokens.Spacing.md }) {
          Text(this.state.title)
            .fontSize(16)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%');

          Slider({
            value: this.state.currentTime / this.state.totalTime,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet,
          })
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.outline)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.onSliderChange(value);
            });

          Row() {
            Text(formatTime(this.state.currentTime))
              .fontSize(12)
              .fontColor(AppTokens.Colors.onSurface);
            Blank();
            Text(formatTime(this.state.totalTime))
              .fontSize(12)
              .fontColor(AppTokens.Colors.onSurface);
          }
          .width('100%');

          Row() {
            Button('−10s')
              .onClick(() => {
                this.seekBackward();
              })
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .fontColor(AppTokens.Colors.onSurface)
              .borderRadius(12);

            Button(this.state.playing ? 'II' : '▶')
              .onClick(() => {
                this.togglePlay();
              })
              .width(72)
              .height(72)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .borderRadius(36)
              .fontSize(28);

            Button('+30s')
              .onClick(() => {
                this.seekForward();
              })
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .fontColor(AppTokens.Colors.onSurface)
              .borderRadius(12);
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center);

          Row() {
            Button(this.state.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
              .onClick(() => {
                this.toggleFullscreen();
              })
              .backgroundColor(this.state.fullscreen ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
              .fontColor(AppTokens.Colors.onSurface)
              .borderRadius(16);
          }
          .width('100%')
          .justifyContent(FlexAlign.Center);
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.xl });
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}