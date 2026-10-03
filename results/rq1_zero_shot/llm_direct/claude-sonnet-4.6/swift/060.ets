import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens
namespace AppTokens {
  export namespace Colors {
    export const primary = '#FF2563EB';
    export const secondary = '#FF38BDF8';
    export const tertiary = '#FF60A5FA';
    export const background = '#FFF8FAFC';
    export const surface = '#FFFFFFFF';
    export const surfaceVariant = '#FFE2E8F0';
    export const outline = '#FFCBD5E1';
    export const onPrimary = '#FFFFFFFF';
    export const onSecondary = '#FF0F172A';
    export const onTertiary = '#FFFFFFFF';
    export const onBackground = '#FF0F172A';
    export const onSurface = '#FF1E293B';
  }

  export namespace Typography {
    export const displaySize = 24;
    export const headlineSize = 18;
    export const titleSize = 14;
    export const bodySize = 12;
  }

  export namespace Shapes {
    export const small = 6;
    export const medium = 10;
    export const large = 14;
  }

  export namespace Spacing {
    export const sm = 6;
    export const md = 10;
    export const lg = 14;
    export const xl = 20;
    export const buttonContentHorizontal = 16;
    export const buttonContentVertical = 8;
  }
}

// MARK: - MarkerBox Component
@Component
struct MarkerBox {
  @Prop unit: string = '';
  @Prop value: string = '';
  @Prop active: boolean = false;

  build() {
    Column({ space: 4 }) {
      Text(this.unit)
        .fontSize(AppTokens.Typography.headlineSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
      Text(this.value)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .height(80)
    .backgroundColor(
      this.active
        ? '#4D38BDF8'
        : AppTokens.Colors.surface
    )
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.medium
    })
  }
}

// MARK: - MapArea Component
@Component
struct MapArea {
  @Prop selected: string = '';

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(AppTokens.Typography.headlineSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
      Text(`Active Unit: ${this.selected}`)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height(240)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.large
    })
    .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
  }
}

// MARK: - UnitButton Component
@Component
struct UnitButton {
  @Prop label: string = '';
  @Prop isActive: boolean = false;
  onTap: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(AppTokens.Typography.titleSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(
        this.isActive
          ? AppTokens.Colors.onPrimary
          : AppTokens.Colors.onSurface
      )
      .backgroundColor(
        this.isActive
          ? AppTokens.Colors.primary
          : AppTokens.Colors.surfaceVariant
      )
      .borderRadius(AppTokens.Shapes.small)
      .padding({
        left: AppTokens.Spacing.buttonContentHorizontal,
        right: AppTokens.Spacing.buttonContentHorizontal,
        top: AppTokens.Spacing.buttonContentVertical,
        bottom: AppTokens.Spacing.buttonContentVertical
      })
      .onClick(() => {
        this.onTap();
      })
  }
}

// MARK: - RootScreen Component
@Entry
@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];
  @State private active: string = 'Length';

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      Text('Unit Converter')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)

      MapArea({ selected: this.active })

      ForEach(this.markers, (marker: string) => {
        MarkerBox({
          unit: marker,
          value: 'Tap to convert',
          active: this.active === marker
        })
      }, (marker: string) => marker)

      Row()
        .height(AppTokens.Spacing.md)

      Row({ space: AppTokens.Spacing.md }) {
        ForEach(this.markers, (marker: string) => {
          UnitButton({
            label: marker,
            isActive: this.active === marker,
            onTap: () => {
              this.active = marker;
            }
          })
        }, (marker: string) => marker)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#2638BDF8', 0.0],
        ['#262563EB', 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}