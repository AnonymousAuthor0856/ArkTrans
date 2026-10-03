import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility } from '@kit.AbilityKit';

// MARK: - AppTokens Interfaces
interface ColorToken {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ElevationToken {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMapping {
  level1: ElevationToken;
  level2: ElevationToken;
  level3: ElevationToken;
}

// MARK: - AppTokens
// 集中管理所有设计令牌，方便原子级修改和保持双平台一致性。
export class AppTokens {
  static Colors: ColorToken = {
    primary: '#007BFF',
    secondary: '#6C757D',
    tertiary: '#17A2B8',
    background: '#F8F9FA',
    surface: '#FFFFFF',
    surfaceVariant: '#E9ECEF',
    outline: '#DEE2E6',
    success: '#28A745',
    warning: '#FFC107',
    error: '#DC3545',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#212529',
    onSurface: '#212529'
  };

  static TypographyTokens: TypographyTokens = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 28, weight: FontWeight.Medium }, // SemiBold not available in standard ArkTS, using Medium
    title: { size: 22, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Normal },
    label: { size: 14, weight: FontWeight.Medium }
  };

  static Shapes: ShapeToken = {
    small: 4,
    medium: 8,
    large: 12
  };

  static Spacing: SpacingToken = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static ElevationMapping: ElevationMapping = {
    level1: { elevation: 1, radius: 3, dy: 1, opacity: 0.1 },
    level2: { elevation: 3, radius: 6, dy: 2, opacity: 0.1 },
    level3: { elevation: 6, radius: 10, dy: 4, opacity: 0.1 }
  };
}

// MARK: - Data Models
export interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
}

@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24.0;

  // 模拟 Compose 中的 remember { listOf(...) }
  private clipboardItems: ClipboardItem[] = [
    { id: 1, content: "https://www.example.com/modern-design", type: "Link", timestamp: "5 min ago", progress: 0.2 },
    { id: 2, content: "Final project review notes have been updated.", type: "Text", timestamp: "23 min ago", progress: 0.5 },
    { id: 3, content: "#007BFF", type: "Color", timestamp: "1 hour ago", progress: 0.8 },
    { id: 4, content: "Meeting at 3 PM with the design team.", type: "Text", timestamp: "3 hours ago", progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: "File", timestamp: "Yesterday", progress: 1.0 }
  ];

  build() {
    Column() {
      // 自定义顶部栏，模拟 CenterAlignedTopAppBar
      Row() {
        Text("Clipboard History")
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Button("Clear")
          .onClick(() => {
            console.info("Clear button tapped");
          })
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 0.5, color: new Color('#000000').withAlpha(0.05), offsetY: 0.5 })

      // 内容区域，模拟 LazyColumn
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item });
          }, (item: ClipboardItem) => item.id.toString())
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .backgroundColor(AppTokens.Colors.background)
      .layoutWeight(1)

      // 设置面板
      SettingsPane({ sliderValue: $sliderValue })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: new Color('#000000').withAlpha(AppTokens.ElevationMapping.level2.opacity),
          offsetY: -AppTokens.ElevationMapping.level2.dy
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .safeArea({ right: true, left: true })
  }
}

@Component
struct ClipboardCard {
  @Prop item: ClipboardItem;

  aboutToAppear() {
    // Initialization if needed
  }

  build() {
    Column({ space: 0 }) {
      Row({ space: AppTokens.Spacing.sm }) {
        // 模拟 Box + clip + background
        Rect()
          .fill(AppTokens.Colors.primary)
          .width(24)
          .height(24)
          .borderRadius(AppTokens.Shapes.small)

        Text(this.item.type)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.primary)
          .fontWeight(FontWeight.Bold)

        Blank().layoutWeight(1)

        Text(this.item.timestamp)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .margin({ bottom: AppTokens.Spacing.sm })

      Text(this.item.content)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: AppTokens.Spacing.md })

      // 线性进度指示器
      Progress({ value: this.item.progress, total: 1, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(AppTokens.Colors.tertiary)
        .trackColor(new Color(AppTokens.Colors.surfaceVariant))
        .borderRadius(AppTokens.Shapes.small)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.surfaceVariant, radius: AppTokens.Shapes.large })
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: new Color('#000000').withAlpha(AppTokens.ElevationMapping.level1.opacity),
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

@Component
struct SettingsPane {
  @Link sliderValue: number;

  build() {
    Column({ space: 0 }) {
      Row() {
        Text("History Limit (Hours)")
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank().layoutWeight(1)

        Text(`${Math.round(this.sliderValue)}`)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontWeight(FontWeight.Medium) // SemiBold not available, using Medium
          .fontColor(AppTokens.Colors.onSurface)
      }
      .margin({ bottom: AppTokens.Spacing.sm })

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1
      })
        .width('100%')
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(new Color(AppTokens.Colors.surfaceVariant))
        .blockColor(AppTokens.Colors.primary)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
  }
}