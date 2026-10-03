/* ==========================================================================
 * pages/Index.ets
 * ========================================================================== */

import {
  AppColors,
  AppType,
  AppShape,
  AppSpacing,
  AppElevation,
  ShadowSpec,
  shadowColor
} from '../components/AppTokens';

/* data class CodeMarker(val id: Int, val name: String, val desc: String) */
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

  build() {
    Column() {
      /* CenterAlignedTopAppBar */
      this.TopBar()

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.SectionTitle('Project Files')

          /* LazyColumn(items) -> ForEach over a static model list */
          ForEach(this.markers, (m: CodeMarker) => {
            this.FileCard(m)
          }, (m: CodeMarker) => m.id.toString())

          this.SectionTitle('Live Terminal')
          this.Terminal()
          this.RunButton()
        }
        .width('100%')
        .constraintSize({ minHeight: '100%' })
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
        /* Brush.verticalGradient(primary@0.8 -> surface@0.9) */
        .linearGradient({
          angle: 180,
          colors: [[AppColors.gradientTop, 0.0], [AppColors.gradientBottom, 1.0]]
        })
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  /* ------------------------------------------------------- top app bar -- */

  @Builder
  TopBar() {
    Column() {
      Text('CodeIDE Terminal')
        .fontSize(AppType.displaySize)
        .fontWeight(AppType.displayWeight)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(64)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.background)
    .border({ width: { bottom: 1 }, color: AppColors.surface })
  }

  /* ----------------------------------------------------------- section -- */

  @Builder
  SectionTitle(label: string) {
    Text(label)
      .fontSize(AppType.headlineSize)
      .fontWeight(AppType.headlineWeight)
      .fontColor(AppColors.onBackground)
      .width('100%')
  }

  /* -------------------------------------------------------------- card -- */

  @Builder
  FileCard(m: CodeMarker) {
    Row({ space: AppSpacing.md }) {
      /* Box(32.dp, secondary, small shape) { Text(id) } */
      Stack({ alignContent: Alignment.Center }) {
        Text(m.id.toString())
          .fontSize(AppType.labelSize)
          .fontWeight(AppType.labelWeight)
          .fontColor(AppColors.onSecondary)
      }
      .width(32)
      .height(32)
      .backgroundColor(AppColors.secondary)
      .borderRadius(AppShape.radiusSmall)

      Column() {
        Text(m.name)
          .fontSize(AppType.titleSize)
          .fontWeight(AppType.titleWeight)
          .fontColor(AppColors.onSurface)
        Text(m.desc)
          .fontSize(AppType.bodySize)
          .fontWeight(AppType.bodyWeight)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShape.radiusMedium)
    .shadow({
      radius: AppElevation.level2.radius,
      color: shadowColor(AppElevation.level2.opacity),
      offsetX: 0,
      offsetY: AppElevation.level2.dy
    })
  }

  /* ---------------------------------------------------------- terminal -- */

  @Builder
  Terminal() {
    Stack({ alignContent: Alignment.TopStart }) {
      Text('> println("Hello, Kotlin!")')
        .fontSize(AppType.bodySize)
        .fontWeight(AppType.bodyWeight)
        .fontColor(AppColors.onSurface)
        .fontFamily('monospace')
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .height(240)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShape.radiusMedium)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppShape.radiusMedium
    })
  }

  /* ---------------------------------------------------------- run btn -- */

  @Builder
  RunButton() {
    Row() {
      Button('Run Code')
        .fontSize(AppType.titleSize)
        .fontWeight(AppType.titleWeight)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .width('60%')
        .height(48)
        .borderRadius(AppShape.radiusLarge)
        .shadow({
          radius: AppElevation.level2.radius,
          color: shadowColor(AppElevation.level2.opacity),
          offsetX: 0,
          offsetY: AppElevation.level2.dy
        })
        .onClick(() => {
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}