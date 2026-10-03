// AppColors
const PRIMARY_COLOR: string = '#2563EB';
const SECONDARY_COLOR: string = '#38BDF8';
const SURFACE_COLOR: string = '#FFFFFF';
const SURFACE_VARIANT_COLOR: string = '#E2E8F0';
const OUTLINE_COLOR: string = '#CBD5E1';
const ON_PRIMARY_COLOR: string = '#FFFFFF';
const ON_BACKGROUND_COLOR: string = '#0F172A';
const ON_SURFACE_COLOR: string = '#1E293B';

// AppTypography
const DISPLAY_SIZE: number = 24;
const DISPLAY_WEIGHT: FontWeight = FontWeight.Bold;
const HEADLINE_SIZE: number = 18;
const HEADLINE_WEIGHT: FontWeight = FontWeight.Medium;
const TITLE_SIZE: number = 14;
const TITLE_WEIGHT: FontWeight = FontWeight.Medium;
const BODY_SIZE: number = 12;
const BODY_WEIGHT: FontWeight = FontWeight.Normal;

// AppShapes
const SHAPE_SMALL: number = 6;
const SHAPE_MEDIUM: number = 10;
const SHAPE_LARGE: number = 14;

// AppSpacing
const SPACING_MD: number = 10;
const SPACING_LG: number = 14;
const BUTTON_HORIZONTAL: number = 16;
const BUTTON_VERTICAL: number = 8;

// MarkerBox Component
@Component
struct MarkerBox {
  unit: string = '';
  value: string = '';
  active: boolean = false;

  build() {
    Column() {
      Text(this.unit)
        .fontSize(HEADLINE_SIZE)
        .fontWeight(HEADLINE_WEIGHT)
        .fontColor(ON_SURFACE_COLOR)
        .margin({ bottom: 4 })
      Text(this.value)
        .fontSize(BODY_SIZE)
        .fontWeight(BODY_WEIGHT)
        .fontColor(ON_SURFACE_COLOR)
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding(SPACING_MD)
    .width('100%')
    .height(80)
    .backgroundColor(this.active ? 'rgba(56,189,248,0.3)' : SURFACE_COLOR)
    .borderRadius(SHAPE_MEDIUM)
    .border({ width: 1, color: OUTLINE_COLOR, radius: SHAPE_MEDIUM })
  }
}

// MapArea Component
@Component
struct MapArea {
  selected: string = '';

  build() {
    Column({ space: SPACING_MD }) {
      Text('Unit Map Visualization')
        .fontSize(HEADLINE_SIZE)
        .fontWeight(HEADLINE_WEIGHT)
        .fontColor(ON_SURFACE_COLOR)
      Text(`Active Unit: ${this.selected}`)
        .fontSize(BODY_SIZE)
        .fontWeight(BODY_WEIGHT)
        .fontColor(ON_SURFACE_COLOR)
    }
    .width('100%')
    .height(240)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(SURFACE_VARIANT_COLOR)
    .borderRadius(SHAPE_LARGE)
    .border({ width: 1, color: OUTLINE_COLOR, radius: SHAPE_LARGE })
    .padding(SPACING_LG)
  }
}

// UnitButton Component
@Component
struct UnitButton {
  label: string = '';
  isActive: boolean = false;
  onPress: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(TITLE_SIZE)
      .fontWeight(TITLE_WEIGHT)
      .fontColor(this.isActive ? ON_PRIMARY_COLOR : ON_SURFACE_COLOR)
      .backgroundColor(this.isActive ? PRIMARY_COLOR : SURFACE_VARIANT_COLOR)
      .borderRadius(SHAPE_SMALL)
      .padding({
        left: BUTTON_HORIZONTAL,
        right: BUTTON_HORIZONTAL,
        top: BUTTON_VERTICAL,
        bottom: BUTTON_VERTICAL,
      })
      .onClick(() => {
        this.onPress();
      })
  }
}

// RootScreen
@Entry
@Component
struct RootScreen {
  markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];
  @State active: string = 'Length';

  build() {
    Column({ space: SPACING_LG }) {
      Text('Unit Converter')
        .fontSize(DISPLAY_SIZE)
        .fontWeight(DISPLAY_WEIGHT)
        .fontColor(ON_BACKGROUND_COLOR)
        .margin({ top: 20 })

      MapArea({ selected: this.active })

      ForEach(this.markers, (marker: string) => {
        MarkerBox({
          unit: marker,
          value: 'Tap to convert',
          active: this.active === marker,
        })
      }, (marker: string) => marker)

      Blank().height(SPACING_MD)

      Row({ space: SPACING_MD }) {
        ForEach(this.markers, (marker: string) => {
          UnitButton({
            label: marker,
            isActive: this.active === marker,
            onPress: () => {
              this.active = marker;
            },
          })
        }, (marker: string) => marker)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .padding(SPACING_LG)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .linearGradient({
      angle: 180,
      colors: [
        ['rgba(56,189,248,0.15)', 0.0],
        ['rgba(37,99,235,0.15)', 1.0],
      ],
    })
  }
}