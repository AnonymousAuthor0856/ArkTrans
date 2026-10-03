/**
 * Unit Converter —— SwiftUI → ArkTS (HarmonyOS / ArkUI) 1:1 转换
 * 文件: entry/src/main/ets/pages/Index.ets
 *
 * 对应关系:
 *   SwiftUI AppTokens        -> ArkTS 静态只读常量类 (AppColors / AppTypography / AppShapes / AppSpacing)
 *   SwiftUI ButtonStyle      -> Button + 条件属性 (ArkTS 无独立 ButtonStyle 抽象)
 *   SwiftUI View struct      -> @Component struct
 *   @State / init()          -> @State active: string = 'Length'
 *   .padding / .cornerRadius -> .padding() / .borderRadius()
 *   .overlay(RoundedRect)    -> .border({ width, color, radius })
 *   VStack / HStack / Spacer -> Column / Row / (Row + Blank)
 *   LinearGradient           -> .linearGradient({ angle: 180, colors: [...] })
 */

// ============================== AppTokens ==============================

export class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  /** secondary @ 30% 透明度 (ARGB)，对应 secondary.opacity(0.3) */
  static readonly secondarySoft: string = '#4D38BDF8';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0F172A';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
  /** 渐变起点: secondary.opacity(0.15) */
  static readonly gradientStart: string = '#2638BDF8';
  /** 渐变终点: primary.opacity(0.15) */
  static readonly gradientEnd: string = '#262563EB';
}

export class AppTypography {
  // display: 24.sp / Bold
  static readonly displaySize: number = 24;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  // headline: 18.sp / SemiBold -> ArkUI 用 Medium 近似
  static readonly headlineSize: number = 18;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  // title: 14.sp / Medium
  static readonly titleSize: number = 14;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  // body: 12.sp / Normal
  static readonly bodySize: number = 12;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
}

export class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

export class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly buttonContentHorizontal: number = 16;
  static readonly buttonContentVertical: number = 8;
}

// ============================== MarkerBox ==============================

@Component
struct MarkerBox {
  @Prop unit: string = '';
  @Prop value: string = '';
  @Prop active: boolean = false;

  build() {
    Column() {
      Text(this.unit)
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)
      Text(this.value)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)      // contentAlignment = Alignment.CenterStart
    .justifyContent(FlexAlign.Center)       // 垂直居中
    .padding(AppSpacing.md)
    .width('100%')                          // fillMaxWidth()
    .height(80)
    .backgroundColor(this.active ? AppColors.secondarySoft : AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.medium })
  }
}

// ============================== MapArea ==============================

@Component
struct MapArea {
  @Prop selected: string = '';

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)
      Text(`Active Unit: ${this.selected}`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(HorizontalAlign.Center)     // horizontalAlignment = CenterHorizontally
    .justifyContent(FlexAlign.Center)       // verticalArrangement = Arrangement.Center
    .width('100%')                          // fillMaxWidth()
    .height(240)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.large })
  }
}

// ============================== RootScreen ==============================

@Entry
@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];
  @State active: string = 'Length';   // remember { mutableStateOf(markers.first()) }

  /** 渐变颜色数组（显式声明类型，便于 ArkTS 严格类型检查） */
  private gradientColors: Array<[ResourceColor, number]> = [
    [AppColors.gradientStart, 0.0],
    [AppColors.gradientEnd, 1.0]
  ];

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Unit Converter')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onBackground)

      MapArea({ selected: this.active })

      ForEach(this.markers, (marker: string) => {
        MarkerBox({
          unit: marker,
          value: 'Tap to convert',
          active: this.active === marker
        })
      }, (marker: string) => marker)

      // Spacer(Modifier.height(AppTokens.Spacing.md))
      // 上下各由 Column 的 space:lg 提供间距，Spacer 自身高度为 md
      Row() {
        Blank()
      }
      .width('100%')
      .height(AppSpacing.md)

      // Button Row: horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
      Row({ space: AppSpacing.md }) {
        ForEach(this.markers, (marker: string) => {
          Button(marker, { type: ButtonType.Normal, stateEffect: true })
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(this.active === marker ? AppColors.onPrimary : AppColors.onSurface)
            .backgroundColor(this.active === marker ? AppColors.primary : AppColors.surfaceVariant)
            .padding({
              left: AppSpacing.buttonContentHorizontal,
              right: AppSpacing.buttonContentHorizontal,
              top: AppSpacing.buttonContentVertical,
              bottom: AppSpacing.buttonContentVertical
            })
            .borderRadius(AppShapes.small)
            .onClick(() => {
              this.active = marker;
            })
        }, (marker: string) => marker)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .padding(AppSpacing.lg)
    .width('100%')    // fillMaxSize()
    .height('100%')
    .linearGradient({
      angle: 180,     // Brush.verticalGradient: 上 -> 下
      colors: this.gradientColors
    })
  }
}