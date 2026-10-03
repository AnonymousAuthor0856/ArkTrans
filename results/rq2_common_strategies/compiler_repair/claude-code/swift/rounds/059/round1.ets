import promptAction from '@ohos.promptAction';

// MARK: - AppTokens
// Design tokens: colors, typography, shapes, spacing, and elevation shadows.
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF111827';
    export const secondary: string = '#FF374151';
    export const tertiary: string = '#FF6B7280';
    export const background: string = '#FFF9FAFB';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFE5E7EB';
    export const outline: string = '#FFD1D5DB';
    export const success: string = '#FF16A34A';
    export const warning: string = '#FFF59E0B';
    export const error: string = '#FFEF4444';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FFFFFFFF';
    export const onTertiary: string = '#FF111827';
    export const onBackground: string = '#FF111827';
    export const onSurface: string = '#FF1F2937';
  }

  export namespace Shapes {
    export const small: number = 8;
    export const medium: number = 12;
    export const large: number = 16;
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 36;
  }

  export interface ShadowSpec {
    radius: number;
    offsetY: number;
    opacity: number;
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { radius: 4, offsetY: 2, opacity: 0.12 };
    export const level2: ShadowSpec = { radius: 8, offsetY: 4, opacity: 0.14 };
    export const level3: ShadowSpec = { radius: 12, offsetY: 6, opacity: 0.16 };
  }
}

// MARK: - Data Model
interface Medicine {
  id: number;
  name: string;
  time: string;
}

// MARK: - MedicineItem Component
@Component
struct MedicineItem {
  @Prop medicine: Medicine;

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface);
        Text(this.medicine.time)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.onSurface);
      }
      .alignItems(HorizontalAlign.Start)
      .space(AppTokens.Spacing.xs);

      Blank();

      Circle({ width: 16, height: 16 })
        .fill(AppTokens.Colors.primary);
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
    });
  }
}

// MARK: - MedicineList Component
@Component
struct MedicineList {
  private items: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' },
  ];

  build() {
    Scroll() {
      Column() {
        ForEach(this.items, (item: Medicine) => {
          MedicineItem({ medicine: item });
        }, (item: Medicine) => item.id.toString());
      }
      .width('100%')
      .space(AppTokens.Spacing.md)
      .padding({ bottom: AppTokens.Spacing.xxl });
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%');
  }
}

// MARK: - RootScreen Component
@Entry
@Component
struct RootScreen {
  private bottomBarHeight: number = 56;

  build() {
    Stack() {
      // Main content area
      Column() {
        Column() {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground);

          MedicineList();

          Blank();

          Button('Mark All Taken')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .height(48)
            .width('80%')
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .margin({ bottom: AppTokens.Spacing.md })
            .onClick(() => {
              promptAction.showToast({ message: 'All medicines marked as taken' });
            });
        }
        .width('100%')
        .height('100%')
        .padding({
          top: AppTokens.Spacing.lg,
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
        })
        .linearGradient({
          colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]],
          direction: GradientDirection.Bottom,
        });
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
      .padding({ bottom: this.bottomBarHeight });

      // BottomAppBar
      Row() {
        Text('Today')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary);
        Blank();
        Text('History')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .onClick(() => {
            promptAction.showToast({ message: 'History' });
          });
        Blank();
        Text('Profile')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .onClick(() => {
            promptAction.showToast({ message: 'Profile' });
          });
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.offsetY,
      })
      .position({ x: 0, y: '100%' })
      .translate({ y: -this.bottomBarHeight });

      // FloatingActionButton
      Button('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(56)
        .height(56)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(28)
        .position({ x: '100%', y: '100%' })
        .translate({
          x: -(56 + AppTokens.Spacing.lg),
          y: -(56 + AppTokens.Spacing.lg + this.bottomBarHeight),
        })
        .onClick(() => {
          promptAction.showToast({ message: 'Add medicine' });
        });
    }
    .width('100%')
    .height('100%');
  }
}
