// Index.ets
// 由 SwiftUI 版 MedicineReminderApp 转译的 ArkTS/HarmonyOS 实现。
// 在 DevEco Studio 中打开本文件的 Previewer（或运行到模拟器/真机）即可看到与 SwiftUI 截图一致的界面。

import { window } from '@kit.ArkUI';

/** 设计令牌：颜色 */
class Colors {
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly tertiary: string = '#6B7280';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#111827';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
}

/** 设计令牌：字体 */
class TypographyTokens {
  static readonly displayLargeSize: number = 28;
  static readonly headlineMediumSize: number = 20;
  static readonly titleMediumSize: number = 16;
  static readonly bodyMediumSize: number = 14;
  static readonly labelMediumSize: number = 12;
}

/** 设计令牌：圆角 */
class Shapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

/** 设计令牌：间距 */
class Spacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

/** 阴影规格 */
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

/** 阴影层级映射 */
class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16);
}

/** 数据模型 */
class Medicine {
  id: number;
  name: string;
  time: string;

  constructor(id: number, name: string, time: string) {
    this.id = id;
    this.name = name;
    this.time = time;
  }
}

@Entry
@Component
struct Index {
  private items: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM')
  ];

  private readonly bottomBarHeight: number = 56;
  private readonly fabSize: number = 56;

  aboutToAppear(): void {
    // 对应 SwiftUI 的 .statusBarHidden(true)，让内容延伸到状态栏区域
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
      })
      .catch((err: Error) => {
        console.error(`setWindowLayoutFullScreen failed: ${err.message}`);
      });
  }

  /** 单个药品条目：对应 @Composable fun MedicineItem */
  @Builder
  MedicineItem(medicine: Medicine) {
    Row() {
      Column() {
        Text(medicine.name)
          .fontSize(TypographyTokens.titleMediumSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text(medicine.time)
          .fontSize(TypographyTokens.bodyMediumSize)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.onSurface)
          .margin({ top: Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Circle({ width: 16, height: 16 })
        .fill(Colors.primary)
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.medium)
    .border({ width: 1, color: Colors.outline, radius: Shapes.medium })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // 主内容区（Scaffold content）
      Column() {
        Text('Medicine Reminder')
          .fontSize(TypographyTokens.displayLargeSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
          .textAlign(TextAlign.Center)
          .margin({ bottom: Spacing.md })

        List({ space: Spacing.md }) {
          ForEach(this.items, (item: Medicine) => {
            ListItem() {
              this.MedicineItem(item)
            }
          }, (item: Medicine): string => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .backgroundColor(Color.Transparent)

        Button() {
          Text('Mark All Taken')
            .fontSize(TypographyTokens.titleMediumSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSecondary)
        }
        .type(ButtonType.Normal)
        .width('80%')
        .height(48)
        .borderRadius(Shapes.large)
        .backgroundColor(Colors.secondary)
        .margin({ top: Spacing.md, bottom: Spacing.md })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .padding({
        top: Spacing.lg,
        left: Spacing.lg,
        right: Spacing.lg,
        bottom: this.bottomBarHeight + Spacing.md
      })
      .linearGradient({
        angle: 180,
        colors: [[Colors.surfaceVariant, 0.0], [Colors.surface, 1.0]]
      })

      // BottomAppBar
      Row() {
        Text('Today')
          .fontSize(TypographyTokens.titleMediumSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)
        Blank()
        Text('History')
          .fontSize(TypographyTokens.titleMediumSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Blank()
        Text('Profile')
          .fontSize(TypographyTokens.titleMediumSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.surface)
      .shadow({
        radius: ElevationMapping.level2.radius,
        color: `rgba(0, 0, 0, ${ElevationMapping.level2.opacity})`,
        offsetX: 0,
        offsetY: ElevationMapping.level2.dy
      })

      // FloatingActionButton
      Button() {
        Text('+')
          .fontSize(TypographyTokens.displayLargeSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onPrimary)
      }
      .type(ButtonType.Circle)
      .width(this.fabSize)
      .height(this.fabSize)
      .borderRadius(this.fabSize / 2)
      .backgroundColor(Colors.primary)
      .margin({ right: Spacing.lg, bottom: Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}