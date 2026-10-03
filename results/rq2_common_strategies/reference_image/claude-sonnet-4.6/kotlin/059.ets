// 088_MedicineReminder_en | Health ListDetail | Monochrome | en | 720x1280

const NAME: string = '088_MedicineReminder_en';
const UI_TYPE: string = 'Health ListDetail';
const STYLE_THEME: string = 'Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

interface AppColorTokens {
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

const AppColors: AppColorTokens = {
  primary: '#111827',
  secondary: '#374151',
  tertiary: '#6B7280',
  background: '#F9FAFB',
  surface: '#FFFFFF',
  surfaceVariant: '#E5E7EB',
  outline: '#D1D5DB',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#111827',
  onBackground: '#111827',
  onSurface: '#1F2937'
};

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

const AppSpacing: SpacingTokens = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 36
};

interface RadiusTokens {
  small: number;
  medium: number;
  large: number;
  full: number;
}

const AppRadius: RadiusTokens = {
  small: 8,
  medium: 12,
  large: 16,
  full: 28
};

interface Medicine {
  id: number;
  name: string;
  time: string;
}

@Entry
@Component
struct MedicineReminder {
  private medicines: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ];

  @State selectedTab: number = 0;

  @Builder
  medicineItem(m: Medicine) {
    Row() {
      Column() {
        Text(m.name)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(m.time)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column()
        .width(16)
        .height(16)
        .borderRadius(8)
        .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.medium)
    .border({ width: 1, color: AppColors.outline })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  bottomBarItem(label: string, index: number) {
    Text(label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
      .onClick(() => {
        this.selectedTab = index;
      })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomEnd }) {
        Column() {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .textAlign(TextAlign.Center)
            .width('100%')

          List({ space: AppSpacing.md }) {
            ForEach(this.medicines, (m: Medicine) => {
              ListItem() {
                this.medicineItem(m)
              }
            }, (m: Medicine) => m.id.toString())
          }
          .width('100%')
          .layoutWeight(1)
          .margin({ top: AppSpacing.lg })
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.Spring)

          Button('Mark All Taken', { type: ButtonType.Normal, stateEffect: true })
            .width('80%')
            .height(48)
            .borderRadius(AppRadius.large)
            .backgroundColor(AppColors.secondary)
            .fontColor(AppColors.onSecondary)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ top: AppSpacing.md })
            .onClick(() => {
            })
        }
        .width('100%')
        .height('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          angle: 180,
          colors: [[AppColors.surfaceVariant, 0.0], [AppColors.surface, 1.0]]
        })

        Column() {
          Text('+')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onPrimary)
            .textAlign(TextAlign.Center)
            .height(30)
        }
        .width(56)
        .height(56)
        .borderRadius(AppRadius.full)
        .backgroundColor(AppColors.primary)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ right: AppSpacing.xl, bottom: AppSpacing.xl })
        .shadow({ radius: 12, color: '#26000000', offsetX: 0, offsetY: 4 })
        .onClick(() => {
        })
      }
      .width('100%')
      .layoutWeight(1)

      Row() {
        this.bottomBarItem('Today', 0)
        this.bottomBarItem('History', 1)
        this.bottomBarItem('Profile', 2)
      }
      .width('100%')
      .height(72)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 8, color: '#24000000', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}