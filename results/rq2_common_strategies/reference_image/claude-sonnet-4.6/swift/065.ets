```ts
/**
 * Asset Inventory — ArkTS / ArkUI port of the SwiftUI screen.
 * Drop into: entry/src/main/ets/pages/Index.ets
 */

// ---------------------------------------------------------------------------
// Design tokens (AppTokens)
// ---------------------------------------------------------------------------
const COLOR_PRIMARY: string = '#111111';
const COLOR_SECONDARY: string = '#2A2A2A';
const COLOR_TERTIARY: string = '#474747';
const COLOR_BACKGROUND: string = '#F6F6F6';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#EDEDED';
const COLOR_OUTLINE: string = '#D1D1D1';
const COLOR_SUCCESS: string = '#2E7D32';
const COLOR_WARNING: string = '#B98900';
const COLOR_ERROR: string = '#B3261E';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SURFACE: string = '#0A0A0A';
const COLOR_PLACEHOLDER: string = '#9A9A9A';

const FONT_DISPLAY: number = 28;
const FONT_HEADLINE: number = 20;
const FONT_TITLE: number = 16;
const FONT_BODY: number = 14;
const FONT_LABEL: number = 12;

const SPACE_XS: number = 4;
const SPACE_SM: number = 8;
const SPACE_MD: number = 12;
const SPACE_LG: number = 16;
const SPACE_XL: number = 24;

const RADIUS_SMALL: number = 8;
const RADIUS_MEDIUM: number = 12;
const RADIUS_LARGE: number = 16;

const TOP_BAR_HEIGHT: number = 86;
const MAP_HEIGHT: number = 460;

// Elevation mapping (Compose elevation -> shadow spec)
class ShadowSpec {
  radius: number;
  dy: number;
  color: string;

  constructor(radius: number, dy: number, color: string) {
    this.radius = radius;
    this.dy = dy;
    this.color = color;
  }
}

const SHADOW_LEVEL1: ShadowSpec = new ShadowSpec(4, 2, '#1A000000');
const SHADOW_LEVEL2: ShadowSpec = new ShadowSpec(8, 4, '#24000000');

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------
interface AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;
}

// ---------------------------------------------------------------------------
// Marker (circle + label chip), absolutely positioned by the parent
// ---------------------------------------------------------------------------
@Component
struct MarkerDot {
  markerType: string = 'Device';
  @Prop selected: boolean = false;
  onToggle: () => void = () => {};

  private dotColor(): string {
    if (this.markerType === 'Warehouse') {
      return COLOR_TERTIARY;
    }
    if (this.markerType === 'Device') {
      return COLOR_SECONDARY;
    }
    return COLOR_PRIMARY;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // the dot
      Column()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .borderRadius(this.selected ? 14 : 11)
        .backgroundColor(this.dotColor())
        .border({ width: 2, color: this.selected ? COLOR_PRIMARY : COLOR_SURFACE })

      // the label chip
      Text(this.markerType)
        .fontSize(FONT_LABEL)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
        .padding({
          left: SPACE_SM,
          right: SPACE_SM,
          top: SPACE_XS,
          bottom: SPACE_XS
        })
        .backgroundColor(COLOR_SURFACE)
        .borderRadius(RADIUS_SMALL)
        .border({ width: 1, color: COLOR_OUTLINE })
        .shadow({
          radius: SHADOW_LEVEL1.radius,
          color: SHADOW_LEVEL1.color,
          offsetX: 0,
          offsetY: SHADOW_LEVEL1.dy
        })
        .offset({ x: 18, y: -4 })
        .onClick(() => {
          this.onToggle();
        })
    }
  }
}

// ---------------------------------------------------------------------------
// Main screen
// ---------------------------------------------------------------------------
@Entry
@Component
struct AssetInventoryScreen {
  @State categories: string[] = ['Warehouse', 'Device', 'Office'];
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office'];
  @State assetName: string = '';
  @State assetCode: string = '';
  @State assetType: string = 'Device';
  @State selectedId: number = -1; // -1 == nil
  @State mapW: number = 0;
  @State mapH: number = 0;

  private gridColumns: number[] = [0, 1, 2, 3, 4, 5, 6];
  private gridRows: number[] = [0, 1, 2, 3, 4, 5];

  private markers: AssetMarker[] = [
    { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
    { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
    { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
    { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 }
  ];

  // ---- helpers -------------------------------------------------------------
  private isCatOn(cat: string): boolean {
    return this.enabledCats.indexOf(cat) >= 0;
  }

  private toggleCategory(cat: string): void {
    const idx: number = this.enabledCats.indexOf(cat);
    const next: string[] = this.enabledCats.slice();
    if (idx >= 0) {
      next.splice(idx, 1);
    } else {
      next.push(cat);
    }
    this.enabledCats = next;
  }

  private visibleMarkers(): AssetMarker[] {
    const out: AssetMarker[] = [];
    for (let i = 0; i < this.markers.length; i++) {
      const m: AssetMarker = this.markers[i];
      if (this.enabledCats.indexOf(m.type) >= 0) {
        out.push(m);
      }
    }
    return out;
  }

  private selectedName(): string {
    for (let i = 0; i < this.markers.length; i++) {
      if (this.markers[i].id === this.selectedId) {
        return this.markers[i].name;
      }
    }
    return 'None';
  }

  private resetForm(): void {
    this.assetName = '';
    this.assetCode = '';
    this.assetType = 'Device';
    this.selectedId = -1;
  }

  // ---- header --------------------------------------------------------------
  @Builder
  topBar() {
    Column() {
      Text('Asset Inventory')
        .fontSize(FONT_DISPLAY)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)
    }
    .width('100%')
    .height(TOP_BAR_HEIGHT)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
  }

  // ---- filter chips --------------------------------------------------------
  @Builder
  chipRow() {
    Scroll() {
      Row({ space: SPACE_SM }) {
        ForEach(this.categories, (c: string) => {
          Text(c)
            .fontSize(this.isCatOn(c) ? FONT_TITLE : FONT_BODY)
            .fontWeight(this.isCatOn(c) ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(this.isCatOn(c) ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
            .padding({
              left: SPACE_MD,
              right: SPACE_MD,
              top: SPACE_SM,
              bottom: SPACE_SM
            })
            .backgroundColor(this.isCatOn(c) ? COLOR_PRIMARY : COLOR_SURFACE)
            .borderRadius(RADIUS_SMALL)
            .border({
              width: 1,
              color: this.isCatOn(c) ? COLOR_PRIMARY : COLOR_OUTLINE
            })
            .onClick(() => {
              this.toggleCategory(c);
            })
        }, (c: string) => c)
      }
      .padding({ right: SPACE_LG })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(44)
    .align(Alignment.Start)
  }

  // ---- text field ----------------------------------------------------------
  @Builder
  field(placeholder: string, value: string, which: number) {
    TextInput({ placeholder: placeholder, text: value })
      .type(InputType.Normal)
      .placeholderColor(COLOR_PLACEHOLDER)
      .placeholderFont({ size: FONT_BODY })
      .fontSize(FONT_BODY)
      .fontColor(COLOR_ON_SURFACE)
      .caretColor(COLOR_PRIMARY)
      .height(44)
      .width('100%')
      .backgroundColor(COLOR_SURFACE_VARIANT)
      .borderRadius(RADIUS_SMALL)
      .border({ width: 1, color: COLOR_OUTLINE })
      .padding({ left: SPACE_MD, right: SPACE_MD })
      .onChange((v: string) => {
        if (which === 0) {
          this.assetName = v;
        } else if (which === 1) {
          this.assetCode = v;
        } else {
          this.assetType = v;
        }
      })
  }

  // ---- selected asset card -------------------------------------------------
  @Builder
  selectedCard() {
    Column() {
      Text('Selected')
        .fontSize(FONT_LABEL)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
      Text(this.selectedName())
        .fontSize(FONT_HEADLINE)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
        .margin({ top: SPACE_SM })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(SPACE_LG)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(RADIUS_LARGE)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow({
      radius: SHADOW_LEVEL1.radius,
      color: SHADOW_LEVEL1.color,
      offsetX: 0,
      offsetY: SHADOW_LEVEL1.dy
    })
  }

  // ---- left column ---------------------------------------------------------
  @Builder
  leftColumn() {
    Column({ space: SPACE_MD }) {
      this.field('Asset Name', this.assetName, 0)
      this.field('Asset Code', this.assetCode, 1)
      this.field('Asset Type', this.assetType, 2)
      this.selectedCard()
    }
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
  }

  // ---- grid overlay --------------------------------------------------------
  @Builder
  gridOverlay() {
    Stack() {
      // horizontal lines
      Column() {
        ForEach(this.gridRows, (item: number) => {
          Divider()
            .strokeWidth(1)
            .color(COLOR_SURFACE_VARIANT)
            .width('100%')
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 20, right: 20, top: 28, bottom: 28 })

      // vertical lines
      Row() {
        ForEach(this.gridColumns, (item: number) => {
          Divider()
            .vertical(true)
            .strokeWidth(1)
            .color(COLOR_SURFACE_VARIANT)
            .height('100%')
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 20, right: 20, top: 28, bottom: 28 })
    }
    .width('100%')
    .height('100%')
  }

  // ---- map -----------------------------------------------------------------
  @Builder
  mapArea() {
    Stack({ alignContent: Alignment.TopStart }) {
      this.gridOverlay()

      ForEach(this.visibleMarkers(), (m: AssetMarker) => {
        MarkerDot({
          markerType: m.type,
          selected