const NAME: string = '003VideoPlayeren';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#1E3A8A';
  static readonly secondary: string = '#3B82F6';
  static readonly background: string = '#0F172A';
  static readonly surface: string = '#1E293B';
  static readonly surfaceVariant: string = '#334155';
  static readonly outline: string = '#475569';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#F8FAFC';
  static readonly onSurface: string = '#E2E8F0';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class VideoState {
  title: string;
  currentTime: number;
  totalTime: number;
  playing: boolean;
  fullscreen: boolean;

  constructor(title: string, currentTime: number, totalTime: number, playing: boolean, fullscreen: boolean) {
    this.title = title;
    this.currentTime = currentTime;
    this.totalTime = totalTime;
    this.playing = playing;
    this.fullscreen = fullscreen;
  }
}

function formatTime(sec: number): string {
  const total = Math.max(0, Math.floor(sec));
  const minutes = Math.floor(total / 60);
  const seconds = total % 60;
  return `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
}

@Entry
@Component
struct MainActivity {
  @State state: VideoState = new VideoState('Journey through the Skies', 95, 240, false, false);

  updateTime(currentTime: number): void {
    this.state = new VideoState(this.state.title, Math.max(0, Math.min(this.state.totalTime, currentTime)), this.state.totalTime, this.state.playing, this.state.fullscreen);
  }

  togglePlaying(): void {
    this.state = new VideoState(this.state.title, this.state.currentTime, this.state.totalTime, !this.state.playing, this.state.fullscreen);
  }

  toggleFullscreen(): void {
    this.state = new VideoState(this.state.title, this.state.currentTime, this.state.totalTime, this.state.playing, !this.state.fullscreen);
  }

  @Builder
  Header(): void {
    if (!this.state.fullscreen) {
      Text('Video Player')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.background);
    }
  }

  @Builder
  VideoSurface(): void {
    Stack() {
      Text('Video Surface')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
    }
    .width('100%')
    .layoutWeight(1)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(12)
    .alignContent(Alignment.Center);
  }

  @Builder
  Controls(): void {
    Column({ space: AppSpacing.md }) {
      Text(this.state.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Slider({ value: this.state.currentTime / this.state.totalTime, min: 0, max: 1 })
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.outline)
        .onChange((value: number) => {
          this.updateTime(value * this.state.totalTime);
        });
      Row() {
        Text(formatTime(this.state.currentTime))
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3E2E8F0');
        Blank();
        Text(formatTime(this.state.totalTime))
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3E2E8F0');
      }
      .width('100%');
      Row() {
        Button('-10s')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
          .onClick(() => {
            this.updateTime(this.state.currentTime - 10);
          });
        Button(this.state.playing ? 'II' : '▶')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(36)
          .width(72)
          .height(72)
          .onClick(() => {
            this.togglePlaying();
          });
        Button('+30s')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
          .onClick(() => {
            this.updateTime(this.state.currentTime + 30);
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center);
      Row() {
        Button(this.state.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(this.state.fullscreen ? '#333B82F6' : AppColors.surface)
          .border({ width: 1, color: AppColors.outline })
          .borderRadius(12)
          .onClick(() => {
            this.toggleFullscreen();
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.Center);
    }
    .width('100%')
    .padding(AppSpacing.xl);
  }

  build() {
    Column() {
      this.Header();
      Column() {
        this.VideoSurface();
        this.Controls();
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
