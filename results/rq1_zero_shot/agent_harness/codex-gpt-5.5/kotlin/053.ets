const NAME: string = "078_CodeIDE_en";
const UI_TYPE: string = "Education Terminal";
const STYLE_THEME: string = "Retro Flat";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#1E293B';
  static readonly secondary: string = '#0EA5E9';
  static readonly tertiary: string = '#FACC15';
  static readonly background: string = '#111827';
  static readonly surface: string = '#1E293B';
  static readonly surfaceVariant: string = '#334155';
  static readonly outline: string = '#475569';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#E2E8F0';
  static readonly onSurface: string = '#E2E8F0';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class CodeMarker {
  id: number;
  name: string;
  desc: string;

  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

@Entry
@Component
struct MainActivity {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes')
  ];

  @Builder
  FileCard(marker: CodeMarker) {
    Row({ space: AppSpacing.md }) {
      Text(marker.id.toString())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .textAlign(TextAlign.Center)
        .width(32)
        .height(32)
        .lineHeight(32)
        .backgroundColor(AppColors.secondary)
        .borderRadius(4)

      Column() {
        Text(marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(marker.desc)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .opacity(0.86)
          .margin({ top: 3 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(8)
  }

  build() {
    Column() {
      Row() {
        Text('CodeIDE Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(64)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          Column({ space: AppSpacing.sm }) {
            ForEach(this.markers, (marker: CodeMarker) => {
              this.FileCard(marker)
            })
          }
          .width('100%')

          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          Column() {
            Text('> println("Hello, Kotlin!")')
              .fontSize(14)
              .fontColor(AppColors.onSurface)
              .fontFamily('monospace')
              .width('100%')
          }
          .width('100%')
          .height(240)
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(8)
          .border({ width: 1, color: AppColors.outline })
          .alignItems(HorizontalAlign.Start)

          Button('Run Code')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .width('60%')
            .height(48)
            .backgroundColor(AppColors.secondary)
            .borderRadius(12)
            .alignSelf(ItemAlign.Center)
        }
        .width('100%')
        .padding(AppSpacing.lg)
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.primary)
      .linearGradient({
        angle: 180,
        colors: [[AppColors.primary, 0.0], [AppColors.surface, 1.0]]
      })
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
