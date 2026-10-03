// AppTokens
class AppColors {
  static readonly primary: string = '#38BDF8';
  static readonly secondary: string = '#A78BFA';
  static readonly tertiary: string = '#7DD3FC';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class AppShadows {
  static readonly level1Color: string = '#1F000000';
  static readonly level1Radius: number = 4;
  static readonly level1Dy: number = 2;
  static readonly level2Color: string = '#2E000000';
  static readonly level2Radius: number = 8;
  static readonly level2Dy: number = 4;
}

@Component
struct RootScreen {
  @State scrollOffsetY: number = 0;
  private lastOffsetY: number = 0;
  screenWidth: number = 360;
  lineNumbers: number[] = [1, 2, 3, 4, 5, 6, 7, 8];

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Text('Glass Doc Reader')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onSurface)
        .padding({ top: 20, bottom: AppSpacing.lg })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.background)

      // 主内容区域，相当于 Compose 的 Box
      Stack({ alignContent: Alignment.Center }) {
        // 背景渐变
        Row()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [['#CCE2E8F0', 0.0], [AppColors.background, 0.5], ['#CCE2E8F0', 1.0]]
          })

        // 相当于 Compose 的 Surface
        Column() {
          Text('Document Reader')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.primary)

          ForEach(this.lineNumbers, (index: number) => {
            Text('This is a sample line of text content number ' + index + '.')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onSurface)
          }, (index: number) => '' + index)

          Blank()
        }
        .alignItems(HorizontalAlign.Start)
        .space(AppSpacing.md)
        .padding(AppSpacing.lg)
        .width(this.screenWidth * 0.9)
        .height(400)
        .backgroundColor('#B3FFFFFF')
        .borderRadius(AppShapes.large)
        .shadow({ radius: AppShadows.level2Radius, color: AppShadows.level2Color, offsetX: 0, offsetY: AppShadows.level2Dy })
        .offset({ x: 0, y: this.scrollOffsetY / 5 })
        .gesture(
          PanGesture()
            .onActionStart(() => {
              this.lastOffsetY = 0;
            })
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffsetY += event.offsetY - this.lastOffsetY;
              this.lastOffsetY = event.offsetY;
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
