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
  static readonly onSurfaceMuted: string = '#9EA7B6';
  static readonly tonalButton: string = '#E9DDF7';
  static readonly tonalButtonText: string = '#241E32';
}

class AppTypography {
  static readonly display: number = 28;
  static readonly title: number = 16;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

class AppShapes {
  static readonly medium: number = 12;
  static readonly button: number = 20;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

function formatTime(sec: number): string {
  const total: number = Math.max(0, Math.floor(sec));
  const m: number = Math.floor(total / 60);
  const s: number = total % 60;
  return `${m}:${s < 10 ? '0' + s.toString() : s.toString()}`;
}

@Entry
@Component
struct Index {
  @State title: string = 'Journey through the Skies';
  @State currentTime: number = 95;
  @State totalTime: number = 240;
  @State playing: boolean = false;
  @State fullscreen: boolean = false;

  build() {
    Column() {
      if (!this.fullscreen) {
        Row() {
          Text('Video Player')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onBackground)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.background)
      }

      Stack() {
        Text('Video Surface')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .alignContent(Alignment.Center)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)

      Column({ space: AppSpacing.md }) {
        Text(this.title)
          .width('100%')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Slider({
          value: this.currentTime / this.totalTime,
          min: 0,
          max: 1,
          step: 0.001,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(36)
          .trackThickness(16)
          .blockColor(AppColors.primary)
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.outline)
          .showTips(false)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.currentTime = value * this.totalTime;
          })

        Row() {
          Text(formatTime(this.currentTime))
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurfaceMuted)

          Text(formatTime(this.totalTime))
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurfaceMuted)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('−10s')
              .fontSize(AppTypography.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.tonalButtonText)
          }
          .width(84)
          .height(40)
          .borderRadius(AppShapes.button)
          .backgroundColor(AppColors.tonalButton)
          .onClick(() => {
            this.currentTime = Math.max(0, this.currentTime - 10);
          })

          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Text(this.playing ? 'II' : '▶')
              .fontSize(AppTypography.display)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onPrimary)
          }
          .width(72)
          .height(72)
          .backgroundColor(AppColors.primary)
          .onClick(() => {
            this.playing = !this.playing;
          })

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('+30s')
              .fontSize(AppTypography.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.tonalButtonText)
          }
          .width(84)
          .height(40)
          .borderRadius(AppShapes.button)
          .backgroundColor(AppColors.tonalButton)
          .onClick(() => {
            this.currentTime = Math.min(this.totalTime, this.currentTime + 30);
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)

        Row() {
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text(this.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
              .fontSize(AppTypography.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.fullscreen ? AppColors.secondary : AppColors.onSurfaceMuted)
          }
          .height(32)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .borderRadius(AppShapes.medium)
          .backgroundColor(this.fullscreen ? '#213A5F' : AppColors.background)
          .border({
            width: 1,
            color: this.fullscreen ? AppColors.secondary : AppColors.outline
          })
          .onClick(() => {
            this.fullscreen = !this.fullscreen;
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(AppSpacing.xl)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}