// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#1E293B',
    secondary: '#0EA5E9',
    tertiary: '#FACC15',
    background: '#1E293B',
    surface: '#1E293B',
    surfaceVariant: '#334155',
    outline: '#475569',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#E2E8F0',
    onSurface: '#E2E8F0'
  };

  static readonly Typography = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.SemiBold },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Regular },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  static readonly Shadow = {
    level1: { radius: 2, y: 1, opacity: 0.1 },
    level2: { radius: 4, y: 2, opacity: 0.14 },
    level3: { radius: 6, y: 3, opacity: 0.16 }
  };
}

// CodeMarker.ets
export class CodeMarker {
  id: number;
  name: string;
  desc: string;

  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

// CustomTopAppBar.ets
import { AppTokens } from './AppTokens';

@Component
export struct CustomTopAppBar {
  title: string = '';

  build() {
    Row() {
      Blank()
      Text(this.title)
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
      Blank()
    }
    .width('100%')
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }
}

// CodeMarkerCard.ets
import { AppTokens } from './AppTokens';
import { CodeMarker } from './CodeMarker';

@Component
export struct CodeMarkerCard {
  marker: CodeMarker = new CodeMarker(0, '', '');

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Stack() {
        Text(this.marker.id.toString())
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .width(32)
      .height(32)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(AppTokens.Shapes.small)

      Column({ space: 0 }) {
        Text(this.marker.name)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.marker.desc)
          .fontSize(AppTokens.Typography.body.fontSize)
          .fontWeight(AppTokens.Typography.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.Shadow.level1.radius,
      offsetY: AppTokens.Shadow.level1.y,
      color: `rgba(0, 0, 0, ${AppTokens.Shadow.level1.opacity})`
    })
  }
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { CodeMarker } from './CodeMarker';
import { CustomTopAppBar } from './CustomTopAppBar';
import { CodeMarkerCard } from './CodeMarkerCard';

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
    Column({ space: 0 }) {
      CustomTopAppBar({ title: 'CodeIDE Terminal' })

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Project Files')
            .fontSize(AppTokens.Typography.headline.fontSize)
            .fontWeight(AppTokens.Typography.headline.fontWeight)
            .fontColor(AppTokens.Colors.onBackground)

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.markers, (marker: CodeMarker) => {
              CodeMarkerCard({ marker: marker })
            }, (marker: CodeMarker) => marker.id.toString())
          }
          .width('100%')
          .padding({ bottom: AppTokens.Spacing.xl })

          Text('Live Terminal')
            .fontSize(AppTokens.Typography.headline.fontSize)
            .fontWeight(AppTokens.Typography.headline.fontWeight)
            .fontColor(AppTokens.Colors.onBackground)

          Stack({ alignContent: Alignment.TopStart }) {
            Column()
              .width('100%')
              .height(240)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: 1,
                color: AppTokens.Colors.outline,
                radius: AppTokens.Shapes.medium
              })

            Text('> println("Hello, Kotlin!")')
              .fontSize(AppTokens.Typography.body.fontSize)
              .fontWeight(AppTokens.Typography.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
          }
          .width('100%')

          Button('Run Code')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width('60%')
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Shadow.level1.radius,
              offsetY: AppTokens.Shadow.level1.y,
              color: `rgba(0, 0, 0, ${AppTokens.Shadow.level1.opacity})`
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.primary, 0.8],
          [AppTokens.Colors.surface, 0.9]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}