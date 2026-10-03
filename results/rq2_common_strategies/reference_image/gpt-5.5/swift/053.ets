import window from '@ohos.window';
import common from '@ohos.app.ability.common';

class AppColors {
  static readonly primary: string = '#1E293B';
  static readonly secondary: string = '#0EA5E9';
  static readonly tertiary: string = '#FACC15';
  static readonly background: string = '#1E293B';
  static readonly surface: string = '#1E293B';
  static readonly surfaceVariant: string = '#334155';
  static readonly outline: string = '#475569';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0B1220';
  static readonly onBackground: string = '#E2E8F0';
  static readonly onSurface: string = '#E2E8F0';
}

class AppTypography {
  static readonly display: number = 26;
  static readonly headline: number = 20;
  static readonly title: number = 16;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

class AppShadow {
  static readonly level1Color: string = '#1A000000';
  static readonly level1Radius: number = 2;
  static readonly level1OffsetY: number = 1;
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
struct Index {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes')
  ];

  aboutToAppear(): void {
    const context = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(context).then((win: window.Window) => {
      win.setWindowSystemBarEnable([]);
    }).catch(() => {
    });
  }

  @Builder
  CustomTopAppBar(title: string) {
    Row() {
      Text(title)
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColors.background)
  }

  @Builder
  CodeMarkerCard(marker: CodeMarker) {
    Row({ space: AppSpacing.md }) {
      Stack({ alignContent: Alignment.Center }) {
        Text(marker.id.toString())
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
      .width(32)
      .height(32)
      .borderRadius(AppShapes.small)
      .backgroundColor(AppColors.secondary)

      Column() {
        Text(marker.name)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text(marker.desc)
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.medium)
    .shadow({
      radius: AppShadow.level1Radius,
      color: AppShadow.level1Color,
      offsetX: 0,
      offsetY: AppShadow.level1OffsetY
    })
  }

  build() {
    Column() {
      this.CustomTopAppBar('CodeIDE Terminal')

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Project Files')
            .fontSize(AppTypography.headline)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)

          Column({ space: AppSpacing.sm }) {
            ForEach(this.markers, (marker: CodeMarker) => {
              this.CodeMarkerCard(marker)
            }, (marker: CodeMarker) => marker.id.toString())
          }
          .width('100%')
          .padding({
            bottom: AppSpacing.xl
          })

          Text('Live Terminal')
            .fontSize(AppTypography.headline)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)

          Stack({ alignContent: Alignment.TopStart }) {
            Text('> println("Hello, Kotlin!")')
              .fontSize(AppTypography.body)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onSurface)
              .padding(AppSpacing.md)
          }
          .width('100%')
          .height(240)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .border({
            width: 1,
            color: AppColors.outline
          })

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Run Code')
              .fontSize(AppTypography.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
          }
          .width('60%')
          .height(48)
          .alignSelf(ItemAlign.Center)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppShadow.level1Radius,
            color: AppShadow.level1Color,
            offsetX: 0,
            offsetY: AppShadow.level1OffsetY
          })
          .onClick(() => {
          })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.primary, 0.0],
          [AppColors.surface, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}