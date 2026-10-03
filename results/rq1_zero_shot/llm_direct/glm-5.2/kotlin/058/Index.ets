// Build configuration: ohpm install @ohos/hypex

import { Length, Resource, RRect, BorderRadius } from '@ohos.arkui';
import { drawing } from '@kit.ArkGraphics2D';
import { common } from '@kit.AbilityKit';

interface AppTheme {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

class AppColors implements AppTheme {
  primary: ResourceColor = '#FF111827';
  secondary: ResourceColor = '#FF374151';
  tertiary: ResourceColor = '#FF6B7280';
  background: ResourceColor = '#FFF9FAFB';
  surface: ResourceColor = '#FFFFFFFF';
  surfaceVariant: ResourceColor = '#FFE5E7EB';
  outline: ResourceColor = '#FFD1D5DB';
  success: ResourceColor = '#FF16A34A';
  warning: ResourceColor = '#FFF59E0B';
  error: ResourceColor = '#FFEF4444';
  onPrimary: ResourceColor = '#FFFFFFFF';
  onSecondary: ResourceColor = '#FFFFFFFF';
  onTertiary: ResourceColor = '#FF111827';
  onBackground: ResourceColor = '#FF111827';
  onSurface: ResourceColor = '#FF1F2937';
}

const AppColorScheme: AppColors = new AppColors();

const NAME = "087_StepChallenge_en";
const UI_TYPE = "Health ControlPanel";
const STYLE_THEME = "Monochrome";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 36
};

const Typography = {
  display: { fontSize: 28, fontWeight: FontWeight.Bold },
  headline: { fontSize: 20, fontWeight: FontWeight.Medium },
  title: { fontSize: 16, fontWeight: FontWeight.Medium },
  body: { fontSize: 14, fontWeight: FontWeight.Normal },
  label: { fontSize: 12, fontWeight: FontWeight.Medium }
};

const Shapes = {
  small: 8,
  medium: 12,
  large: 16
};

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

const ElevationMapping = {
  level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 } as ShadowSpec,
  level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 } as ShadowSpec,
  level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 } as ShadowSpec
};

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];
  private swiperController: SwiperController = new SwiperController();

  build() {
    Column() {
      Column() {
        Text('Step Challenge')
          .fontSize(Typography.display.fontSize)
          .fontWeight(Typography.display.fontWeight)
          .fontColor(AppColorScheme.onBackground)
          .margin({ top: Spacing.lg, bottom: Spacing.lg });

        Row() {
          ForEach(this.tabs, (title: string, index: number) => {
            Column() {
              Text(title)
                .fontSize(Typography.title.fontSize)
                .fontWeight(Typography.title.fontWeight)
                .fontColor(this.currentIndex === index ? AppColorScheme.primary : AppColorScheme.onSurface)
                .margin({ top: Spacing.sm, bottom: Spacing.sm });

              Divider()
                .strokeWidth(2)
                .color(AppColorScheme.primary)
                .opacity(this.currentIndex === index ? 1 : 0)
                .width('40%');
            }
            .layoutWeight(1)
            .onClick(() => {
              this.currentIndex = index;
              this.swiperController.changeIndex(index);
            });
          }, (title: string) => title);
        }
        .width('100%')
        .borderRadius(Shapes.medium)
        .backgroundColor(AppColorScheme.surface)
        .margin({ bottom: Spacing.lg });

        Swiper(this.swiperController) {
          OverviewPage();
          RankingPage();
          StatsPage();
        }
        .index(this.currentIndex)
        .indicator(false)
        .loop(false)
        .layoutWeight(1)
        .onChange((index: number) => {
          this.currentIndex = index;
        });
      }
      .width('100%')
      .height('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .linearGradient({
        angle: 180,
        colors: [[AppColorScheme.surfaceVariant, 0.0], [AppColorScheme.surface, 1.0]]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColorScheme.background);
  }
}

@Component
struct OverviewPage {
  build() {
    Column({ space: Spacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(Typography.headline.fontSize)
        .fontWeight(Typography.headline.fontWeight)
        .fontColor(AppColorScheme.onSurface);

      Blank().height(Spacing.lg);

      Button('Sync Device')
        .type(ButtonType.Capsule)
        .backgroundColor(AppColorScheme.primary)
        .fontColor(AppColorScheme.onPrimary)
        .fontSize(Typography.title.fontSize)
        .fontWeight(Typography.title.fontWeight)
        .width('60%')
        .height(48);
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center);
  }
}

@Component
struct RankingPage {
  build() {
    Column({ space: Spacing.sm }) {
      ForEach([1, 2, 3, 4, 5], (it: number) => {
        Row() {
          Text(`User ${it}`)
            .fontColor(AppColorScheme.onSurface)
            .fontSize(Typography.body.fontSize);

          Text(`${9000 - (it - 1) * 500} steps`)
            .fontColor(AppColorScheme.onSurface)
            .fontSize(Typography.body.fontSize);
        }
        .width('100%')
        .padding(Spacing.md)
        .borderRadius(Shapes.medium)
        .backgroundColor(AppColorScheme.surfaceVariant)
        .justifyContent(FlexAlign.SpaceBetween);
      }, (it: number) => it.toString());
    }
    .width('100%')
    .height('100%')
    .padding({ top: Spacing.lg, bottom: Spacing.lg });
  }
}

@Component
struct StatsPage {
  build() {
    Column({ space: Spacing.sm }) {
      Text('Weekly Progress')
        .fontSize(Typography.headline.fontSize)
        .fontWeight(Typography.headline.fontWeight)
        .fontColor(AppColorScheme.onSurface)
        .margin({ bottom: Spacing.lg });

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Row() {
          Row()
            .width(`${Math.min(0.3 + it * 0.1, 1) * 100}%`)
            .height(20)
            .borderRadius(Shapes.small)
            .backgroundColor(AppColorScheme.primary);
        }
        .width('100%')
        .height(20)
        .borderRadius(Shapes.small)
        .backgroundColor(AppColorScheme.surfaceVariant);
      }, (it: number) => it.toString());
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding({ top: Spacing.lg, bottom: Spacing.lg });
  }
}