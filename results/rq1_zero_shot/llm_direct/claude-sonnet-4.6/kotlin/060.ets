import { router } from '@kit.ArkUI';

// Design tokens
const AppColors = {
  primary: '#2563EB',
  secondary: '#38BDF8',
  tertiary: '#60A5FA',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#CBD5E1',
  onPrimary: '#FFFFFF',
  onSecondary: '#0F172A',
  onTertiary: '#FFFFFF',
  onBackground: '#0F172A',
  onSurface: '#1E293B',
};

const AppSpacing = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 20,
};

const AppRadius = {
  small: 6,
  medium: 10,
  large: 14,
};

const AppFontSize = {
  display: 24,
  headline: 18,
  title: 14,
  body: 12,
};

@Component
struct MarkerBox {
  unit: string = '';
  value: string = '';
  active: boolean = false;

  build() {
    Row() {
      Column() {
        Text(this.unit)
          .fontSize(AppFontSize.headline)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ bottom: 4 })
        Text(this.value)
          .fontSize(AppFontSize.body)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(80)
    .backgroundColor(this.active ? '#4DD8F8' : AppColors.surface)
    .borderRadius(AppRadius.medium)
    .border({ width: 1, color: AppColors.outline })
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MapArea {
  selected: string = '';

  build() {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(AppFontSize.headline)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.md })
      Text(`Active Unit: ${this.selected}`)
        .fontSize(AppFontSize.body)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(240)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppRadius.large)
    .border({ width: 1, color: AppColors.outline })
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];
  @State active: string = 'Length';

  build() {
    Scroll() {
      Column({ space: AppSpacing.lg }) {
        Text('Unit Converter')
          .fontSize(AppFontSize.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)

        MapArea({ selected: this.active })

        ForEach(this.markers, (item: string) => {
          MarkerBox({
            unit: item,
            value: 'Tap to convert',
            active: this.active === item
          })
        }, (item: string) => item)

        Blank().height(AppSpacing.md)

        Row({ space: AppSpacing.md }) {
          ForEach(this.markers, (item: string) => {
            Button(item)
              .fontSize(AppFontSize.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.active === item ? AppColors.onPrimary : AppColors.onSurface)
              .backgroundColor(this.active === item ? AppColors.primary : AppColors.surfaceVariant)
              .borderRadius(AppRadius.medium)
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .onClick(() => {
                this.active = item;
              })
          }, (item: string) => item)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .flexWrap(FlexWrap.Wrap)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#26D8F8', 0.0],
        ['#2663EB', 1.0]
      ]
    })
  }
}