import window from '@ohos.window';
import common from '@ohos.app.ability.common';

const NAME: string = '088_MedicineReminder_en';
const UI_TYPE: string = 'Health ListDetail';
const STYLE_THEME: string = 'Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: ResourceColor = '#111827';
  static readonly secondary: ResourceColor = '#374151';
  static readonly tertiary: ResourceColor = '#6B7280';
  static readonly background: ResourceColor = '#F9FAFB';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#E5E7EB';
  static readonly outline: ResourceColor = '#D1D5DB';
  static readonly success: ResourceColor = '#16A34A';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#EF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#111827';
  static readonly onBackground: ResourceColor = '#111827';
  static readonly onSurface: ResourceColor = '#1F2937';
}

class TextToken {
  fontSize: number;
  fontWeight: FontWeight;

  constructor(fontSize: number, fontWeight: FontWeight) {
    this.fontSize = fontSize;
    this.fontWeight = fontWeight;
  }
}

class AppTypographyTokens {
  static readonly display: TextToken = new TextToken(28, FontWeight.Bold);
  static readonly headline: TextToken = new TextToken(20, FontWeight.Medium);
  static readonly title: TextToken = new TextToken(16, FontWeight.Medium);
  static readonly body: TextToken = new TextToken(14, FontWeight.Regular);
  static readonly label: TextToken = new TextToken(12, FontWeight.Medium);
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

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

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16);
}

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

@Component
struct MedicineItem {
  @Prop medicine: Medicine = new Medicine(0, '', '');

  build() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(this.medicine.name)
          .fontSize(AppTypographyTokens.title.fontSize)
          .fontWeight(AppTypographyTokens.title.fontWeight)
          .fontColor(AppColors.onSurface)

        Text(this.medicine.time)
          .fontSize(AppTypographyTokens.body.fontSize)
          .fontWeight(AppTypographyTokens.body.fontWeight)
          .fontColor(AppColors.onSurface)
      }

      Blank()
        .width(16)
        .height(16)
        .borderRadius(8)
        .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppShapes.medium
    })
  }
}

@Component
struct MedicineList {
  private items: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM')
  ];

  build() {
    List({ space: AppSpacing.md }) {
      ForEach(this.items, (item: Medicine) => {
        ListItem() {
          MedicineItem({ medicine: item })
        }
        .width('100%')
      }, (item: Medicine) => item.id.toString())

      ListItem() {
        Blank()
          .height(AppSpacing.xxl)
      }
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

@Entry
@Component
struct RootScreen {
  aboutToAppear(): void {
    window.getLastWindow(getContext(this) as common.UIAbilityContext).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  onPageShow(): void {
    window.getLastWindow(getContext(this) as common.UIAbilityContext).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  build() {
    Stack() {
      Column({ space: AppSpacing.md }) {
        Text('Medicine Reminder')
          .fontSize(AppTypographyTokens.display.fontSize)
          .fontWeight(AppTypographyTokens.display.fontWeight)
          .fontColor(AppColors.onBackground)

        MedicineList()
          .layoutWeight(1)

        Blank()
          .height(AppSpacing.md)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Mark All Taken')
            .fontSize(AppTypographyTokens.title.fontSize)
            .fontWeight(AppTypographyTokens.title.fontWeight)
            .fontColor(AppColors.onSecondary)
        }
        .width('80%')
        .height(48)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.secondary)
      }
      .width('100%')
      .height('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: 120
      })
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.surfaceVariant, 0.0],
          [AppColors.surface, 1.0]
        ]
      })

      Row() {
        Text('Today')
          .fontSize(AppTypographyTokens.title.fontSize)
          .fontWeight(AppTypographyTokens.title.fontWeight)
          .fontColor(AppColors.primary)

        Text('History')
          .fontSize(AppTypographyTokens.title.fontSize)
          .fontWeight(AppTypographyTokens.title.fontWeight)
          .fontColor(AppColors.onSurface)

        Text('Profile')
          .fontSize(AppTypographyTokens.title.fontSize)
          .fontWeight(AppTypographyTokens.title.fontWeight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(72)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: AppElevationMapping.level2.radius,
        color: '#24000000',
        offsetX: 0,
        offsetY: -AppElevationMapping.level2.dy
      })
      .align(Alignment.Bottom)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('+')
          .fontSize(AppTypographyTokens.display.fontSize)
          .fontWeight(AppTypographyTokens.display.fontWeight)
          .fontColor(AppColors.onPrimary)
      }
      .width(56)
      .height(56)
      .backgroundColor(AppColors.primary)
      .shadow({
        radius: AppElevationMapping.level2.radius,
        color: '#24000000',
        offsetX: 0,
        offsetY: AppElevationMapping.level2.dy
      })
      .margin({
        right: AppSpacing.xl,
        bottom: 88
      })
      .align(Alignment.BottomEnd)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}