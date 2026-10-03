/**
 * 003VideoPlayeren — Media / "Modern Blue"
 * ArkTS (HarmonyOS ArkUI) port of the Kotlin Jetpack Compose single-file UI.
 * File: entry/src/main/ets/pages/Index.ets
 */

const NAME: string = '003VideoPlayeren';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/** ---------------------------------- Design tokens ---------------------------------- */
class AppTokens {
  // Colors
  static readonly primary: string = '#1E3A8A';
  static readonly secondary: string = '#3B82F6';
  static readonly secondaryAlpha20: string = '#333B82F6';
  static readonly background: string = '#0F172A';
  static readonly surface: string = '#1E293B';
  static readonly surfaceVariant: string = '#334155';
  static readonly outline: string = '#475569';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#F8FAFC';
  static readonly onSurface: string = '#E2E8F0';

  // Tonal (secondary-container) pair used by the filled tonal buttons / chips
  static readonly secondaryContainer: string = '#E8DEF8';
  static readonly onSecondaryContainer: string = '#1D1B20';
  static readonly onSurfaceMuted: string = '#94A3B8';

  // Typography (sp -> fp)
  static readonly displaySize: number = 28; // displayLarge  : 28sp Bold
  static readonly titleSize: number = 16;   // titleMedium   : 16sp Medium
  static readonly bodySize: number = 14;    // bodyMedium    : 14sp Normal
  static readonly labelSize: number = 12;   // labelMedium   : 12sp Medium

  // Shape
  static readonly radiusMedium: number = 12;
  static readonly radiusCircle: number = 36;
  static readonly radiusChip: number = 8;

  // Spacing
  static readonly spaceSm: number = 8;
  static readonly spaceMd: number = 12;
  static readonly spaceLg: number = 16;
  static readonly spaceXl: number = 24;
  static readonly spaceXxl: number = 32;
}

/** ---------------------------------- Helpers ---------------------------------- */
function formatTime(sec: number): string {
  const total: number = Math.max(0, Math.floor(sec));
  const m: number = Math.floor(total / 60);
  const s: number = total % 60;
  const ss: string = s < 10 ? `0${s}` : `${s}`;
  return `${m}:${ss}`;
}

/** ---------------------------------- Screen ---------------------------------- */
@Entry
@Component
struct Index {
  @State title: string = 'Journey through the Skies';
  @State currentTime: number = 95;
  @State totalTime: number = 240;
  @State playing: boolean = false;
  @State fullscreen: boolean = false;

  /** CenterAlignedTopAppBar — hidden while fullscreen. */
  @Builder
  TopBar() {
    Row() {
      Text('Video Player')
        .fontSize(AppTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onBackground)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.background)
  }

  /** FilledTonalButton equivalent. */
  @Builder
  TonalButton(label: string, onTap: () => void) {
    Text(label)
      .fontSize(AppTokens.titleSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokens.onSecondaryContainer)
      .textAlign(TextAlign.Center)
      .padding({
        left: AppTokens.spaceXl,
        right: AppTokens.spaceXl,
        top: AppTokens.spaceMd,
        bottom: AppTokens.spaceMd
      })
      .backgroundColor(AppTokens.secondaryContainer)
      .borderRadius(AppTokens.radiusMedium)
      .onClick(onTap)
  }

  /** FilterChip equivalent. */
  @Builder
  FullscreenChip() {
    Text(this.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
      .fontSize(AppTokens.bodySize)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.fullscreen ? AppTokens.onSurface : AppTokens.onSurfaceMuted)
      .padding({
        left: AppTokens.spaceLg,
        right: AppTokens.spaceLg,
        top: AppTokens.spaceSm,
        bottom: AppTokens.spaceSm
      })
      .borderRadius(AppTokens.radiusChip)
      .border({ width: 1, color: AppTokens.outline })
      .backgroundColor(this.fullscreen ? AppTokens.secondaryAlpha20 : '#00000000')
      .onClick(() => {
        this.fullscreen = !this.fullscreen;
      })
  }

  /** Transport bar: title, scrubber, timecodes, transport buttons, fullscreen chip. */
  @Builder
  Controls() {
    Column({ space: AppTokens.spaceMd }) {
      Text(this.title)
        .fontSize(AppTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .width('100%')

      Slider({
        value: this.currentTime,
        min: 0,
        max: this.totalTime,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .trackThickness(8)
        .selectedColor(AppTokens.primary)
        .trackColor(AppTokens.outline)
        .blockColor(AppTokens.primary)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.currentTime = value;
        })

      Row() {
        Text(formatTime(this.currentTime))
          .fontSize(AppTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3E2E8F0') // onSurface @ 70%
        Text(formatTime(this.totalTime))
          .fontSize(AppTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3E2E8F0')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        this.TonalButton('−10s', () => {
          this.currentTime = Math.max(0, this.currentTime - 10);
        })

        // FilledIconButton — 72dp play / pause
        Stack() {
          Text(this.playing ? 'II' : '▶')
            .fontSize(AppTokens.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.onPrimary)
        }
        .width(72)
        .height(72)
        .backgroundColor(AppTokens.primary)
        .borderRadius(AppTokens.radiusCircle)
        .alignContent(Alignment.Center)
        .onClick(() => {
          this.playing = !this.playing;
        })

        this.TonalButton('+30s', () => {
          this.currentTime = Math.min(this.totalTime, this.currentTime + 30);
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)

      Row() {
        this.FullscreenChip()
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.spaceXl)
  }

  build() {
    Column() {
      if (!this.fullscreen) {
        this.TopBar()
      }

      Column() {
        // Video surface — weight(1f) rounded Box
        Stack() {
          Text('Video Surface')
            .fontSize(AppTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onSurface)
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.surfaceVariant)
        .borderRadius(AppTokens.radiusMedium)
        .alignContent(Alignment.Center)

        this.Controls()
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}