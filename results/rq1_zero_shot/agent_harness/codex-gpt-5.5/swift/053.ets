class AppColors {
  static primary: string = '#1E293B';
  static secondary: string = '#0EA5E9';
  static tertiary: string = '#FACC15';
  static background: string = '#1E293B';
  static surface: string = '#1E293B';
  static surfaceVariant: string = '#334155';
  static outline: string = '#475569';
  static success: string = '#22C55E';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#0B1220';
  static onBackground: string = '#E2E8F0';
  static onSurface: string = '#E2E8F0';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 36;
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
struct RootScreen {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes')
  ];

  @Builder
  private CustomTopAppBar(title: string) {
    Row() {
      Blank()
      Text(title)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
      Blank()
    }
    .width('100%')
    .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.background)
  }

  @Builder
  private CodeMarkerCard(marker: CodeMarker) {
    Row({ space: AppSpacing.md }) {
      Stack() {
        Rect()
          .width(32)
          .height(32)
          .fill(AppColors.secondary)
          .radius(4)
        Text(marker.id.toString())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
      .width(32)
      .height(32)

      Column() {
        Text(marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(marker.desc)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(AppSpacing.md)
    .width('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(8)
    .shadow({ radius: 2, color: '#0000001A', offsetX: 0, offsetY: 1 })
  }

  @Builder
  private TerminalPanel() {
    Stack({ alignContent: Alignment.TopStart }) {
      Rect()
        .width('100%')
        .height(240)
        .fill(AppColors.surfaceVariant)
        .stroke(AppColors.outline)
        .strokeWidth(1)
        .radius(8)
      Text('> println("Hello, Kotlin!")')
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .padding(AppSpacing.md)
    }
    .width('100%')
    .height(240)
  }

  build() {
    Column({ space: 0 }) {
      this.CustomTopAppBar('CodeIDE Terminal')

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          Column({ space: AppSpacing.sm }) {
            ForEach(this.markers, (marker: CodeMarker) => {
              this.CodeMarkerCard(marker)
            })
          }
          .padding({ bottom: AppSpacing.xl })
          .width('100%')

          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          this.TerminalPanel()

          Row() {
            Button('Run Code')
              .width('60%')
              .height(48)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
              .backgroundColor(AppColors.secondary)
              .borderRadius(12)
              .shadow({ radius: 2, color: '#0000001A', offsetX: 0, offsetY: 1 })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .padding(AppSpacing.lg)
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
