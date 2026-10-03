import { router } from '@kit.ArkUI';

// App Tokens
const AppColors = {
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

const AppSpacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
};

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
  return `${m}:${s.toString().padStart(2, '0')}`;
}

@Entry
@Component
struct RootScreen {
  @State videoState: VideoState = {
    title: 'Journey through the Skies',
    currentTime: 95,
    totalTime: 240,
    playing: false,
    fullscreen: false,
  };

  build() {
    Column() {
      // Top App Bar
      if (!this.videoState.fullscreen) {
        Row() {
          Text('Video Player')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppColors.background)
      }

      // Video Surface
      Stack({ alignContent: Alignment.Center }) {
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(12)

      // Controls Section
      Column({ space: AppSpacing.md }) {
        // Title
        Text(this.videoState.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')

        // Slider
        Slider({
          value: (this.videoState.currentTime / this.videoState.totalTime) * 100,
          min: 0,
          max: 100,
          step: 0.1,
          style: SliderStyle.OutSet,
        })
          .width('100%')
          .trackColor(AppColors.outline)
          .selectedColor(AppColors.primary)
          .blockColor(AppColors.primary)
          .onChange((value: number) => {
            this.videoState = {
              ...this.videoState,
              currentTime: (value / 100) * this.videoState.totalTime,
            };
          })

        // Time Labels
        Row() {
          Text(formatTime(this.videoState.currentTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3E2E8F0')
          Text(formatTime(this.videoState.totalTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3E2E8F0')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // Playback Controls
        Row() {
          // -10s Button
          Button('−10s')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(12)
            .height(40)
            .onClick(() => {
              this.videoState = {
                ...this.videoState,
                currentTime: Math.max(0, this.videoState.currentTime - 10),
              };
            })

          // Play/Pause Button
          Button(this.videoState.playing ? 'II' : '▶')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(36)
            .width(72)
            .height(72)
            .onClick(() => {
              this.videoState = {
                ...this.videoState,
                playing: !this.videoState.playing,
              };
            })

          // +30s Button
          Button('+30s')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(12)
            .height(40)
            .onClick(() => {
              this.videoState = {
                ...this.videoState,
                currentTime: Math.min(this.videoState.totalTime, this.videoState.currentTime + 30),
              };
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)

        // Fullscreen Toggle
        Row() {
          Button(this.videoState.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
            .fontSize(14)
            .fontColor(this.videoState.fullscreen ? AppColors.secondary : AppColors.onSurface)
            .backgroundColor(
              this.videoState.fullscreen ? '#333B82F6' : AppColors.surfaceVariant
            )
            .borderRadius(20)
            .height(36)
            .padding({ left: 16, right: 16 })
            .onClick(() => {
              this.videoState = {
                ...this.videoState,
                fullscreen: !this.videoState.fullscreen,
              };
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(AppSpacing.xl)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}