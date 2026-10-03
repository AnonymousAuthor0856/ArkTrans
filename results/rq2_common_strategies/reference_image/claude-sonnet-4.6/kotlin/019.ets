// file: SubtitleEditor.ets
// 019SubtitleEditoren | Media | Clay Morph | en | 720x1280

import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

const NAME: string = '019SubtitleEditoren';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Clay Morph';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#8B5CF6';
  static readonly secondary: string = '#D946EF';
  static readonly tertiary: string = '#3B82F6';
  static readonly background: string = '#F9F5FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1E9FE';
  static readonly outline: string = '#E3D7FE';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppType {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 22;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

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

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(4, 8, 2, 0.14);
  static readonly level2: ShadowSpec = new ShadowSpec(8, 12, 6, 0.18);
}

@Entry
@Component
struct SubtitleEditor {
  @State fontSize: number = 24;
  @State syncProgress: number = 0.3;

  aboutToAppear(): void {
    window.getLastWindow(getContext(this) as common.UIAbilityContext)
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: BusinessError) => {
        console.error(`setSystemBars failed: ${err.code} ${err.message}`);
      });
  }

  @Builder
  clayPreviewCard() {
    Stack() {
      Text('Sample Subtitle Line')
        .fontSize(this.fontSize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(200)
    .borderRadius(AppShapes.large)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: ElevationMapping.level2.radius,
      color: 'rgba(30,30,30,0.18)',
      offsetX: 0,
      offsetY: ElevationMapping.level2.dy
    })
  }

  build() {
    Column() {
      // Top app bar
      Row() {
        Text('Subtitle Editor')
          .fontSize(AppType.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Body
      Column({ space: AppSpacing.lg }) {
        this.clayPreviewCard()

        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(AppType.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)

        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackThickness(16)
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.secondary)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.fontSize = value;
          })

        Text('Sync Progress')
          .fontSize(AppType.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)

        Progress({ value: this.syncProgress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .style({ strokeWidth: 6 })

        Row({ space: AppSpacing.md }) {
          Button('Sync +')
            .type(ButtonType.Normal)
            .width('100%')
            .height(48)
            .layoutWeight(1)
            .borderRadius(AppShapes.medium)
            .fontSize(AppType.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .linearGradient({
              angle: 135,
              colors: [[AppColors.primary, 0.0], ['#A855F7', 1.0]]
            })
            .onClick(() => {
              this.syncProgress = Math.min(1, this.syncProgress + 0.1);
            })

          Button('Sync -')
            .type(ButtonType.Normal)
            .width('100%')
            .height(48)
            .layoutWeight(1)
            .borderRadius(AppShapes.medium)
            .fontSize(AppType.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .linearGradient({
              angle: 135,
              colors: [[AppColors.secondary, 0.0], ['#C026D3', 1.0]]
            })
            .onClick(() => {
              this.syncProgress = Math.max(0, this.syncProgress - 0.1);
            })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.surfaceVariant, 0.0],
          [AppColors.background, 0.5],
          [AppColors.surface, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}