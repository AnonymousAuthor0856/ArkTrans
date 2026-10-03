import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens
class ColorsTokens {
  primary: string = '#1E293B';
  secondary: string = '#0EA5E9';
  tertiary: string = '#FACC15';
  background: string = '#1E293B';
  surface: string = '#1E293B';
  surfaceVariant: string = '#334155';
  outline: string = '#475569';
  success: string = '#22C55E';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#FFFFFF';
  onTertiary: string = '#0B1220';
  onBackground: string = '#E2E8F0';
  onSurface: string = '#E2E8F0';
}

class TypographyTokens {
  displaySize: number = 26;
  headlineSize: number = 20;
  titleSize: number = 16;
  bodySize: number = 14;
  labelSize: number = 12;
}

class ShapesTokens {
  small: number = 4;
  medium: number = 8;
  large: number = 12;
}

class SpacingTokens {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 36;
}

class AppTokensClass {
  Colors: ColorsTokens = new ColorsTokens();
  Typography: TypographyTokens = new TypographyTokens();
  Shapes: ShapesTokens = new ShapesTokens();
  Spacing: SpacingTokens = new SpacingTokens();
}

const AppTokens = new AppTokensClass();

// MARK: - Data Model
class CodeMarker {
  id: number = 0;
  name: string = '';
  desc: string = '';

  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

const markers: CodeMarker[] = [
  new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
  new CodeMarker(2, 'Utils.kt', 'Helper functions'),
  new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
  new CodeMarker(4, 'Data.kt', 'Repository and model classes'),
];

// MARK: - CodeMarkerCard Component
@Component
struct CodeMarkerCard {
  marker: CodeMarker = new CodeMarker(0, '', '');

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      // ID Badge
      Stack() {
        Text(this.marker.id.toString())
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .width(32)
      .height(32)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(AppTokens.Shapes.small)

      // Name and Description
      Column({ space: 4 }) {
        Text(this.marker.name)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Start)
          .width('100%')

        Text(this.marker.desc)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Start)
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: 2,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1,
    })
  }
}

// MARK: - CustomTopAppBar Component
@Component
struct CustomTopAppBar {
  title: string = '';

  build() {
    Row() {
      Text(this.title)
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  build() {
    Column({ space: 0 }) {
      // Top App Bar
      CustomTopAppBar({ title: 'CodeIDE Terminal' })

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Project Files Header
          Text('Project Files')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .textAlign(TextAlign.Start)
            .width('100%')

          // File List
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(markers, (marker: CodeMarker) => {
              CodeMarkerCard({ marker: marker })
            }, (marker: CodeMarker) => marker.id.toString())
          }
          .width('100%')
          .padding({ bottom: AppTokens.Spacing.xl })

          // Live Terminal Header
          Text('Live Terminal')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .textAlign(TextAlign.Start)
            .width('100%')

          // Terminal Box
          Stack({ alignContent: Alignment.TopStart }) {
            // Background
            Column()
              .width('100%')
              .height(240)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: 1,
                color: AppTokens.Colors.outline,
                radius: AppTokens.Shapes.medium,
              })

            // Terminal Text
            Text('> println("Hello, Kotlin!")')
              .fontSize(AppTokens.Typography.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
          }
          .width('100%')
          .height(240)

          // Run Code Button
          Row() {
            Button('Run Code')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .width('60%')
              .height(48)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({
                radius: 2,
                color: '#1A000000',
                offsetX: 0,
                offsetY: 1,
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .constraintSize({ minHeight: '100%' })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#CC1E293B', 0.0],
          ['#E61E293B', 1.0],
        ],
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}